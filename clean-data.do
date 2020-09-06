
// Clean Ultra-Low Emissions Vehicles Licensed End-of-Quarter
import excel "data/vehicle-license/veh0130.xlsx", sheet("VEH0130") cellrange(A7:U44) firstrow ///
case(lower) clear
drop in 1
replace quarter = "2010 Q1" in 1
gen year_qtr = quarterly(quarter, "YQ")
format %tq year_qtr
expand 3
sort year_qtr
drop quarter
bysort year_qtr: gen year_month = mofd(dofq(year_qtr)) + _n - 1
format %tm year_month
missings dropvars , force
rename total lic_ulev
label var lic_ulev "ULEV licenses"
destring *, replace

tempfile ulev_lic_by_qrt
save `ulev_lic_by_qrt'

// Clean All Licensed Vehicles Data
import excel "data/vehicle-license/veh0101.xlsx", sheet("VEH0101") case(lower) ///
cellrange(A9:J109) firstrow clear
destring cars-j , replace force
missings dropvars , force
drop total
gen year_qtr = quarterly(quarter, "YQ")
format %tq year_qtr
expand 3
sort year_qtr
bysort year_qtr: gen year_month = mofd(dofq(year_qtr)) + _n - 1
format %tm year_month
drop quarter j
rename i lic_veh_ttl 
label var lic_veh_ttl "Total licensed vehicles"
// Licenses originally in thousands, convert
replace lic_veh_ttl = lic_veh_ttl * 1000

merge 1:1 year_month using `ulev_lic_by_qrt' , nogenerate

gen ulev_per = (lic_ulev/lic_veh_ttl) * 100
label var ulev_per "ULEV (%)"

keep year_qtr year_month lic_veh_ttl lic_ulev ulev_per
save "data/vehicle-license/vehicle-licenses.dta", replace

// Clean and collapse casualties to accident/vehicle level
local files : dir "data/road-safety/" files "*casualt*.csv"
cd "data/road-safety/"
csvconvert ., input_file(`files') output_file(casualties.dta) replace
cd "../../"
replace accident_index = Acc_Index if mi(accident_index)
replace accident_index = Accident_Index if mi(accident_index)
gen cyc = (casualty_type == 1) & !mi(casualty_type)
label var cyc "Cyclist Injury"
gen drv = (casualty_class == 1) & !mi(casualty_class)
label var drv "Driver Injury"
gen psng = (casualty_class == 2) & !mi(casualty_class)
label var psng "Passenger Injury"
gen ped = (casualty_class == 3) & !mi(casualty_class)
label var ped "Pedestrian Injury"
gen fatal = (casualty_severity == 1) & !mi(casualty_severity)
label var fatal "Fatal Injury"
gen severe = (casualty_severity == 2) & !mi(casualty_severity)
label var severe "Severe Injury"
gen slight = (casualty_severity == 3) & !mi(casualty_severity)
label var slight "Slight Injury"
gen cs = (cyc * slight)
label var cs "Cyclist Slight Injury"
gen csf = (cyc * severe) + (cyc * fatal)
label var csf "Cyclist Severe/Fatal Injury"
gen drvs = (drv * slight)
label var drvs "Driver Slight Injury"
gen drvsf = (drv * severe) + (drv * fatal)
label var drvsf "Driver Severe/Fatal Injury"
gen psngs = (psng * slight)
label var psngs "Passenger Slight Injury"
gen psngsf = (psng * severe) + (psng * fatal)
label var psngsf "Passenger Severe/Fatal Injury"
gen ps = (ped * slight)
label var ps "Pedestrian Slight Injury"
gen psf = (ped * severe) + (ped * fatal)
label var psf "Pedestrian Severe/Fatal Injury"

gcollapse (sum) cyc drv ped psng cs csf drvs drvsf psngs psngsf ps psf /// 
, by(accident_index vehicle_reference) fast unsorted labelformat(#sourcelabel# #Stat#)

save "data/road-safety/casualties.dta", replace

// Clean accidents data
local files : dir "data/road-safety/" files "*accidents*.csv"
cd "data/road-safety"
csvconvert ., input_file(`files') output_file(accidents.dta) replace
cd "../../"
replace accident_index = Accident_Index if mi(accident_index)
drop _csvfile Accident_Index
save "data/road-safety/accidents.dta", replace

// Clean vehicles data
local files : dir "data/road-safety/" files "*vehicles*.csv"
cd "data/road-safety"
csvconvert ., input_file(`files') output_file(vehicles.dta) replace
cd "../.."
replace accident_index = Acc_Index if mi(accident_index)
replace accident_index = Accident_Index if mi(accident_index)
drop Acc_Index Accident_Index _csvfile

// Merge accidents, casualties, vehicles files
merge m:1 accident_index using "data/road-safety/accidents.dta", nogenerate
merge 1:1 accident_index vehicle_reference using "data/road-safety/casualties.dta", nogenerate 

notes drop _all

// Gen Date, Month, Year
rename date date1
gen date = date(date1, "DMY")
gen year = year(date)

// Drop years before 2000
count if inrange(year, 1979, 1999) == 1 | mi(year)
note: `: di %9.0fc `r(N)'' obs dropped between 1979 and 1999.
drop if inrange(year, 1979, 1999) == 1 | mi(year)

format date %td
drop date1
gen hour = substr(time, 1, 2)
gen minute = substr(time, 4, 2)
drop time
destring hour minute, replace force
gen month = month(date)
gen year_month = mofd(date)

// Decode -1 missing value code 
mvdecode _all , mv(-1)  

// Apply value labels
do "do-files/data-cleaning/apply-value-labels.do"


***************************************************************************************************
// Link cyclist to unique causing vehicle

/* 

Cyclist casualties (injuries) originally assigned to the cyclist not to the vehicle that hit them. Cyclists
are considered vehicles in the original dataset. For the purposes of the current research, we would like
to know which type of vehicle (HEV or ICE) hit the cyclist. For accidents with only two vehicles involved
(one being the cyclist), we can determine which vehicle hit the cyclist and reassign the cyclist casualty 
to the correct vehicle before estimating a model. 

*/

// Reassign cyclist injury to vehicles that hit them
foreach x in cyc cs csf {
	bysort accident_index: egen `x'_max = max(`x')
	replace `x' = `x'_max if `x'_max > 0 & number_of_vehicles == 2
}

// Number of cyclist injuries matched to a vehicle
count if number_of_vehicles == 2 & vehicle_type == 1 & drvs != .
local cyc_mtch_veh_cnt = `r(N)'

// Number of cyc injuries not matched to a vehicle
count if number_of_vehicles != 2 & vehicle_type == 1 & drvs != .
local cyc_nomtch_veh_cnt = `r(N)'
scalar cyc_nomtch_veh_per	= (`cyc_nomtch_veh_cnt' / `cyc_mtch_veh_cnt') * 100
scalar cyc_nomtch_veh_per_str = trim("`: display %9.1fc scalar(cyc_nomtch_veh_per)'%")
note: `: di scalar(cyc_nomtch_veh_per_str)' of cyclists not matched to vehicle that hit them and dropped.

// Make other inj variables non-missing for vehicles that hit cyc
foreach x in cyc drv ped psng drvs drvsf psngs psngsf ps psf {
	replace `x' = 0 if cs_max > 0 & `x' == . & number_of_vehicles == 2
	replace `x' = 0 if csf_max > 0 & `x' == . & number_of_vehicles == 2
}

// Remove orginal cyc vehicles
drop if vehicle_type == 1

***************************************************************************************************

count
local n = `r(N)'
// Remove damage only vehicles
drop if drvs == .

count
scalar damage_only_veh_cnt = `n' - `r(N)'
note: `: di %9.0fc scalar(damage_only_veh_cnt)' damage-only vehicles dropped.

// Merge vehicle licenses data
merge m:1 year_month using "data/vehicle-license/vehicle-licenses.dta", keep(match master) ///
nogenerate

***************************************************************************************************
// Gen new variables

// Vehicle maneuver
rename vehicle_manoeuvre vehicle_maneuver
rename vehicle_maneuver vehicle_maneuver2
recode vehicle_maneuver2 (1 = 1 "Reversing") (2 = 2 "Parked") (3 = 3 "Waiting to go") ///
(4 = 4 "Slowing or stopping") (5 = 5 "Moving off") (6 7 8 9 10 = 6 "Turning") (11 12 = 7 "Changing lane") ///
(13 14 15 = 8 "Overtaking vehicle") (16 17 18 = 9 "Going ahead"), gen(vehicle_maneuver)
drop vehicle_maneuver2
label var vehicle_maneuver "Vehicle Maneuver"
label val vehicle_maneuver vehicle_maneuver

// Left hand drive
gen left_hand_drive = (was_vehicle_left_hand_drive == 2) & !mi(was_vehicle_left_hand_drive)
label var left_hand_drive "Left Hand Drive"

// Driver's age
recode age_band_of_driver (1 2 3 4 5 = 1 "0-25 yrs") (6 7 8 = 2 "25-55 yrs") (9 10 11 = 3 "55+ yrs"), gen(driver_age)
label var driver_age "Driver Age"
drop age_band_of_driver

// Hybrid electric
gen hev = (propulsion_code == 3 | propulsion_code == 8) if !mi(propulsion_code) 
label var hev "HEV"

// Hybrid
gen hyb = (propulsion_code == 8) if !mi(propulsion_code)
label var hyb "Hybrid"

// Electric
gen elec = (propulsion_code == 3) if !mi(propulsion_code)
label var elec "Electric"

// Road type
rename road_type road_type2
recode road_type2 (1 = 1 "Roundabout") (3 = 2 "Dual carriageway") (6 = 3 "Single carriageway") (2 7 9 = 0 "Other"), gen(road_type)
drop road_type2
label var road_type "Road Type"
label val road_type road_type

// Speed limit
count if speed_limit < 20 | speed_limit == 25
scalar speed_limit_dropped = `r(N)'
note: `: di %9.0fc scalar(speed_limit_dropped)' observations with speed limit less than 25.
replace speed_limit = recode(speed_limit, 20, 30, 40, 50, 60, 70)
label var speed_limit "Speed Limit (MPH)"

// Pedestrian human control
gen ped_human_control = (pedestrian_crossinghuman_control == 1) & !mi(pedestrian_crossinghuman_control)
label var ped_human_control "Pedestrian Crossing Human Control"
label define ped_human_control 0 "No" 1 "Yes"
label values ped_human_control ped_human_control
drop pedestrian_crossinghuman_control

// Pedestrian crosswalk
gen crosswalk = (pedestrian_crossingphysical_faci != 0) & !mi(pedestrian_crossingphysical_faci)
label var crosswalk "Pedestrian Crosswalk"
drop pedestrian_crossingphysical_faci

// Daylight
gen daylight = (light_conditions == 1) & !mi(light_conditions)
drop light_conditions
label var daylight "Daylight"

// Weekday
gen weekday = (day_of_week == 2 | day_of_week == 3 | day_of_week == 4 | day_of_week == 5 | day_of_week == 6)
label var weekday "Weekday"

// Friday or saturday
gen weekend = (day_of_week == 6 | day_of_week == 7)
label var weekend "Weekend"

// Friday or Saturday night
gen weekend_night = (day_of_week == 6 & daylight == 0 | day_of_week == 7 & daylight == 0)
label var weekend_night "Weekend Night"
drop day_of_week

// Weather
rename weather_conditions weather_conditions2
recode weather_conditions2 (1 4 = 1 "Fine") (2 5 = 2 "Raining") (3 6 = 3 "Snowing") (7 = 4 "Fog or mist") (8 9 = 0 "Other"), gen(weather_conditions)
drop weather_conditions2
label var weather_conditions "Weather Conditions"
label val weather_conditions weather_conditions

// Dry road
gen dry_road = (road_surface_conditions == 1) &  !mi(road_surface_conditions)
drop road_surface_conditions
label var dry_road "Dry Road"

// Special conditions at site
recode special_conditions_at_site (0 = 0) (1 2 3 4 5 6 7 = 1), gen(special_conditions)
drop special_conditions_at_site
label var special_conditions "Special Conditions"

// Carriageway hazards
recode carriageway_hazards (0 = 0) (1 2 3 4 5 6 7 = 1), gen(carriageway_hazards2)
drop carriageway_hazards
rename carriageway_hazards2 carriageway_hazards
label var carriageway_hazards "Carriageway Hazards"

// Urban
gen urban = (urban_or_rural_area == 1) & !mi(urban_or_rural_area)
label var urban "Urban"

// Police attended scene
gen police_attended_scene = (did_police_officer_attend_scene_ == 1) & !mi(did_police_officer_attend_scene_)
label var police_attended_scene "Police Attended Scene"

// Taxi
gen taxi = (vehicle_type == 21 | vehicle_type == 5) & !mi(vehicle_type)
label var taxi "Taxi"

// Driver injuries by month & district
bysort local_authority_district year_month: egen drv_sum = total(drv)

// Driver severe/fatal injuries by month and district
bysort local_authority_district year_month: egen drvsf_sum = total(drvsf)

// Driver Severe/Fatal Injury %
gen drvsf_per = (drvsf_sum / drv_sum) * 100
label var drvsf_per "Driver Severe/Fatal Injury (%)"
drop drv_sum 
drop drvsf_sum

// Gen Season variables
recode month (12 1 2 = 1 "Winter") (3 4 5 = 2 "Spring") (6 7 8 = 3 "Summer") (9 10 11 = 4 "Fall"), gen(season)
label var season "Season"
label val season season

// Calculate % of vehicles causing multiple ped injuries out of all vehicles causing ped injuires
count if ped > 1
local mult_ped_cnt = `r(N)'
qui su ped
local ped_cnt = `r(sum)'
scalar mult_ped_per = 100 * (`mult_ped_cnt' / `ped_cnt')

// Binarize inj categories
foreach x in cyc drv psng ped cs csf ps psf drvs drvsf psngs psngsf {
	replace `x' = (`x' > 0) & !mi(`x')
	
	// Remove 'sum' from inj variables label after binarize
	local label : var label `x'
	local newlabel = substr(`"`label'"', 1, length(`"`label'"') - 4)
	label var `x' `"`newlabel'"'
}

// Label variables
label var accident_index "Accident ID"
label var vehicle_reference "Vehicle referene"
label var date "Date"
label var year "Year"

// Remove unneeded variables
drop accident_severity 
drop vehicle_type 
drop towing_and_articulation 
drop vehicle_locationrestricted_lane
drop a_1st_point_of_impact
drop journey_purpose_of_driver
drop driver_imd_decile
drop driver_home_area_type
drop vehicle_imd_decile
drop location_easting_osgr 
drop location_northing_osgr
drop longitude 
drop latitude
drop local_authority_district 
drop local_authority_highway 
drop a_1st_road_class 
drop a_1st_road_number
drop junction_detail 
drop junction_control 
drop a_2nd_road_class 
drop a_2nd_road_number 
drop lsoa_of_accident_location
drop did_police_officer_attend_scene_
drop age_of_vehicle 
drop propulsion_code 
drop was_vehicle_left_hand_drive 
drop junction_location 
drop cyc_max 
drop sex_of_driver 
drop skidding_and_overturning 
drop hit_object_in_carriageway 
drop vehicle_leaving_carriageway
drop hit_object_off_carriageway 
drop engine_capacity_cc
drop csf_max 
drop cs_max
drop hour 
drop lic_ulev 
drop lic_veh_ttl 
drop minute 
drop month 
drop number_of_vehicles 
drop police_force 
drop urban_or_rural_area
drop year_month
drop year_qtr
***************************************************************************************************

// Order variables alphabetically
order *, alpha
order accident_index vehicle_reference date, first
sort accident_index vehicle_reference

save "data/cleaned-data.dta", replace
