
// Clean road-safety data

/*
Collapse data at the casualty (injury), accident, and vehicle 
level to the vehicle level. So each observation corresponds 
to a unique vehicle and contains information on the type(s) 
of casualties associated with each vehicle 
(pedestrian, cyclist, driver, passenger) and characteristics
surrounding the accident (ex. weather, year, age of driver, etc.)
*/


// Gen Date, Month, Year
rename date date1
gen date = date(date1, "DMY")
gen year = year(date)

// Drop years before 2000
count if inrange(year, 1979, 1999) == 1
note: `: di %9.0fc `r(N)'' obs dropped between 1979 and 1999.
drop if inrange(year, 1979, 1999) == 1

format date %td
drop date1
gen hour = substr(time, 1, 2)
gen minute = substr(time, 4, 2)
drop time
destring hour minute, replace force
gen month = month(date)

// Decode -1 missing value code 
mvdecode _all , mv(-1)  

// Apply value labels
do "do-files/data-cleaning/apply-value-labels.do"

// Generate casualty dummies before collpase by vehicle
gen cyclist = (casualty_type == 2) & !mi(casualty_type)
gen driver = (casualty_class == 1) & !mi(casualty_class)
gen passenger = (casualty_class == 2) & !mi(casualty_class)
gen pedestrian = (casualty_class == 3) & !mi(casualty_class)

gen fatal = (casualty_severity == 1) & !mi(casualty_severity)
gen severe = (casualty_severity == 2) & !mi(casualty_severity)
gen slight = (casualty_severity == 3) & !mi(casualty_severity)

gen cyc_slight_injury = (cyclist * slight)
gen cyc_sf_injury = (cyclist * severe) + (cyclist * fatal)
gen driver_slight_injury = (driver * slight)
gen driver_sf_injury = (driver * severe) + (driver * fatal)
gen pssngr_slight_injury = (passenger * slight)
gen pssngr_sf_injury = (passenger * severe) + (passenger * fatal)
gen ped_slight_injury = (pedestrian * slight)
gen ped_sf_injury = (pedestrian * severe) + (pedestrian * fatal)

// Macro name length limited to 31 
// Find vars with length exceeding 25
findname, any(length("@") > 29) varwidth(32) alpha

// Rename vars with length over 29
rename did_police_officer_attend_scene_  did_police_officer_attend
rename vehicle_locationrestricted_lane vehicle_restricted_lane
rename pedestrian_road_maintenance_work pedestrian_road_maintenance
rename pedestrian_crossinghuman_control  ped_crossinghuman_control
rename pedestrian_crossingphysical_faci ped_crossingphysical_faci

// Save Variable Labels, if no label set to var name
foreach v of var * {
	local l`v' : variable label `v'
	if `"`l`v''"' == "" { 
		local l`v' = proper("`v'")
	}
}

gcollapse (sum) cyc_slight_injury cyc_sf_injury ///
driver_slight_injury driver_sf_injury pssngr_slight_injury ///
pssngr_sf_injury ped_slight_injury ped_sf_injury ///
, by(acc_index vehicle_reference) fast merge replace unsorted

// Reassign saved variable labels
foreach v of var * {
	capture label var `v' "`l`v''"
}

ds acc_index vehicle_reference location_easting_osgr location_northing_osgr longitude latitude ///
local_authority_highway a_1st_road_class a_1st_road_number junction_control a_2nd_road_class ///
a_2nd_road_number lsoa_of_accident_location driver_imd_decile driver_home_area_type ///
casualty_reference casualty_class sex_of_casualty age_band_of_casualty ///
casualty_type casualty_home_area_type age_of_casualty vehicle_imd_decile casualty_imd_decile, not	
collapse (first) `r(varlist)', by(acc_index vehicle_reference) fast

// Reassign saved variable labels
foreach v of var * {
	capture label var `v' "`l`v''"
}

// Apply value labels
do "do-files/data-cleaning/apply-value-labels.do"
