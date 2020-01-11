
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
gen cyc_inj = (casualty_type == 1) & !mi(casualty_type)
label var cyc_inj "Cyclist Injury"
gen drv_inj = (casualty_class == 1) & !mi(casualty_class)
label var drv_inj "Driver Injury"
gen pssngr_inj = (casualty_class == 2) & !mi(casualty_class)
label var pssngr_inj "Passenger Injury"
gen ped_inj = (casualty_class == 3) & !mi(casualty_class)
label var ped_inj "Pedestrian Injury"
gen fatal = (casualty_severity == 1) & !mi(casualty_severity)
label var fatal "Fatal injury"
gen severe = (casualty_severity == 2) & !mi(casualty_severity)
label var severe "Severe Injury"
gen slight = (casualty_severity == 3) & !mi(casualty_severity)
label var slight "Slight Injury"
gen cyc_slight_inj = (cyc_inj * slight)
label var cyc_slight_inj "Cyclist Slight Injury"
gen cyc_serious_inj = (cyc_inj * severe) + (cyc_inj * fatal)
label var cyc_serious_inj "Cyclist Serious Injury"
gen drv_slight_inj = (drv_inj * slight)
label var drv_slight_inj "Driver Slight Injury"
gen drv_serious_inj = (drv_inj * severe) + (drv_inj * fatal)
label var drv_serious_inj "Driver Serious Injury"
gen pssngr_slight_inj = (pssngr_inj * slight)
label var pssngr_slight_inj "Passenger Slight Injury"
gen pssngr_serious_inj = (pssngr_inj * severe) + (pssngr_inj * fatal)
label var pssngr_serious_inj "Passenger Serious Injury"
gen ped_slight_inj = (ped_inj * slight)
label var ped_slight_inj "Pedestrian Slight Injury"
gen ped_serious_inj = (ped_inj * severe) + (ped_inj * fatal)
label var ped_serious_inj "Pedestrian Serious Injury"

gcollapse (sum) cyc_inj drv_inj ped_inj pssngr_inj cyc_slight_inj cyc_serious_inj /// 
drv_slight_inj drv_serious_inj pssngr_slight_inj pssngr_serious_inj ped_slight_inj ped_serious_inj ///
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
merge 1:1 accident_index vehicle_reference using "data/road-safety/casualties.dta", nogenerate ///

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

// Link Cyclist to Vehicle

/* 

Cyclist casualties (injuries) originally assigned to the cyclist not to the vehicle that hit them. Cyclists
are considered vehicles in the original dataset. For the purposes of the current research, we would like
to know which type of vehicle (HEV or ICE) hit the cyclist. For accidents with only two vehicles involved
(one being the cyclist), we can determine which vehicle hit the cyclist and reassign the cyclist casualty 
to the correct vehicle before estimating a model. 

*/

// Reassign cyclist casualty to vehicles that hit them
foreach x in cyc_inj cyc_slight_inj cyc_serious_inj {
	bysort accident_index: egen `x'_max = max(`x')
	replace `x' = `x'_max if `x'_max > 0 & number_of_vehicles == 2
}

// Number of cyclist injuries matched to a vehicle
count if number_of_vehicles == 2 & vehicle_type == 1 & drv_slight_inj != .
local cyc_inj_mtch_veh_cnt = `r(N)'

// Number of cyclist injuries not matched to a vehicle
count if number_of_vehicles != 2 & vehicle_type == 1 & drv_slight_inj != .
local cyc_inj_nomtch_veh_cnt = `r(N)'
scalar cyc_inj_nomtch_veh_per	= (`cyc_inj_nomtch_veh_cnt' / `cyc_inj_mtch_veh_cnt') * 100
scalar cyc_inj_nomtch_veh_per_str = trim("`: display %9.1fc scalar(cyc_inj_nomtch_veh_per)'%")
note: `: di scalar(cyc_inj_nomtch_veh_per_str)' of cyclists not matched to vehicle that hit them and dropped.

// Make other injury variables non-missing for vehicles that hit cyclist
foreach x in cyc_inj drv_inj ped_inj pssngr_inj drv_slight_inj drv_serious_inj ///
pssngr_slight_inj pssngr_serious_inj ped_slight_inj ped_serious_inj {
	replace `x' = 0 if cyc_slight_inj_max > 0 & `x' == . & number_of_vehicles == 2
	replace `x' = 0 if cyc_serious_inj_max > 0 & `x' == . & number_of_vehicles == 2
}

// Remove orginal cyclist vehicles
drop if vehicle_type == 1

count
local n = `r(N)'
// Remove damage only vehicles
drop if drv_slight_inj == .

count
scalar damage_only_veh_cnt = `n' - `r(N)'
note: `: di %9.0fc scalar(damage_only_veh_cnt)' damage-only vehicles dropped.

// Merge vehicle licenses data
merge m:1 year_month using "data/vehicle-license/vehicle-licenses.dta", keep(match master) ///
nogenerate

// Gen new variables

// Vehicle manoeuvre
gen reversing = (vehicle_manoeuvre == 1) & !mi(vehicle_manoeuvre)
label var reversing "Reversing"
gen slowing = (vehicle_manoeuvre == 4) & !mi(vehicle_manoeuvre)
label var slowing "Slowing"
gen moving_off = (vehicle_manoeuvre == 5) & !mi(vehicle_manoeuvre)
label var moving_off "Moving Off"
gen turning = (vehicle_manoeuvre == 6 | vehicle_manoeuvre == 7 | vehicle_manoeuvre == 9) if ///
! mi(vehicle_manoeuvre)
label var turning "Turning"

gen left_hand_drive = (was_vehicle_left_hand_drive == 2) & !mi(was_vehicle_left_hand_drive)
label var left_hand_drive "Left hand drive"

// Age of driver
// Drivers aged 66+
gen old_driver = (age_band_of_driver >= 10) if !mi(age_band_of_driver) 
label var old_driver "Old driver"
// Drivers aged 36-65
gen mid_age_driver = (age_band_of_driver > 6 & age_band_of_driver < 10) if !mi(age_band_of_driver) 
label var mid_age_driver "Mid-age driver"
// Drivers age 35 & younger
gen young_driver = (age_band_of_driver <= 6) if !mi(age_band_of_driver)
label var young_driver "Young driver"

// Vehicle propulsion
gen hyb_elec = (propulsion_code == 3 | propulsion_code == 8) if !mi(propulsion_code) 
label var hyb_elec "HEV"
gen hyb = (propulsion_code == 8) if !mi(propulsion_code)
label var hyb "Hybrid"
gen elec = (propulsion_code == 3) if !mi(propulsion_code)
label var elec "Electric"

// Road type
gen roundabout = (road_type == 1) & !mi(road_type)
label var roundabout "Roundabout"
gen oneway_street = (road_type == 2) & !mi(road_type)
label var oneway_street "Oneway Street"

// Speed limit
gen speed_low = (speed_limit <=30 ) if !mi(speed_limit)
label var speed_low "Low Speed"
gen speed_med = (speed_limit > 30 & speed_limit <= 50) if !mi(speed_limit)
label var speed_med "Medium Speed"
gen speed_high = (speed_limit > 50) if !mi(speed_limit)
label var speed_high "High Speed"

gen ped_cross_human_ctrl = (pedestrian_crossinghuman_control == 1) & !mi(pedestrian_crossinghuman_control)
label var ped_cross_human_ctrl "Pedestrian Human Control"
gen ped_cross_facilities = (pedestrian_crossingphysical_faci != 0) & !mi(pedestrian_crossingphysical_faci)
label var ped_cross_facilities "Pedestrian Crosswalk"
gen dark = (light_conditions != 1) & !mi(light_conditions)
label var dark "Dark"

// Gen Weekday, Weekend, & Weekend night indicators
// Monday-Friday
gen weekday = (day_of_week == 2 | day_of_week == 3 | day_of_week == 4 | day_of_week == 5 | day_of_week == 6)
label var weekday "Weekday"
// Friday or saturday
gen weekend = (day_of_week == 6 | day_of_week == 7)
label var weekend "Weekend"
// Friday or Saturday night
gen weekend_night = (day_of_week == 6 & dark == 1 | day_of_week == 7 & dark == 1)
label var weekend_night "Weekend Night"

// Weather
gen rain = (weather_conditions == 2 | weather_conditions == 5) & !mi(weather_conditions)
label var rain "Rain"
gen fog = (weather_conditions == 7) & !mi(weather_conditions)
label var fog "Fog"

gen slippery_road = (road_surface_conditions != 1) & !mi(road_surface_conditions)
label var slippery_road "Slippery Road"
gen special_cond_at_site = (special_conditions_at_site != 0) & !mi(special_conditions_at_site)
label var special_cond_at_site "Special Condition at Site"
gen carriageway_hazard = (carriageway_hazards != 0) & !mi(carriageway_hazards)
label var carriageway_hazard "Carriageway hazard"

gen urban = (urban_or_rural == 1) & !mi(urban_or_rural)
label var urban "Urban"
gen police_attended_scene = (did_police_officer_attend_scene == 1) & !mi(did_police_officer_attend_scene)
label var police_attended_scene "Police Attended Scene"
gen taxi = (vehicle_type == 21 | vehicle_type == 5) & !mi(vehicle_type)
label var taxi "Taxi"

// Gen number of driver injuries by month & area
bysort local_authority_district year_month: egen drv_inj_by_mth_and_dist = total(drv_inj)
bysort local_authority_district year_month: egen drv_serious_inj_by_mth_and_dist = total(drv_serious_inj)

gen drv_serious_inj_per = (drv_serious_inj_by_mth_and_dist / drv_inj_by_mth_and_dist) * 100
label var drv_serious_inj_per "Driver serious injury (%)"

// Gen Season variables
gen winter = (month == 12 | month == 1 | month == 2) if !mi(month)
label var winter "Winter"
gen spring = (month == 3 | month == 4 | month == 5) if !mi(month)
label var spring "Spring"
gen summer = (month == 6 | month == 7 | month == 8) if !mi(month)
label var summer "Summer"
gen fall = (month == 9 | month == 10 | month == 11) if !mi(month)
label var fall "Fall"

// Calculate % of vehicles causing multiple ped injuries out of all vehicles causing ped injuires
count if ped_inj > 1
local mult_ped_inj_cnt = `r(N)'
qui su ped_inj
local ped_inj_cnt = `r(sum)'
scalar mult_ped_inj_per = 100 * (`mult_ped_inj_cnt' / `ped_inj_cnt')

// Binarize injury categories
foreach x in cyc_inj drv_inj pssngr_inj ped_inj cyc_slight_inj cyc_serious_inj ///
drv_slight_inj drv_serious_inj pssngr_slight_inj pssngr_serious_inj ///
ped_slight_inj ped_serious_inj {
	replace `x' = (`x' > 0) & !mi(`x')
	
	// Remove 'sum' from injury variables label after binarize
	local label : var label `x'
	local newlabel = substr(`"`label'"', 1, length(`"`label'"') - 4)
	label var `x' `"`newlabel'"'
}

label var accident_index "Accident ID"
label var vehicle_reference "Vehicle referene"
label var date "Date"
label var engine_capacity_cc "Engine capacity (cc)"
label var hour "Hour"
label var minute "Minute"
label var month "Month"
label var number_of_casualties "Number of injuries"
label var number_of_vehicles "Number of vehicles"
label var police_force "Police force"
label var year "Year"
label var year_month "Year-month date"
label var year_qtr "Year-quarter date"

drop accident_severity vehicle_type towing_and_articulation vehicle_locationrestricted_lane ///
a_1st_point_of_impact journey_purpose_of_driver driver_imd_decile driver_home_area_type ///
vehicle_imd_decile location_easting_osgr location_northing_osgr longitude latitude ///
local_authority_district local_authority_highway a_1st_road_class a_1st_road_number ///
junction_detail junction_control a_2nd_road_class a_2nd_road_number lsoa_of_accident_location ///
carriageway_hazards urban_or_rural did_police_officer_attend_scene special_conditions_at_site ///
road_surface_conditions weather_conditions day_of_week light_conditions ///
pedestrian_crossinghuman_control pedestrian_crossingphysical_faci speed_limit road_type ///
age_of_vehicle propulsion_code age_of_driver age_band_of_driver ///
sex_of_driver was_vehicle_left_hand_drive vehicle_manoeuvre drv_inj_by_mth_and_dist ///
drv_serious_inj_by_mth_and_dist junction_location cyc_inj_max sex_of_driver age_of_vehicle ///
skidding_and_overturning hit_object_in_carriageway vehicle_leaving_carriageway ///
hit_object_off_carriageway

// Order variables alphabetically
order *, alpha
order accident_index vehicle_reference date, first
sort accident_index vehicle_reference

save "data/cleaned-data.dta", replace
