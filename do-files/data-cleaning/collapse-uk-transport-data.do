
// Collapse UK Transport Data

/*
Collapse data at the casualty (injuries), accident, and vehicle 
level to the vehicle level. So each observation corresponds 
to a unique vehicle and contains information on the type(s) 
of casualties associated with each vehicle 
(pedestrian, cyclist, driver, passenger) and characteristics
surrounding the accident (ex. weather, year, age of driver, etc.)
*/

// Gen Date, Month, Year
rename date date1
gen hour = substr(time,1,2)
gen minute = substr(time,4,2)
drop time
destring hour minute , replace force
gen date = date(date1, "DMY")
format date %td
drop date1
gen year = year(date)
gen month = month(date)

// Decode -1 missing value code 
mvdecode _all , mv(-1)  

// Define value labels for casualty vars
label define casualty_class 1 `"Driver or rider"', modify
label define casualty_class 2 `"Passenger"', modify
label define casualty_class 3 `"Pedestrian"', modify
label define casualty_type	0	"Pedestrian", modify
label define casualty_type	1	"Cyclist", modify
label define casualty_type	2	"Motorcycle 50cc and under rider or passenger", modify
label define casualty_type	3	"Motorcycle 125cc and under rider or passenger", modify
label define casualty_type	4	"Motorcycle over 125cc and up to 500cc rider or  passenger", modify
label define casualty_type	5	"Motorcycle over 500cc rider or passenger", modify
label define casualty_type	8	"Taxi/Private hire car occupant", modify
label define casualty_type	9	"Car occupant", modify
label define casualty_type	10	"Minibus (8 - 16 passenger seats) occupant", modify
label define casualty_type	11	"Bus or coach occupant (17 or more pass seats)", modify
label define casualty_type	16	"Horse rider", modify
label define casualty_type	17	"Agricultural vehicle occupant", modify
label define casualty_type	18	"Tram occupant", modify
label define casualty_type	19	"Van / Goods vehicle (3.5 tonnes mgw or under) occupant", modify
label define casualty_type	20	"Goods vehicle (over 3.5t. and under 7.5t.) occupant", modify
label define casualty_type	21	"Goods vehicle (7.5 tonnes mgw and over) occupant", modify
label define casualty_type	22	"Mobility scooter rider", modify
label define casualty_type	23	"Electric motorcycle rider or passenger", modify
label define casualty_type	90	"Other vehicle occupant", modify
label define casualty_type	97	"Motorcycle - unknown cc rider or passenger", modify
label define casualty_type	98	"Goods vehicle (unknown weight) occupant", modify
label define casualty_type	103	"Motorcycle - Scooter rider or passenger", modify
label define casualty_type	104	"Motorcycle rider or passenger", modify
label define casualty_type	105	"Motorcycle - Combination rider or passenger", modify
label define casualty_type	106	"Motorcycle over 125cc rider or passenger", modify
label define casualty_type	108	"Taxi (excluding private hire cars) occupant", modify
label define casualty_type	109	"Car occupant (including private hire cars)", modify
label define casualty_type	110	"Minibus/Motor caravan occupant" , modify
label define casualty_type	113	"Goods vehicle (over 3.5 tonnes) occupant" , modify

label value casualty_type casualty_type 
label value casualty_class casualty_class

// Generate casualty dummies before collpase by vehicle
local vars "casualty_class casualty_type"

foreach x in `vars' {
	tabulate `x' , gen(`x')
}

rename casualty_class1 driver
rename casualty_class2 passenger
rename casualty_class3 pedestrian
rename casualty_type1 pedestrian_dup
rename casualty_type2 cyclist
rename casualty_type3 motocyc50
rename casualty_type4 motocyc125
rename casualty_type5 motocyc125p
rename casualty_type6 motocyc500p
rename casualty_type7 taxi
rename casualty_type8 occupant1
rename casualty_type9 minibus1
rename casualty_type10 bus
rename casualty_type11 jockey
rename casualty_type12 agvehocc
rename casualty_type13 tramocc
rename casualty_type14 goodsveh1
rename casualty_type15 goodsveh2
rename casualty_type16 goodsveh3
rename casualty_type17 mobilscoot
rename casualty_type18 elecmotocyc
rename casualty_type19 othervehocc
rename casualty_type20 othermotocyc
rename casualty_type21 othergoodsveh
rename casualty_type22 motocycscootpass
rename casualty_type23 motocycriderpass
rename casualty_type24 motocyccomb
rename casualty_type25 motocyc125p_riderpass
rename casualty_type26 taxinotprivate
rename casualty_type27 occupant2
rename casualty_type28 minibus2
rename casualty_type29 goodsvehocc

// Gen total number of casualties by vehicle (tot_cyclist not invluded)
foreach x in driver pedestrian passenger cyclist {
	egen tot_`x' = sum(`x') , by(acc_index vehicle_reference)
}

// Macro name length limited to 31 
// Find vars with length exceeding 25
findname, any(length("@") > 29) varwidth(32) alpha

// Rename vars with length over 29
rename did_police_officer_attend_scene_  did_police_officer_attend
rename vehicle_locationrestricted_lane vehicle_restricted_lane
rename pedestrian_road_maintenance_work pedestrian_road_maintenance
rename pedestrian_crossinghuman_control  ped_crossinghuman_control
rename pedestrian_crossingphysical_faci ped_crossingphysical_faci

// Gen causalty severity by casualty group 
gen driver_casualty_severity = casualty_severity if driver == 1
gen ped_casualty_severity = casualty_severity if pedestrian == 1
gen cyc_casualty_severity = casualty_severity if cyclist == 1

// Drop years before 2000
drop if inrange(year, 1979, 1999) == 1

// Save Variable Labels, if no label set to var name
foreach v of var * {
	local l`v' : variable label `v'
	if `"`l`v''"' == "" { 
		local l`v' = proper("`v'")
	}
}

// Collapse by unique vehicle
ds acc_index vehicle_reference driver passenger pedestrian pedestrian_dup ///
cyclist motocyc50 motocyc125 motocyc125p motocyc500p taxi occupant1 minibus1  /// 
bus jockey agvehocc tramocc goodsveh1 goodsveh2 goodsveh3 mobilscoot elecmotocyc  /// 
othervehocc othermotocyc othergoodsveh motocycscootpass motocycriderpass motocyccomb  /// 
motocyc125p_riderpass taxinotprivate occupant2 minibus2 goodsvehocc  /// 
driver_casualty_severity ped_casualty_severity cyc_casualty_severity , not	

collapse (first) `r(varlist)' (max) driver passenger pedestrian pedestrian_dup ///
cyclist motocyc50 motocyc125 motocyc125p motocyc500p taxi occupant1 minibus1 ///
 bus jockey agvehocc tramocc goodsveh1 goodsveh2 goodsveh3 mobilscoot ///
 elecmotocyc othervehocc othermotocyc othergoodsveh motocycscootpass motocycriderpass /// 
 motocyccomb motocyc125p_riderpass taxinotprivate occupant2 minibus2 goodsvehocc /// 
 (min) driver_casualty_severity ped_casualty_severity ///
 cyc_casualty_severity , by(acc_index vehicle_reference) fast

// Reassign saved variable labels
foreach v of var * {
	capture label var `v' "`l`v''"
}
