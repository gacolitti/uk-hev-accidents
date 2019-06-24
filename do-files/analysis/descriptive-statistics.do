


****************************************************************************************************************************************

// Descriptive statistics

****************************************************************************************************************************************

/*

consider adding  these vars:

skidding_and_overturning sex_of_driver road_surface_conditions road_type police_force local_authority_district local_authority_highway junction_detail a_1st_road_class a_1st_point_of_impact a_1st_road_number

*/

// Left hand drive vehicles don't have propulsion info

tab was_vehicle_left_hand_drive
note: 4,862 vehicles left-hand-drive & thus don't include vehicle propulsion information

tabout year hyb using "./Tables/Table 1.1A - Hybrid Vehicles Involved in an Accident.doc" , replace style(htm) twidth(60) units(%) cells(freq col) format(0c 2p) mi lines(double) total(Total) ptotal(Total) font(times new roman) title("Table 1.1A: Hybrid Vehicles Involved in an Accident") 

tabout year elec using "./Tables/Table 1.2A - Electric Vehicles Involved in an Accident.doc" , replace style(htm) twidth(60) units(%) cells(freq col) format(0c 2p) mi lines(single) total(Total) ptotal(Total) font(times new roman) title("Table 1.2A: Electric Vehicles Involved in an Accident") 

tabout ped_slight ped_sf cyc_slight cyc_sf using "./Tables/Table 1B - Personal Injury Categories.doc" , replace style(htm) twidth(60) units(%) cells(freq col) oneway format(0c 2p) mi font(times new roman) title("Table 1B: Personal Injury Categories") 

tabout speed urban daylight season weather driver_age weekday weekend_night vtaxi using "./Tables/Table 1.1C - Group Control Variables.doc" , replace style(htm) twidth(80) units(%) cells(freq col) oneway format(0c 2p) mi lines(single) ptotal(none) font(times new roman) title("Table 1.1C: Group Control Variables") 

tabout carriageway_hazards road_surface_conditions special_conditions_at_site vehicle_manoeuvre road_type using "./Tables/Table 1D - Additional Group Control Variables.doc" , replace style(htm) twidth(100) units(%) cells(freq col) oneway format(0c 2p) mi lines(single) ptotal(none) font(times new roman) title("Table 1D: Additional Group Control Variables") 

//tabout year hyb_elec ped_slight  using "./Tables/Table 1E - HEV & Outcome.doc" , replace style(htm) twidth(100) units(%) cells(freq col) format(0c 2p) mi lines(single) ptotal(none) font(times new roman) title("Table 1D: Two-way Table of HEV & Pedestrian/slight") 

estpost tabstat driver_fatal_per ulev_per, statistics(mean p50 sd) columns(statistics)
esttab using "./Tables/Table 1.2C - Continous Control Variables.doc" , html width(100%) replace nonumbers label nomtitles noobs onecell cells("mean(fmt(a2)) p50 sd") title("Table 1.2C: Continous Control Variables") addnotes("ULEV % varies by district and quarter; Data only available for years 2010-2017" "Driver Fatal % varies by district & month; Data available for all years (2000-2017)")

/*
// Summary statistics 

preserve

foreach x in ped_slight ped_sf cyc_slight cyc_sf hyb_elec hyb elec speed_low speed_high spring summer winter fall daylight rain snow fog urban old_driver young_driver weekday weekend_night driver_fatal_per vtaxi {
	replace `x' = `x' *100
}
estpost tabstat ped_slight ped_sf cyc_slight cyc_sf hyb_elec hyb elec speed_low speed_high spring summer winter fall daylight rain snow fog urban old_driver young_driver weekday weekend_night driver_fatal_per vtaxi , statistics(count sum mean ) columns(statistics)
esttab using "./Tables/Table 1 - Descriptive Statistics" , rtf replace nonumbers label nomtitles noobs onecell cells("count mean") title("Table 1A: Summary Statistics for Key Variables") 
restore

///
varlabels( hyb_elec "HEV" hyb "Hybrid" elec "Electric" ped_slight "Pedestrian Slight Injury" ped_sf "Pedestrian Severe/Fatal Injury" cyc_slight "Cyclist Slight Injury" cyc_sf "Cyclist Severe/Fatal Injury" speed_low "Low Speed Zone" speed_high "High Speed Zone" urban "Urban" old_driver "Old Driver" young_driver "Young Driver" daylight "Daylight" rain "Rain" snow "Snow" fog "Fog" spring "Spring" summer "Summer" winter "Winter" weekday "Weekday" weekend_night "Weekend Night" driver_fatal_per "Driver Fatal %" vtaxi "Taxi") 


estpost tabstat ulev_per carriageway_hazards_none vehicle_load_on_road object_on_road previous_accident pedestrian_in_carriageway animal_in_carriageway ped_crossing_human_none school_crossing_patrol authorised_person_control physical_crossing_none physical_crossing_zebra physical_control_nonjunction ped_at_traffic_signal footbridge_subway central_refuge special_condition_none traffic_signal_out auto_signal_defective road_sign_defective roadworks road_surface_defective special_condition_oil special_condition_mud reversing parked waitingtogo slowing movingoff uturn turnleft waitturnleft turnright waitturnright changelaneleft changelaneright overtake_mv_offside overtake_sv_offside overtake_nearside goahead_leftbend goahead_rightbend goahead_other road_dry road_wetdamp road_snow road_frostice road_flood roundabout oneway_street dual_carriageway single_carriageway slippery_road roadtype_unknown , statistics(count sum mean ) columns(statistics)
esttab using "./Tables/Table 1 - Descriptive Statistics" , append rtf nonumbers nomtitles noobs onecell cells("count mean") title("Table 1B: Summary Statistics for Additional Control Variables") ///
varlabels( ulev_per "ULEV %" carriageway_hazards_none "No Carriageway Hazard" vehicle_load_on_road "Vehicle Load on Road" object_on_road "Object on Road" previous_accident "Previous Accident" pedestrian_in_carriageway "Pedestrian in Carriageway" animal_in_carriageway "Animal in Carriageway" ped_crossing_human_none "Pedestrian Crossing No Human" school_crossing_patrol "School Crossing" authorised_person_control "Authorised Person Control" physical_crossing_none "No Physical Crossing" physical_crossing_zebra "Zebra Crossing" physical_control_nonjunction "Nonjunction Control" ped_at_traffic_signal "Pedestrian at Traffic Signal" footbridge_subway "Footbridge Subway" central_refuge "Central Refuge" special_condition_none "No Special Conditions" traffic_signal_out "Traffic Signal Out" auto_signal_defective "Auto Signal Defective" road_sign_defective "Road Sign Defective" roadworks "Roadwork" road_surface_defective "Road Surface Defective" special_condition_oil "Oil on Road" special_condition_mud "Mud on Road" reversing "Reversing" parked "Parked" waitingtogo "Waiting to Go" slowing "Slowing" movingoff "Moving off" uturn "U-Turn" turnleft "Left Turn" waitturnleft "Waiting to Turn Left" turnright "Right Turn" waitturnright "Waiting to Turn Right" changelaneleft "Change Lane Left" changelaneright "Change Lane Right" overtake_mv_offside "Overtake Moving Vehicle Offside" overtake_sv_offside "Overtake Static Vehicle Offside" overtake_nearside "Overtake Nearside" goahead_leftbend "Left Bend Go Ahead" goahead_rightbend "Right Bend Go Ahead" goahead_other "Go Ahead Other" road_dry "Dry Road" road_wetdamp "Wet/Damp Road" road_snow "Snowy Road" road_frostice "Frosty/Icy Road" road_flood "Flooded Road" roundabout "Roadabout" oneway_street "One-Way Street" dual_carriageway "Dual Carriageway" single_carriageway "Single Carriageway" slippery_road "Slippery Road" roadtype_unknown "Unknown Road Type") 



// Mean of HEV by year & casualty class
foreach x in ped_slight ped_sf cyc_slight cyc_sf {
	estpost tabstat hyb_elec if `x' ==1 , by(year) nototal statistics(sum mean) columns(statistics)
	est store `x'_hyb_elec_sum
	}
	
	esttab *_hyb_elec_sum using  "./Tables/Table 2 - Summary Statistics for HEV by Injury Group & Year", rtf append nonumbers noobs onecell nomtitles mgroups("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal", pattern(1 1 1 1) nospan) cells("sum mean") title("Summary Statistics for HEV by Injury Group & Year")
	



