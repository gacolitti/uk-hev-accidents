
****************************************************************************************************


* Gen Vars

****************************************************************************************************

// Tab gen cat vars
qui {
foreach x in special_conditions_at_site carriageway_hazards ped_crossinghuman_control ped_crossingphysical_faci light_conditions weather_conditions urban_or_rural_area age_band_of_driver day_of_week vehicle_type road_surface_conditions road_type vehicle_manoeuvre {

		tabulate `x' if !mi(`x'), gen(`x') 
	
	}
		
	rename special_conditions_at_site1 special_condition_none
	rename special_conditions_at_site2 traffic_signal_out
	rename special_conditions_at_site3 auto_signal_defective
	rename special_conditions_at_site4 road_sign_defective
	rename special_conditions_at_site5 roadworks
	rename special_conditions_at_site6 road_surface_defective
	rename special_conditions_at_site7 special_condition_oil
	rename special_conditions_at_site8 special_condition_mud
	rename carriageway_hazards1 carriageway_hazards_none
	rename carriageway_hazards2 vehicle_load_on_road
	rename carriageway_hazards3 object_on_road
	rename carriageway_hazards4 previous_accident
	rename carriageway_hazards5 pedestrian_in_carriageway
	rename carriageway_hazards6 animal_in_carriageway
	rename ped_crossinghuman_control1 ped_crossing_human_none
	rename ped_crossinghuman_control2 school_crossing_patrol
	rename ped_crossinghuman_control3 authorised_person_control
	rename ped_crossingphysical_faci1 physical_crossing_none
	rename ped_crossingphysical_faci2 physical_crossing_zebra
	rename ped_crossingphysical_faci3 physical_control_nonjunction
	rename ped_crossingphysical_faci4 ped_at_traffic_signal
	rename ped_crossingphysical_faci5 footbridge_subway
	rename ped_crossingphysical_faci6 central_refuge
	rename light_conditions1 daylight
	rename light_conditions2 dakness_lights_lit
	rename light_conditions3 darkness_lights_unlit
	rename light_conditions4 darkness_no_light
	rename light_conditions5 darkness_light_unkown
	rename weather_conditions1 weather_fine
	rename weather_conditions2 rain_no_wind
	rename weather_conditions3 snow_no_wind
	rename weather_conditions4 fine_high_wind
	rename weather_conditions5 rain_high_wind
	rename weather_conditions6 snow_high_wind
	rename weather_conditions7 fog
	rename weather_conditions8 weather_other
	rename weather_conditions9 weather_unknown
	rename urban_or_rural_area1 urban
	rename urban_or_rural_area2 rural
	rename urban_or_rural_area3 unallocated
	rename age_band_of_driver1 dage0_5
	rename age_band_of_driver2 dage6_10
	rename age_band_of_driver3 dage11_15
	rename age_band_of_driver4 dage16_20
	rename age_band_of_driver5 dage21_25
	rename age_band_of_driver6 dage26_35
	rename age_band_of_driver7 dage36_45
	rename age_band_of_driver8 dage46_55
	rename age_band_of_driver9 dage56_65
	rename age_band_of_driver10 dage66_75
	rename age_band_of_driver11 dage75_up
	rename day_of_week1 sunday
	rename day_of_week2 monday
	rename day_of_week3 tuesday
	rename day_of_week4 wednesday
	rename day_of_week5 thursday
	rename day_of_week6 friday
	rename day_of_week7 saturday
	rename vehicle_type1 vmotocyc50
	rename vehicle_type2 vmotocyc125
	rename vehicle_type3 vmotocyc125p
	rename vehicle_type4 vmotocyc500p
	rename vehicle_type5 vtaxi05_16
	rename vehicle_type6 vcar
	rename vehicle_type7 vminibus1
	rename vehicle_type8 vbus
	rename vehicle_type9 vhorse
	rename vehicle_type10 vagveh
	rename vehicle_type11 vtram
	rename vehicle_type12 vgoodsveh1
	rename vehicle_type13 vgoodsveh2
	rename vehicle_type14 vgoodsveh3
	rename vehicle_type15 vmobilscoot
	rename vehicle_type16 velecmotocyc
	rename vehicle_type17 votherveh
	rename vehicle_type18 vothermotocyc
	rename vehicle_type19 vothergoodsveh
	rename vehicle_type20 vmoto125p99_04
	rename vehicle_type21 vtaxinotprivate79_04
	rename vehicle_type22 vcar79_04
	rename road_surface_conditions1 road_dry
	rename road_surface_conditions2 road_wetdamp
	rename road_surface_conditions3 road_snow
	rename road_surface_conditions4 road_frostice
	rename road_surface_conditions5 road_flood
	rename vehicle_manoeuvre1 reversing
	rename vehicle_manoeuvre2 parked
	rename vehicle_manoeuvre3 waitingtogo
	rename vehicle_manoeuvre4 slowing
	rename vehicle_manoeuvre5 movingoff
	rename vehicle_manoeuvre6 uturn
	rename vehicle_manoeuvre7 turnleft
	rename vehicle_manoeuvre8 waitturnleft
	rename vehicle_manoeuvre9 turnright
	rename vehicle_manoeuvre10 waitturnright
	rename vehicle_manoeuvre11 changelaneleft
	rename vehicle_manoeuvre12 changelaneright
	rename vehicle_manoeuvre13 overtake_mv_offside
	rename vehicle_manoeuvre14 overtake_sv_offside
	rename vehicle_manoeuvre15 overtake_nearside
	rename vehicle_manoeuvre16 goahead_leftbend
	rename vehicle_manoeuvre17 goahead_rightbend
	rename vehicle_manoeuvre18 goahead_other 
	rename road_type1 roundabout
	rename road_type2 oneway_street
	rename road_type3 dual_carriageway 
	rename road_type4 single_carriageway
	rename road_type5 slippery_road
	rename road_type6 roadtype_unknown
	
}

// Remove 'varname==' after tabulate
labnoeq *

// Gen unique vehicle ID
egen vehid = group(acc_index vehicle_reference)
label var vehid "Unique vehicle ID"

// Gen speed limit
gen speed_low = (speed_limit <=30 ) if !mi(speed_limit)
label var speed_low "Low Speed (0-30 mph)"
gen speed_med = (speed_limit > 30 & speed_limit <= 50) if !mi(speed_limit)
label var speed_med "Medium Speed (31-50 mph)"
gen speed_high = (speed_limit > 50) if !mi(speed_limit)
label var speed_high "High Speed (51+ mph)"

egen speed = group( speed_high speed_med speed_low)
label var speed "Posted speed limit"
label define speed 1 "Low Speed" 2 "Medium Speed" 3 "High Speed"
label val speed speed

// Gen vehicle age
gen old_veh = (age_of_vehicle >= 10) if !mi(age_of_vehicle)
label var old_veh "Old vehicle (10+)"
gen med_veh = (age_of_vehicle > 2 & age_of_vehicle < 10) if !mi(age_of_vehicle)
label var med_veh "Mid-age vehicle (3-9)"
gen new_veh = (age_of_vehicle <= 2) if !mi(age_of_vehicle)
label var new_veh "New vehicle (0-2)"

egen vehicle_age = group(old_veh med_veh new_veh)
label var vehicle_age "Vehicle age (years)"
label define vehicle_age 3 "Old vehicle" 2 "Mid-age vehicle" 1 "New vehicle"
label val vehicle_age vehicle_age

// Gen HEV
gen hyb_elec = (propulsion_code == 3 | propulsion_code == 8) if !mi(propulsion_code) 
label var hyb_elec "HEV"
label define hyb_elec 1 "HEV"
label val hyb_elec hyb_elec

// Gen interaction variables
gen hybelec_urban = hyb_elec * urban if !mi(hyb_elec) & !mi(urban)
label var hybelec_urban "HEV*Urban"
gen hybelec_speedlow = hyb_elec * speed_low if !mi(hyb_elec) & !mi(speed_low)
label var hybelec_speedlow "HEV*Low Speed"

// Gen casualty by injury severity
gen driver_slight = (driver ==1 & driver_casualty_severity == 3)
label var driver_slight "Driver slight injury"
gen driver_severe = (driver ==1 & driver_casualty_severity ==2)
label var driver_severe "Driver severe injury"
gen driver_fatal = (driver ==1 & driver_casualty_severity ==1)
label var driver_fatal "Driver fatal injury"

// Gen new pedestrian based on injury severity

gen ped_slight = (pedestrian ==1 & ped_casualty_severity == 3)
label var ped_slight "Pedestrian slight injury"

gen ped_severe = (pedestrian ==1 & ped_casualty_severity ==2)
label var ped_severe "Pedestrian severe injury"

gen ped_fatal = (pedestrian ==1 & ped_casualty_severity ==1)
label var ped_fatal "Pedestrian fatal injury"

// Gen new cyclist based on injury severity

gen cyc_slight = (cyclist ==1 & cyc_casualty_severity ==3)
label var cyc_slight "Cyclist slight injury"

gen cyc_severe = (cyclist ==1 & cyc_casualty_severity ==2)
label var cyc_severe "Cyclist severe injury"

gen cyc_fatal = (cyclist ==1 & cyc_casualty_severity ==1)
label var cyc_fatal "Cyclist fatal injury"

// Gen Season variables
gen winter = (month == 12 | month == 1 | month == 2)
label var winter "Winter"
gen spring = (month == 3 | month == 4 | month == 5)
label var spring "Spring"
gen summer = (month == 6 | month == 7 | month == 8)
label var summer "Summer"
gen fall = (month == 9 | month == 10 | month == 11)
label var fall "Fall"

egen season = group(fall summer spring winter)
label var season "Season"
label define season 1 "Winter" 2 "Spring" 3 "Summer" 4 "Fall"
label value season season


// Combine Severe & Fatal
gen ped_sf = (ped_severe ==1 | ped_fatal ==1) 
label var ped_sf "Pedestrian severe/fatal injury"

gen cyc_sf = (cyc_severe ==1 | cyc_fatal ==1)
label var cyc_sf "Cyclist severe/fatal injury"

// Gen taxi
gen vtaxi = (vtaxi05_16 == 1 | vtaxinotprivate79_04 == 1) if !mi(vtaxinotprivate79_04) & !mi(vtaxi05_16)
label var vtaxi "Taxi"

// Gen Old & Young Diver Bins
gen old_driver = (age_band_of_driver >= 10) if !mi(age_band_of_driver)  // Drivers age 66 & older
label var old_driver "Old driver (66+)"

gen med_driver = (age_band_of_driver > 6 & age_band_of_driver < 10) if !mi(age_band_of_driver) // Drivers age 36-65 
label var med_driver "Mid-age driver (36-65)"

gen young_driver = (age_band_of_driver <= 6) if !mi(age_band_of_driver)  // Drivers age 35 & younger
label var young_driver "Young driver (0-35)"

egen driver_age = group(old_driver med_driver young_driver)
label var driver_age "Driver's age"
label define driver_age 1 "Young driver" 2 "Mid-age driver" 3 "Old driver"
label val driver_age driver_age

// Simplify weather
gen rain = (rain_no_wind == 1 | rain_high_wind == 1) if !mi(rain_no_wind)
label var rain "Rain"

gen norain = (rain != 1)
label var norain "No rain"

gen snow  = (snow_no_wind == 1 | snow_high_wind == 1) if !mi(snow_no_wind)
label var snow "Snow"

gen weather = .
replace weather = 1 if weather_other == 1
replace weather = 2 if rain == 1
replace weather = 3 if snow == 1
replace weather = 4 if fog == 1
replace weather = 5 if  weather_fine == 1 | fine_high_wind == 1 
label define weather 1 "Other weather" 2 "Rain" 3 "Snow" 4 "Fog" 5 "Fine Weather"
label value weather weather
label var weather "Weather"

// Gen Weekday, Weekend, & Weekend night indicators
gen weekday = (monday == 1 | tuesday == 1 | wednesday == 1 | thursday == 1 | friday == 1)
label var weekday "Weekday (M-F)"

gen weekend = (friday == 1 | saturday == 1)
label var weekend "Weekend (Sat. or Sun.)"

gen weekend_night = (friday == 1 & daylight != 1 | saturday == 1 & daylight != 1)
label var weekend_night "Weekend Night (Fri. or Sat.)"

// Gen hybrid & electric
gen hyb = (propulsion_code == 8) if !mi(hyb_elec)
label var hyb "Hybrid"
label define hyb 1 "Hybrid" 0 "Not Hybrid"
label val hyb hyb

gen elec = (propulsion_code == 3) if !mi(hyb_elec)
label var elec "Electric"
label define elec 1 "Electric" 0 "Not Electric"
label val elec elec

// Gen number of driver accidents by month by area
bysort local_authority_district month : egen driver_total = total(driver)
label var driver_total "Driver injuries by month and authority district"

bysort local_authority_district month : egen driver_fatal_total = total(driver_fatal)
label var driver_fatal_total "Driver fatalities by month and authority district"

gen driver_fatal_per = (driver_fatal_total/driver_total)*100
label var driver_fatal_per "Driver fatal injury (%)"

// Keep only not missing
gen notmissing = !missing(driver_age, hyb_elec, weather, speed, daylight, season, urban, vtaxi)

keep if notmissing


