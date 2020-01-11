
// Gen Vars

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

// Remove 'varname ==' after tabulate
labnoeq *

// Gen unique vehicle ID
egen key = group(acc_index vehicle_reference)
label var key "Unique ID"

// Gen speed limit
gen speed_low = (speed_limit <=30 ) if !mi(speed_limit)
label var speed_low "Low Speed (0-30 mph)"
gen speed_med = (speed_limit > 30 & speed_limit <= 50) if !mi(speed_limit)
label var speed_med "Medium Speed (31-50 mph)"
gen speed_high = (speed_limit > 50) if !mi(speed_limit)
label var speed_high "High Speed (51+ mph)"

// Gen vehicle age
gen old_vehicle = (age_of_vehicle >= 10) if !mi(age_of_vehicle)
label var old_vehicle "Old vehicle (10+)"
gen mid_age_vehicle = (age_of_vehicle > 2 & age_of_vehicle < 10) if !mi(age_of_vehicle)
label var mid_age_vehicle "Mid-age vehicle (3-9)"
gen new_vehicle = (age_of_vehicle <= 2) if !mi(age_of_vehicle)
label var new_vehicle "New vehicle (0-2)"

// Gen hybrid/electric
gen hybrid_electric = (propulsion_code == 3 | propulsion_code == 8) if !mi(propulsion_code) 
label var hybrid_electric "Hybrid/Electric"
label define hybrid_electric 1 "Hybrid/Electric"
label val hybrid_electric hybrid_electric

// Gen outcome by injury severity
gen driver_slight_injury = (driver == 1 & driver_injury_severity == 3)
label var driver_slight_injury "Driver slight injury"
gen driver_severe_injury = (driver == 1 & driver_injury_severity == 2)
label var driver_severe_injury "Driver severe injury"
gen driver_fatal_injury = (driver == 1 & driver_injury_severity == 1)
label var driver_fatal_injury "Driver fatal injury"

// Gen new pedestrian based on injury severity
gen pedestrian_slight_injury = (pedestrian == 1 & pedestrian_injury_severity == 3)
label var pedestrian_slight_injury "Pedestrian slight injury"

gen pedestrian_severe_injury = (pedestrian == 1 & pedestrian_injury_severity == 2)
label var pedestrian_severe_injury "Pedestrian severe injury"

gen pedestrian_fatal_injury = (pedestrian == 1 & pedestrian_injury_severity == 1)
label var pedestrian_fatal_injury "Pedestrian fatal injury"

// Gen new cyclist based on injury severity
gen cyclist_slight_injury = (cyclist == 1 & cyclist_injury_severity == 3)
label var cyclist_slight_injury "Cyclist slight injury"

gen cyclist_severe_injury = (cyclist == 1 & cyclist_injury_severity == 2)
label var cyclist_severe_injury "Cyclist severe injury"

gen cyclist_fatal_injury = (cyclist == 1 & cyclist_injury_severity == 1)
label var cyclist_fatal_injury "Cyclist fatal injury"

// Gen Season variables
gen winter = (month == 12 | month == 1 | month == 2) if !mi(month)
label var winter "Winter"
gen spring = (month == 3 | month == 4 | month == 5) if !mi(month)
label var spring "Spring"
gen summer = (month == 6 | month == 7 | month == 8) if !mi(month)
label var summer "Summer"
gen fall = (month == 9 | month == 10 | month == 11) if !mi(month)
label var fall "Fall"

// Combine Severe & Fatal
gen pedestrian_severe_or_fatal_injury = (pedestrian_severe_injury == 1 | pedestrian_fatal_injury == 1) 
label var pedestrian_severe_or_fatal_injury "Pedestrian severe/fatal injury"
gen cyclist_severe_or_fatal_injury = (cyclist_severe_injury == 1 | cyclist_fatal_injury == 1)
label var cyclist_severe_or_fatal_injury "Cyclist severe/fatal injury"

// Gen taxi
gen taxi = (vtaxi05_16 == 1 | vtaxinotprivate79_04 == 1) if !mi(vtaxinotprivate79_04) & !mi(vtaxi05_16)
label var taxi "Is vehicle a taxi"
label define taxi 1 "Taxi" 0 "Not Taxi"
label val taxi taxi

// Gen Old & Young Diver Bins
// Drivers aged 66+
gen old_driver = (age_band_of_driver >= 10) if !mi(age_band_of_driver) 
label var old_driver "Old driver (66+)"
// Drivers aged 36-65
gen mid_age_driver = (age_band_of_driver > 6 & age_band_of_driver < 10) if !mi(age_band_of_driver) 
label var mid_age_driver "Mid-age driver (36-65)"
// Drivers age 35 & younger
gen young_driver = (age_band_of_driver <= 6) if !mi(age_band_of_driver)
label var young_driver "Young driver (0-35)"

// Gen weather vars
gen rain = (rain_no_wind == 1 | rain_high_wind == 1) if !mi(rain_no_wind)
label var rain "Rain"
gen snow  = (snow_no_wind == 1 | snow_high_wind == 1) if !mi(snow_no_wind)
label var snow "Snow"

// Gen Weekday, Weekend, & Weekend night indicators
gen weekday = (monday == 1 | tuesday == 1 | wednesday == 1 | thursday == 1 | friday == 1)
label var weekday "Weekday (Mo-Fr)"
gen weekend = (friday == 1 | saturday == 1)
label var weekend "Weekend (Fr/Sa)"
gen weekend_night = (friday == 1 & daylight != 1 | saturday == 1 & daylight != 1)
label var weekend_night "Weekend Night (Fr/Sa)"

// Gen hybrid & electric
gen hybrid = (propulsion_code == 8) if !mi(hybrid_electric)
label var hybrid "Hybrid"
label define hybrid 1 "Hybrid" 0 "Not Hybrid"
label val hybrid hybrid

gen electric = (propulsion_code == 3) if !mi(hybrid_electric)
label var electric "Electric"
label define electric 1 "Electric" 0 "Not Electric"
label val electric electric

// Gen number of driver injuries by month & area
bysort local_authority_district month : egen driver_injuries_by_month_and_district = total(driver)
label var driver_injuries_by_month_and_district "Driver injuries by month and authority district"

bysort local_authority_district month : egen driver_fatalities_by_month_and_district = total(driver_fatal_injury)
label var driver_fatalities_by_month_and_district "Driver fatalities by month and authority district"

gen driver_fatal_injury_per = (driver_fatalities_by_month_and_district / driver_injuries_by_month_and_district) * 100
label var driver_fatal_injury_per "Driver fatal injury (%)"

// Keep only not missing
// keep if !missing(driver_age, hyb_elec, weather, speed, daylight, season, urban, vtaxi)

