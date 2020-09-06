
// Apply Value Labels

// Rename Vars to match codebook
rename st* a_1st* 
rename nd* a_2nd*

// Define value labels
qui {
	// Vehicles Vars
	label define journey_purpose_of_driver -1 `"NULL or Invalid value"', modify
	label define journey_purpose_of_driver 1 `"Journey as part of work"', modify
	label define journey_purpose_of_driver 2 `"Commuting to/from work"', modify
	label define journey_purpose_of_driver 3 `"Taking pupil to/from school"', modify
	label define journey_purpose_of_driver 4 `"Pupil riding to/from school"', modify
	label define journey_purpose_of_driver 5 `"Other (from 2011)"', modify
	label define journey_purpose_of_driver 6 `"Not known (from 2011)"', modify
	label define journey_purpose_of_driver 15 `"Other/Not known (2005-2010)"', modify
	label define was_vehicle_left_hand_drive -1 `"NULL or Invalid value"', modify
	label define was_vehicle_left_hand_drive 1 `"No"', modify
	label define was_vehicle_left_hand_drive 2 `"Yes"', modify
	label define age_of_driver -1 `"NULL or Invalid value"', modify
	label define sex_of_driver 1 `"Male"', modify
	label define sex_of_driver 2 `"Female"', modify
	label define sex_of_driver 3 `"Not known"', modify
	label define a_1st_point_of_impact -1 `"NULL or Invalid value"', modify
	label define a_1st_point_of_impact 0 `"Did not impact"', modify
	label define a_1st_point_of_impact 1 `"Front"', modify
	label define a_1st_point_of_impact 2 `"Back"', modify
	label define a_1st_point_of_impact 3 `"Offside"', modify
	label define a_1st_point_of_impact 4 `"Nearside"', modify
	label define hit_object_off_carriageway -1 `"NULL or Invalid value"', modify
	label define hit_object_off_carriageway 0 `"None"', modify
	label define hit_object_off_carriageway 1 `"Road sign or traffic signal"', modify
	label define hit_object_off_carriageway 2 `"Lamp post"', modify
	label define hit_object_off_carriageway 3 `"Telegraph or electricity pole"', modify
	label define hit_object_off_carriageway 4 `"Tree"', modify
	label define hit_object_off_carriageway 5 `"Bus stop or bus shelter"', modify
	label define hit_object_off_carriageway 6 `"Central crash barrier"', modify
	label define hit_object_off_carriageway 7 `"Near/Offside crash barrier"', modify
	label define hit_object_off_carriageway 8 `"Submerged in water"', modify
	label define hit_object_off_carriageway 9 `"Entered ditch"', modify
	label define hit_object_off_carriageway 10 `"Other permanent object"', modify
	label define hit_object_off_carriageway 11 `"Wall or fence (from 2011)"', modify
	label define vehicle_leaving_carriageway -1 `"NULL or Invalid value"', modify
	label define vehicle_leaving_carriageway 0 `"Did not leave carriageway"', modify
	label define vehicle_leaving_carriageway 1 `"Nearside"', modify
	label define vehicle_leaving_carriageway 2 `"Nearside and rebounded"', modify
	label define vehicle_leaving_carriageway 3 `"Straight ahead at junction"', modify
	label define vehicle_leaving_carriageway 4 `"Offside on to central reservation"', modify
	label define vehicle_leaving_carriageway 5 `"Offside on to centrl res + rebounded"', modify
	label define vehicle_leaving_carriageway 6 `"Offside - crossed central reservation"', modify
	label define vehicle_leaving_carriageway 7 `"Offside"', modify
	label define vehicle_leaving_carriageway 8 `"Offside and rebounded"', modify
	label define hit_object_in_carriageway -1 `"NULL or Invalid value"', modify
	label define hit_object_in_carriageway 0 `"None"', modify
	label define hit_object_in_carriageway 1 `"Previous accident"', modify
	label define hit_object_in_carriageway 2 `"Road works"', modify
	label define hit_object_in_carriageway 4 `"Parked vehicle"', modify
	label define hit_object_in_carriageway 5 `"Bridge (roof)"', modify
	label define hit_object_in_carriageway 6 `"Bridge (side)"', modify
	label define hit_object_in_carriageway 7 `"Bollard or refuge"', modify
	label define hit_object_in_carriageway 8 `"Open door of vehicle"', modify
	label define hit_object_in_carriageway 9 `"Central island of roundabout"', modify
	label define hit_object_in_carriageway 10 `"Kerb"', modify
	label define hit_object_in_carriageway 11 `"Other object"', modify
	label define hit_object_in_carriageway 12 `"Any animal (except ridden horse) (from 2005)"', modify
	label define skidding_and_overturning -1 `"NULL or Invalid value"', modify
	label define skidding_and_overturning 0 `"None"', modify
	label define skidding_and_overturning 1 `"Skidded"', modify
	label define skidding_and_overturning 2 `"Skidded and overturned"', modify
	label define skidding_and_overturning 3 `"Jackknifed"', modify
	label define skidding_and_overturning 4 `"Jackknifed and overturned"', modify
	label define skidding_and_overturning 5 `"Overturned"', modify
	label define junction_location -1 `"NULL or Invalid value"', modify
	label define junction_location 0 `"Not at, or within 20 metres of, junction"', modify
	label define junction_location 1 `"Approaching junct or waiting/parked at junct apprch"', modify
	label define junction_location 2 `"Cleared junction or waiting/parked at junction exit"', modify
	label define junction_location 3 `"Leaving roundabout"', modify
	label define junction_location 4 `"Entering roundabout"', modify
	label define junction_location 5 `"Leaving main road"', modify
	label define junction_location 6 `"Entering main road"', modify
	label define junction_location 7 `"Entering from slip road"', modify
	label define junction_location 8 `"Mid Junction - on roundabout or on main road"', modify
	label define vehicle_manoeuvre -1 `"NULL or Invalid value"', modify
	label define vehicle_manoeuvre 1 `"Reversing"', modify
	label define vehicle_manoeuvre 2 `"Parked"', modify
	label define vehicle_manoeuvre 3 `"Waiting to go - held up"', modify
	label define vehicle_manoeuvre 4 `"Slowing or stopping"', modify
	label define vehicle_manoeuvre 5 `"Moving off"', modify
	label define vehicle_manoeuvre 6 `"U-turn"', modify
	label define vehicle_manoeuvre 7 `"Turning left"', modify
	label define vehicle_manoeuvre 8 `"Waiting to turn left"', modify
	label define vehicle_manoeuvre 9 `"Turning right"', modify
	label define vehicle_manoeuvre 10 `"Waiting to turn right"', modify
	label define vehicle_manoeuvre 11 `"Changing lane to left"', modify
	label define vehicle_manoeuvre 12 `"Changing lane to right"', modify
	label define vehicle_manoeuvre 13 `"Overtaking moving vehicle - offside"', modify
	label define vehicle_manoeuvre 14 `"Overtaking static vehicle - offside"', modify
	label define vehicle_manoeuvre 15 `"Overtaking - nearside"', modify
	label define vehicle_manoeuvre 16 `"Going ahead left-hand bend"', modify
	label define vehicle_manoeuvre 17 `"Going ahead right-hand bend"', modify
	label define vehicle_manoeuvre 18 `"Going ahead other"', modify
	label define towing_and_articulation -1 `"NULL or Invalid value"', modify
	label define towing_and_articulation 0 `"No tow/articulation"', modify
	label define towing_and_articulation 1 `"Articulated vehicle"', modify
	label define towing_and_articulation 2 `"Double or multiple trailer"', modify
	label define towing_and_articulation 3 `"Caravan"', modify
	label define towing_and_articulation 4 `"Single trailer"', modify
	label define towing_and_articulation 5 `"Other tow"', modify
	label define vehicle_type -1 `"NULL or Invalid value"', modify
	label define vehicle_type 1 `"Pedal cycle"', modify
	label define vehicle_type 2 `"Motorcycle 50cc and under"', modify
	label define vehicle_type 3 `"M/cycle over 50 and up to 125cc (from 1999)"', modify
	label define vehicle_type 4 `"Motorcycle over 125cc and up to 500cc (from 2005)"', modify
	label define vehicle_type 5 `"Motorcycle over 500cc (from 2005)"', modify
	label define vehicle_type 8 `"Taxi / Private hire car (from 2005)"', modify
	label define vehicle_type 9 `"Car (from 2005)"', modify
	label define vehicle_type 10 `"Minibus (8 - 16 passenger seats) (from 1999)"', modify
	label define vehicle_type 11 `"Bus or coach (17 or more pass seats)"', modify
	label define vehicle_type 16 `"Ridden horse (from 1999)"', modify
	label define vehicle_type 17 `"Agricultural vehicle (from 1999)"', modify
	label define vehicle_type 18 `"Tram (from 1999)"', modify
	label define vehicle_type 19 `"Van / Goods 3.5 tonnes mgw or under"', modify
	label define vehicle_type 20 `"Goods over 3.5t. and under 7.5t. (from 1999)"', modify
	label define vehicle_type 21 `"Goods 7.5 tonnes mgw and over (from 1999)"', modify
	label define vehicle_type 22 `"Mobility scooter (from 2011)"', modify
	label define vehicle_type 23 `"Electric motorcycle (from 2011)"', modify
	label define vehicle_type 90 `"Other vehicle"', modify
	label define vehicle_type 97 `"Motorcycle - unknown cc (from 2011)"', modify
	label define vehicle_type 98 `"Goods vehicle - unknown weight (self rep only)"', modify
	label define vehicle_type 103 `"Motorcycle - Scooter (1979-1998)"', modify
	label define vehicle_type 104 `"Motorcycle (1979-1998)"', modify
	label define vehicle_type 105 `"Motorcycle - Combination (1979-1998)"', modify
	label define vehicle_type 106 `"Motorcycle over 125cc (1999-2004)"', modify
	label define vehicle_type 108 `"Taxi (excluding private hire cars) (1979-2004)"', modify
	label define vehicle_type 109 `"Car (including private hire cars) (1979-2004)"', modify
	label define vehicle_type 110 `"Minibus/Motor caravan (1979-1998)"', modify
	label define vehicle_type 113 `"Goods over 3.5 tonnes (1979-1998)"', modify
	
	// Casualty Vars
	label define casualty_home_area_type -1 `"NULL or Invalid value"', modify
	label define pedestrian_road_maintenance -1 `"NULL or Invalid value"', modify
	label define pedestrian_road_maintenance 0 `"No / Not applicable"', modify
	label define pedestrian_road_maintenance 1 `"Yes"', modify
	label define pedestrian_road_maintenance 2 `"Not known"', modify
	label define bus_or_coach_passenger -1 `"NULL or Invalid value"', modify
	label define bus_or_coach_passenger 0 `"Not a bus or coach passenger"', modify
	label define bus_or_coach_passenger 1 `"Boarding"', modify
	label define bus_or_coach_passenger 2 `"Alighting"', modify
	label define bus_or_coach_passenger 3 `"Standing passenger"', modify
	label define bus_or_coach_passenger 4 `"Seated passenger"', modify
	label define car_passenger -1 `"NULL or Invalid value"', modify
	label define car_passenger 0 `"Not car passenger"', modify
	label define car_passenger 1 `"Front seat passenger"', modify
	label define car_passenger 2 `"Rear seat passenger"', modify
	label define pedestrian_movement -1 `"NULL or Invalid value"', modify
	label define pedestrian_movement 0 `"Not a pedestrian"', modify
	label define pedestrian_movement 1 `"Crossing from driver's nearside"', modify
	label define pedestrian_movement 2 `"Crossing from nearside - masked by veh"', modify
	label define pedestrian_movement 3 `"Crossing from driver's offside"', modify
	label define pedestrian_movement 4 `"Crossing from offside - masked by veh"', modify
	label define pedestrian_movement 5 `"In c'way, stationary - not crossing (standing/playing)"', modify
	label define pedestrian_movement 6 `"In c'way, stationary - not X'ing (standing) masked"', modify
	label define pedestrian_movement 7 `"Walking along in carriageway, facing traffic"', modify
	label define pedestrian_movement 8 `"Walking along in carriageway, back to traffic"', modify
	label define pedestrian_movement 9 `"Unknown or other"', modify
	label define pedestrian_location -1 `"NULL or Invalid value"', modify
	label define pedestrian_location 0 `"Not a pedestrian"', modify
	label define pedestrian_location 1 `"Crossing on pedestrian crossing facility"', modify
	label define pedestrian_location 2 `"Crossing in zig-zag approach lines"', modify
	label define pedestrian_location 3 `"Crossing in zig-zag exit lines"', modify
	label define pedestrian_location 4 `"Crossing elsewhere within 50m. of ped crossing"', modify
	label define pedestrian_location 5 `"In carriageway, crossing elsewhere"', modify
	label define pedestrian_location 6 `"On footway or verge"', modify
	label define pedestrian_location 7 `"On refuge, central island or central reservation"', modify
	label define pedestrian_location 8 `"In centre of carriageway - not on refuge etc"', modify
	label define pedestrian_location 9 `"In carriageway, not crossing"', modify
	label define pedestrian_location 10 `"Unknown or other"', modify
	label define casualty_severity 1 `"Fatal"', modify
	label define casualty_severity 2 `"Serious"', modify
	label define casualty_severity 3 `"Slight"', modify
	label define age_of_casualty -1 `"NULL or Invalid value"', modify
	label define sex_of_casualty -1 `"NULL or Invalid value"', modify
	label define sex_of_casualty 1 `"Male"', modify
	label define sex_of_casualty 2 `"Female"', modify
	label define casualty_class 1 `"Driver or rider"', modify
	label define casualty_class 2 `"Passenger"', modify
	label define casualty_class 3 `"Pedestrian"', modify
	
	// Accident Vars
	label define did_police_officer_attend -1 `"NULL or Invalid value"', modify
	label define did_police_officer_attend 1 `"Yes"', modify
	label define did_police_officer_attend 2 `"No"', modify
	label define did_police_officer_attend 3 `"No - accident was reported using a self completion form"', modify
	label define carriageway_hazards -1 `"NULL or Invalid value"', modify
	label define carriageway_hazards 0 `"None"', modify
	label define carriageway_hazards 1 `"Vehicle load on road"', modify
	label define carriageway_hazards 2 `"Other object on road"', modify
	label define carriageway_hazards 3 `"Previous accident"', modify
	label define carriageway_hazards 4 `"Dog on road (1979-2004)"', modify
	label define carriageway_hazards 5 `"Other animal on road (1979-2004)"', modify
	label define carriageway_hazards 6 `"Pedestrian in carriageway - not injured (from 2005)"', modify
	label define carriageway_hazards 7 `"Any animal in carriageway (except ridden horse) (from 2005)"', modify
	label define special_conditions_at_site 0 `"None"', modify
	label define special_conditions_at_site 1 `"Auto traffic signal - out"', modify
	label define special_conditions_at_site 2 `"Auto signal part defective"', modify
	label define special_conditions_at_site 3 `"Road sign or marking defective or obscured"', modify
	label define special_conditions_at_site 4 `"Roadworks"', modify
	label define special_conditions_at_site 5 `"Road surface defective"', modify
	label define special_conditions_at_site 6 `"Oil or diesel (from 2005 - see A23)"', modify
	label define special_conditions_at_site 7 `"Mud (from 2005 - see A23)"', modify
	label define road_surface_conditions -1 `"NULL or Invalid value"', modify
	label define road_surface_conditions 1 `"Dry"', modify
	label define road_surface_conditions 2 `"Wet or damp"', modify
	label define road_surface_conditions 3 `"Snow"', modify
	label define road_surface_conditions 4 `"Frost or ice"', modify
	label define road_surface_conditions 5 `"Flood over 3cm. deep"', modify
	label define road_surface_conditions 6 `"Oil or diesel (1999-2004)"', modify
	label define road_surface_conditions 7 `"Mud (1999-2004)"', modify
	label define weather_conditions 1 `"Fine no high winds"', modify
	label define weather_conditions 2 `"Raining no high winds"', modify
	label define weather_conditions 3 `"Snowing no high winds"', modify
	label define weather_conditions 4 `"Fine + high winds"', modify
	label define weather_conditions 5 `"Raining + high winds"', modify
	label define weather_conditions 6 `"Snowing + high winds"', modify
	label define weather_conditions 7 `"Fog or mist"', modify
	label define weather_conditions 8 `"Other"', modify
	label define weather_conditions 9 `"Unknown"', modify
	label define light_conditions 1 `"Daylight"', modify
	label define light_conditions 4 `"Darkness - lights lit"', modify
	label define light_conditions 5 `"Darkness - lights unlit"', modify
	label define light_conditions 6 `"Darkness - no lighting"', modify
	label define light_conditions 7 `"Darkness - lighting unknown"', modify
	label define pedestrian_crossingphysical_faci 0 `"No physical crossing facilities within 50 metres"', modify
	label define pedestrian_crossingphysical_faci 1 `"Zebra"', modify
	label define pedestrian_crossingphysical_faci 4 `"Pelican, puffin, toucan or similar non-junction pedestrian light crossing"', modify
	label define pedestrian_crossingphysical_faci 5 `"Pedestrian phase at traffic signal junction"', modify
	label define pedestrian_crossingphysical_faci 7 `"Footbridge or subway"', modify
	label define pedestrian_crossingphysical_faci 8 `"Central refuge"', modify
	label define a_2nd_road_number -1 `"NULL or Invalid value"', modify
	label define a_2nd_road_class -1 `"NULL or Invalid value"', modify
	label define a_2nd_road_class 1 `"Motorway"', modify
	label define a_2nd_road_class 2 `"A(M)"', modify
	label define a_2nd_road_class 3 `"A"', modify
	label define a_2nd_road_class 4 `"B"', modify
	label define a_2nd_road_class 5 `"C"', modify
	label define a_2nd_road_class 6 `"Unclassified"', modify
	label define junction_control -1 `"NULL or Invalid value"', modify
	label define junction_control 1 `"Authorised person"', modify
	label define junction_control 2 `"Auto traffic signal"', modify
	label define junction_control 3 `"Stop sign"', modify
	label define junction_control 4 `"Give way or uncontrolled"', modify
	label define junction_detail -1 `"NULL or Invalid value"', modify
	label define junction_detail 0 `"Not at junction or within 20 metres"', modify
	label define junction_detail 1 `"Roundabout"', modify
	label define junction_detail 2 `"Mini-roundabout"', modify
	label define junction_detail 3 `"T or staggered junction"', modify
	label define junction_detail 5 `"Slip road"', modify
	label define junction_detail 6 `"Crossroads"', modify
	label define junction_detail 7 `"More than 4 arms (not roundabout)"', modify
	label define junction_detail 8 `"Private drive or entrance"', modify
	label define junction_detail 9 `"Other junction"', modify
	label define road_type 1 `"Roundabout"', modify
	label define road_type 2 `"One way street (from 2005)"', modify
	label define road_type 3 `"Dual carriageway"', modify
	label define road_type 6 `"Single carriageway"', modify
	label define road_type 7 `"Slip road (from 2005)"', modify
	label define road_type 9 `"Unknown"', modify
	label define road_type 12 `"One way street/Slip road (1979-2004)"', modify
	label define a_1st_road_class 1 `"Motorway"', modify
	label define a_1st_road_class 2 `"A(M)"', modify
	label define a_1st_road_class 3 `"A"', modify
	label define a_1st_road_class 4 `"B"', modify
	label define a_1st_road_class 5 `"C"', modify
	label define a_1st_road_class 6 `"Unclassified"', modify
	label define local_authority_district 1 `"Westminster"', modify
	label define local_authority_district 2 `"Camden"', modify
	label define local_authority_district 3 `"Islington"', modify
	label define local_authority_district 4 `"Hackney"', modify
	label define local_authority_district 5 `"Tower Hamlets"', modify
	label define local_authority_district 6 `"Greenwich"', modify
	label define local_authority_district 7 `"Lewisham"', modify
	label define local_authority_district 8 `"Southwark"', modify
	label define local_authority_district 9 `"Lambeth"', modify
	label define local_authority_district 10 `"Wandsworth"', modify
	label define local_authority_district 11 `"Hammersmith and Fulham"', modify
	label define local_authority_district 12 `"Kensington and Chelsea"', modify
	label define local_authority_district 13 `"Waltham Forest"', modify
	label define local_authority_district 14 `"Redbridge"', modify
	label define local_authority_district 15 `"Havering"', modify
	label define local_authority_district 16 `"Barking and Dagenham"', modify
	label define local_authority_district 17 `"Newham"', modify
	label define local_authority_district 18 `"Bexley"', modify
	label define local_authority_district 19 `"Bromley"', modify
	label define local_authority_district 20 `"Croydon"', modify
	label define local_authority_district 21 `"Sutton"', modify
	label define local_authority_district 22 `"Merton"', modify
	label define local_authority_district 23 `"Kingston-upon-Thames"', modify
	label define local_authority_district 24 `"Richmond-upon-Thames"', modify
	label define local_authority_district 25 `"Hounslow"', modify
	label define local_authority_district 26 `"Hillingdon"', modify
	label define local_authority_district 27 `"Ealing"', modify
	label define local_authority_district 28 `"Brent"', modify
	label define local_authority_district 29 `"Harrow"', modify
	label define local_authority_district 30 `"Barnet"', modify
	label define local_authority_district 31 `"Haringey"', modify
	label define local_authority_district 32 `"Enfield"', modify
	label define local_authority_district 33 `"Hertsmere"', modify
	label define local_authority_district 38 `"Epsom and Ewell"', modify
	label define local_authority_district 40 `"Spelthorne"', modify
	label define local_authority_district 57 `"Heathrow Airport"', modify
	label define local_authority_district 60 `"Allerdale"', modify
	label define local_authority_district 61 `"Barrow-in-Furness"', modify
	label define local_authority_district 62 `"Carlisle"', modify
	label define local_authority_district 63 `"Copeland"', modify
	label define local_authority_district 64 `"Eden"', modify
	label define local_authority_district 65 `"South Lakeland"', modify
	label define local_authority_district 70 `"Blackburn with Darwen"', modify
	label define local_authority_district 71 `"Blackpool (UA from Apr 1998)"', modify
	label define local_authority_district 72 `"Burnley"', modify
	label define local_authority_district 73 `"Chorley"', modify
	label define local_authority_district 74 `"Fylde"', modify
	label define local_authority_district 75 `"Hyndburn"', modify
	label define local_authority_district 76 `"Lancaster"', modify
	label define local_authority_district 77 `"Pendle"', modify
	label define local_authority_district 79 `"Preston"', modify
	label define local_authority_district 80 `"Ribble Valley"', modify
	label define local_authority_district 82 `"Rossendale"', modify
	label define local_authority_district 83 `"South Ribble"', modify
	label define local_authority_district 84 `"West Lancashire"', modify
	label define local_authority_district 85 `"Wyre"', modify
	label define local_authority_district 90 `"Knowsley"', modify
	label define local_authority_district 91 `"Liverpool"', modify
	label define local_authority_district 92 `"St Helens"', modify
	label define local_authority_district 93 `"Sefton"', modify
	label define local_authority_district 95 `"Wirral"', modify
	label define local_authority_district 100 `"Bolton"', modify
	label define local_authority_district 101 `"Bury"', modify
	label define local_authority_district 102 `"Manchester"', modify
	label define local_authority_district 104 `"Oldham"', modify
	label define local_authority_district 106 `"Rochdale"', modify
	label define local_authority_district 107 `"Salford"', modify
	label define local_authority_district 109 `"Stockport"', modify
	label define local_authority_district 110 `"Tameside"', modify
	label define local_authority_district 112 `"Trafford"', modify
	label define local_authority_district 114 `"Wigan"', modify
	label define local_authority_district 120 `"Chester (to 130)"', modify
	label define local_authority_district 121 `"Congleton (to 129)"', modify
	label define local_authority_district 122 `"Crewe and Nantwich (to 129)"', modify
	label define local_authority_district 123 `"Ellesmere Port and Neston (to 130)"', modify
	label define local_authority_district 124 `"Halton (UA from Apr 1998)"', modify
	label define local_authority_district 126 `"Macclesfield (to 129)"', modify
	label define local_authority_district 127 `"Vale Royal (to 130)"', modify
	label define local_authority_district 128 `"Warrington"', modify
	label define local_authority_district 129 `"Cheshire East"', modify
	label define local_authority_district 130 `"Cheshire West and Chester"', modify
	label define local_authority_district 139 `"Northumberland"', modify
	label define local_authority_district 140 `"Alnwick (to 139)"', modify
	label define local_authority_district 141 `"Berwick-upon-Tweed (to 139)"', modify
	label define local_authority_district 142 `"Blyth Valley (to 139)"', modify
	label define local_authority_district 143 `"Castle Morpeth (to 139)"', modify
	label define local_authority_district 144 `"Tynedale (to 139)"', modify
	label define local_authority_district 145 `"Wansbeck (to 139)"', modify
	label define local_authority_district 146 `"Gateshead"', modify
	label define local_authority_district 147 `"Newcastle-upon-Tyne"', modify
	label define local_authority_district 148 `"North Tyneside"', modify
	label define local_authority_district 149 `"South Tyneside"', modify
	label define local_authority_district 150 `"Sunderland"', modify
	label define local_authority_district 160 `"Chester-le-Street (to 169)"', modify
	label define local_authority_district 161 `"Darlington"', modify
	label define local_authority_district 162 `"Derwentside (to 169)"', modify
	label define local_authority_district 163 `"Durham (to 169)"', modify
	label define local_authority_district 164 `"Easington (to 169)"', modify
	label define local_authority_district 165 `"Sedgefield (to 169)"', modify
	label define local_authority_district 166 `"Teesdale (to 169)"', modify
	label define local_authority_district 168 `"Wear Valley (to 169)"', modify
	label define local_authority_district 169 `"County Durham"', modify
	label define local_authority_district 180 `"Craven"', modify
	label define local_authority_district 181 `"Hambleton"', modify
	label define local_authority_district 182 `"Harrogate"', modify
	label define local_authority_district 184 `"Richmondshire"', modify
	label define local_authority_district 185 `"Ryedale"', modify
	label define local_authority_district 186 `"Scarborough"', modify
	label define local_authority_district 187 `"Selby"', modify
	label define local_authority_district 189 `"York (UA from Apr 1996)"', modify
	label define local_authority_district 200 `"Bradford"', modify
	label define local_authority_district 202 `"Calderdale"', modify
	label define local_authority_district 203 `"Kirklees"', modify
	label define local_authority_district 204 `"Leeds"', modify
	label define local_authority_district 206 `"Wakefield"', modify
	label define local_authority_district 210 `"Barnsley"', modify
	label define local_authority_district 211 `"Doncaster"', modify
	label define local_authority_district 213 `"Rotherham"', modify
	label define local_authority_district 215 `"Sheffield"', modify
	label define local_authority_district 220 `"Beverley (to 231)"', modify
	label define local_authority_district 221 `"Boothferry (to 231/232)"', modify
	label define local_authority_district 224 `"Cleethorpes (to 233)"', modify
	label define local_authority_district 225 `"Glanford (to 232)"', modify
	label define local_authority_district 226 `"Grimsby (to 233)"', modify
	label define local_authority_district 227 `"Holderness (to 231)"', modify
	label define local_authority_district 228 `"Kingston-upon-Hull, City of"', modify
	label define local_authority_district 229 `"East Yorkshire (to 231)"', modify
	label define local_authority_district 230 `"Scunthorpe (to 232)"', modify
	label define local_authority_district 231 `"East Riding of Yorkshire"', modify
	label define local_authority_district 232 `"North Lincolnshire (data from Jan 1996)"', modify
	label define local_authority_district 233 `"North East Lincolnshire (data from Jan 1996)"', modify
	label define local_authority_district 240 `"Hartlepool"', modify
	label define local_authority_district 241 `"Redcar and Cleveland"', modify
	label define local_authority_district 243 `"Middlesbrough"', modify
	label define local_authority_district 245 `"Stockton-on-Tees"', modify
	label define local_authority_district 250 `"Cannock Chase"', modify
	label define local_authority_district 251 `"East Staffordshire"', modify
	label define local_authority_district 252 `"Lichfield"', modify
	label define local_authority_district 253 `"Newcastle-under-Lyme"', modify
	label define local_authority_district 254 `"South Staffordshire"', modify
	label define local_authority_district 255 `"Stafford"', modify
	label define local_authority_district 256 `"Staffordshire Moorlands"', modify
	label define local_authority_district 257 `"Stoke-on-Trent"', modify
	label define local_authority_district 258 `"Tamworth"', modify
	label define local_authority_district 270 `"Bromsgrove"', modify
	label define local_authority_district 271 `"Hereford (to 285)"', modify
	label define local_authority_district 272 `"Leominster (to 285)"', modify
	label define local_authority_district 273 `"Malvern Hills"', modify
	label define local_authority_district 274 `"Redditch"', modify
	label define local_authority_district 275 `"South Herefordshire (to 285)"', modify
	label define local_authority_district 276 `"Worcester"', modify
	label define local_authority_district 277 `"Wychavon"', modify
	label define local_authority_district 278 `"Wyre Forest"', modify
	label define local_authority_district 279 `"Bridgnorth (to 286)"', modify
	label define local_authority_district 280 `"North Shropshire (to 286)"', modify
	label define local_authority_district 281 `"Oswestry (to 286)"', modify
	label define local_authority_district 282 `"Shrewsbury and Atcham (to 286)"', modify
	label define local_authority_district 283 `"South Shropshire (to 286)"', modify
	label define local_authority_district 284 `"Telford and Wrekin"', modify
	label define local_authority_district 285 `"Herefordshire, County of"', modify
	label define local_authority_district 286 `"Shropshire"', modify
	label define local_authority_district 290 `"North Warwickshire"', modify
	label define local_authority_district 291 `"Nuneaton and Bedworth"', modify
	label define local_authority_district 292 `"Rugby"', modify
	label define local_authority_district 293 `"Stratford-upon-Avon"', modify
	label define local_authority_district 294 `"Warwick"', modify
	label define local_authority_district 300 `"Birmingham"', modify
	label define local_authority_district 302 `"Coventry"', modify
	label define local_authority_district 303 `"Dudley"', modify
	label define local_authority_district 305 `"Sandwell"', modify
	label define local_authority_district 306 `"Solihull"', modify
	label define local_authority_district 307 `"Walsall"', modify
	label define local_authority_district 309 `"Wolverhampton"', modify
	label define local_authority_district 320 `"Amber Valley"', modify
	label define local_authority_district 321 `"Bolsover"', modify
	label define local_authority_district 322 `"Chesterfield"', modify
	label define local_authority_district 323 `"Derby"', modify
	label define local_authority_district 324 `"Erewash"', modify
	label define local_authority_district 325 `"High Peak"', modify
	label define local_authority_district 327 `"North East Derbyshire"', modify
	label define local_authority_district 328 `"South Derbyshire"', modify
	label define local_authority_district 329 `"Derbyshire Dales"', modify
	label define local_authority_district 340 `"Ashfield"', modify
	label define local_authority_district 341 `"Bassetlaw"', modify
	label define local_authority_district 342 `"Broxtowe"', modify
	label define local_authority_district 343 `"Gedling"', modify
	label define local_authority_district 344 `"Mansfield"', modify
	label define local_authority_district 345 `"Newark and Sherwood"', modify
	label define local_authority_district 346 `"Nottingham"', modify
	label define local_authority_district 347 `"Rushcliffe"', modify
	label define local_authority_district 350 `"Boston"', modify
	label define local_authority_district 351 `"East Lindsey"', modify
	label define local_authority_district 352 `"Lincoln"', modify
	label define local_authority_district 353 `"North Kesteven"', modify
	label define local_authority_district 354 `"South Holland"', modify
	label define local_authority_district 355 `"South Kesteven"', modify
	label define local_authority_district 356 `"West Lindsey"', modify
	label define local_authority_district 360 `"Blaby"', modify
	label define local_authority_district 361 `"Hinkley and Bosworth"', modify
	label define local_authority_district 362 `"Charnwood"', modify
	label define local_authority_district 363 `"Harborough"', modify
	label define local_authority_district 364 `"Leicester"', modify
	label define local_authority_district 365 `"Melton"', modify
	label define local_authority_district 366 `"North West Leicestershire"', modify
	label define local_authority_district 367 `"Oadby and Wigston"', modify
	label define local_authority_district 368 `"Rutland"', modify
	label define local_authority_district 380 `"Corby"', modify
	label define local_authority_district 381 `"Daventry"', modify
	label define local_authority_district 382 `"East Northamptonshire"', modify
	label define local_authority_district 383 `"Kettering"', modify
	label define local_authority_district 384 `"Northampton"', modify
	label define local_authority_district 385 `"South Northamptonshire"', modify
	label define local_authority_district 386 `"Wellingborough"', modify
	label define local_authority_district 390 `"Cambridge"', modify
	label define local_authority_district 391 `"East Cambridgeshire"', modify
	label define local_authority_district 392 `"Fenland"', modify
	label define local_authority_district 393 `"Huntingdonshire"', modify
	label define local_authority_district 394 `"Peterborough"', modify
	label define local_authority_district 395 `"South Cambridgeshire"', modify
	label define local_authority_district 400 `"Breckland"', modify
	label define local_authority_district 401 `"Broadland"', modify
	label define local_authority_district 402 `"Great Yarmouth"', modify
	label define local_authority_district 404 `"Norwich"', modify
	label define local_authority_district 405 `"North Norfolk"', modify
	label define local_authority_district 406 `"South Norfolk"', modify
	label define local_authority_district 407 `"King's Lynn and West"', modify
	label define local_authority_district 410 `"Babergh"', modify
	label define local_authority_district 411 `"Forest Heath"', modify
	label define local_authority_district 412 `"Ipswich"', modify
	label define local_authority_district 413 `"Mid-Suffolk"', modify
	label define local_authority_district 414 `"St Edmondsbury"', modify
	label define local_authority_district 415 `"Suffolk Coastal"', modify
	label define local_authority_district 416 `"Waveney"', modify
	label define local_authority_district 420 `"Bedford (UA from Apr 2009)"', modify
	label define local_authority_district 421 `"Luton (UA from Apr 1997)"', modify
	label define local_authority_district 422 `"Mid-Bedfordshire (to 424)"', modify
	label define local_authority_district 423 `"South Bedfordshire (to 424)"', modify
	label define local_authority_district 424 `"Central Bedfordshire"', modify
	label define local_authority_district 430 `"Broxbourne"', modify
	label define local_authority_district 431 `"Dacorum"', modify
	label define local_authority_district 432 `"East Hertfordshire"', modify
	label define local_authority_district 433 `"North Hertfordshire"', modify
	label define local_authority_district 434 `"St Albans"', modify
	label define local_authority_district 435 `"Stevenage"', modify
	label define local_authority_district 436 `"Three Rivers"', modify
	label define local_authority_district 437 `"Watford"', modify
	label define local_authority_district 438 `"Welwyn Hatfield"', modify
	label define local_authority_district 450 `"Basildon"', modify
	label define local_authority_district 451 `"Braintree"', modify
	label define local_authority_district 452 `"Brentwood"', modify
	label define local_authority_district 453 `"Castle Point"', modify
	label define local_authority_district 454 `"Chelmsford"', modify
	label define local_authority_district 455 `"Colchester"', modify
	label define local_authority_district 456 `"Epping Forest"', modify
	label define local_authority_district 457 `"Harlow"', modify
	label define local_authority_district 458 `"Maldon"', modify
	label define local_authority_district 459 `"Rochford"', modify
	label define local_authority_district 460 `"Southend-on-Sea"', modify
	label define local_authority_district 461 `"Tendring"', modify
	label define local_authority_district 462 `"Thurrock"', modify
	label define local_authority_district 463 `"Uttlesford"', modify
	label define local_authority_district 470 `"Bracknell Forest"', modify
	label define local_authority_district 471 `"West Berkshire"', modify
	label define local_authority_district 472 `"Reading"', modify
	label define local_authority_district 473 `"Slough"', modify
	label define local_authority_district 474 `"Windsor and Maidenhead"', modify
	label define local_authority_district 475 `"Wokingham"', modify
	label define local_authority_district 476 `"Aylesbury Vale"', modify
	label define local_authority_district 477 `"South Bucks"', modify
	label define local_authority_district 478 `"Chiltern"', modify
	label define local_authority_district 479 `"Milton Keynes"', modify
	label define local_authority_district 480 `"Wycombe"', modify
	label define local_authority_district 481 `"Cherwell"', modify
	label define local_authority_district 482 `"Oxford"', modify
	label define local_authority_district 483 `"Vale of White Horse"', modify
	label define local_authority_district 484 `"South Oxfordshire"', modify
	label define local_authority_district 485 `"West Oxfordshire"', modify
	label define local_authority_district 490 `"Basingstoke and Deane"', modify
	label define local_authority_district 491 `"Eastleigh"', modify
	label define local_authority_district 492 `"Fareham"', modify
	label define local_authority_district 493 `"Gosport"', modify
	label define local_authority_district 494 `"Hart"', modify
	label define local_authority_district 495 `"Havant"', modify
	label define local_authority_district 496 `"New Forest"', modify
	label define local_authority_district 497 `"East Hampshire"', modify
	label define local_authority_district 498 `"Portsmouth"', modify
	label define local_authority_district 499 `"Rushmoor"', modify
	label define local_authority_district 500 `"Southampton"', modify
	label define local_authority_district 501 `"Test Valley"', modify
	label define local_authority_district 502 `"Winchester"', modify
	label define local_authority_district 505 `"Isle of Wight"', modify
	label define local_authority_district 510 `"Elmbridge"', modify
	label define local_authority_district 511 `"Guildford"', modify
	label define local_authority_district 512 `"Mole Valley"', modify
	label define local_authority_district 513 `"Reigate and Banstead"', modify
	label define local_authority_district 514 `"Runnymede"', modify
	label define local_authority_district 515 `"Surrey Heath"', modify
	label define local_authority_district 516 `"Tandridge"', modify
	label define local_authority_district 517 `"Waverley"', modify
	label define local_authority_district 518 `"Woking"', modify
	label define local_authority_district 530 `"Ashford"', modify
	label define local_authority_district 531 `"Canterbury"', modify
	label define local_authority_district 532 `"Dartford"', modify
	label define local_authority_district 533 `"Dover"', modify
	label define local_authority_district 535 `"Gravesham"', modify
	label define local_authority_district 536 `"Maidstone"', modify
	label define local_authority_district 538 `"Sevenoaks"', modify
	label define local_authority_district 539 `"Shepway"', modify
	label define local_authority_district 540 `"Swale"', modify
	label define local_authority_district 541 `"Thanet"', modify
	label define local_authority_district 542 `"Tonbridge and Malling"', modify
	label define local_authority_district 543 `"Tunbridge Wells"', modify
	label define local_authority_district 544 `"Medway"', modify
	label define local_authority_district 550 `"Brighton (to 565)"', modify
	label define local_authority_district 551 `"Eastbourne"', modify
	label define local_authority_district 552 `"Hastings"', modify
	label define local_authority_district 553 `"Hove (to 565)"', modify
	label define local_authority_district 554 `"Lewes"', modify
	label define local_authority_district 555 `"Rother"', modify
	label define local_authority_district 556 `"Wealden"', modify
	label define local_authority_district 557 `"Adur"', modify
	label define local_authority_district 558 `"Arun"', modify
	label define local_authority_district 559 `"Chichester"', modify
	label define local_authority_district 560 `"Crawley"', modify
	label define local_authority_district 562 `"Horsham"', modify
	label define local_authority_district 563 `"Mid-Sussex"', modify
	label define local_authority_district 564 `"Worthing"', modify
	label define local_authority_district 565 `"Brighton and Hove"', modify
	label define local_authority_district 570 `"City of London"', modify
	label define local_authority_district 580 `"East Devon"', modify
	label define local_authority_district 581 `"Exeter"', modify
	label define local_authority_district 582 `"North Devon"', modify
	label define local_authority_district 583 `"Plymouth"', modify
	label define local_authority_district 584 `"South Hams"', modify
	label define local_authority_district 585 `"Teignbridge"', modify
	label define local_authority_district 586 `"Mid-Devon"', modify
	label define local_authority_district 587 `"Torbay"', modify
	label define local_authority_district 588 `"Torridge"', modify
	label define local_authority_district 589 `"West Devon"', modify
	label define local_authority_district 590 `"Caradon (to 596)"', modify
	label define local_authority_district 591 `"Carrick (to 596)"', modify
	label define local_authority_district 592 `"Kerrier (to 596)"', modify
	label define local_authority_district 593 `"North Cornwall (to 596)"', modify
	label define local_authority_district 594 `"Penwith (to 596)"', modify
	label define local_authority_district 595 `"Restormel (to 596)"', modify
	label define local_authority_district 596 `"Cornwall"', modify
	label define local_authority_district 600 `"Bath (to 611)"', modify
	label define local_authority_district 601 `"Bristol, City of"', modify
	label define local_authority_district 602 `"Kingswood (to 612)"', modify
	label define local_authority_district 603 `"Northavon (to 612)"', modify
	label define local_authority_district 604 `"Wansdyke (to 611)"', modify
	label define local_authority_district 605 `"North Somerset"', modify
	label define local_authority_district 606 `"Mendip"', modify
	label define local_authority_district 607 `"Sedgemoor"', modify
	label define local_authority_district 608 `"Taunton Deane"', modify
	label define local_authority_district 609 `"West Somerset"', modify
	label define local_authority_district 610 `"South Somerset"', modify
	label define local_authority_district 611 `"Bath and NE Somerset"', modify
	label define local_authority_district 612 `"South Gloucestershire"', modify
	label define local_authority_district 620 `"Cheltenham"', modify
	label define local_authority_district 621 `"Cotswold"', modify
	label define local_authority_district 622 `"Forest of Dean"', modify
	label define local_authority_district 623 `"Gloucester"', modify
	label define local_authority_district 624 `"Stroud"', modify
	label define local_authority_district 625 `"Tewkesbury"', modify
	label define local_authority_district 630 `"Kennet (to 635)"', modify
	label define local_authority_district 631 `"North Wiltshire (to 635)"', modify
	label define local_authority_district 632 `"Salisbury (to 635)"', modify
	label define local_authority_district 633 `"Swindon"', modify
	label define local_authority_district 634 `"West Wiltshire (to 635)"', modify
	label define local_authority_district 635 `"Wiltshire"', modify
	label define local_authority_district 640 `"Bournemouth"', modify
	label define local_authority_district 641 `"Christchurch"', modify
	label define local_authority_district 642 `"North Dorset"', modify
	label define local_authority_district 643 `"Poole"', modify
	label define local_authority_district 644 `"Purbeck"', modify
	label define local_authority_district 645 `"West Dorset"', modify
	label define local_authority_district 646 `"Weymouth and Portland"', modify
	label define local_authority_district 647 `"East Dorset"', modify
	label define local_authority_district 720 `"Isle of Anglesey"', modify
	label define local_authority_district 721 `"Conwy"', modify
	label define local_authority_district 722 `"Gwynedd"', modify
	label define local_authority_district 723 `"Denbighshire"', modify
	label define local_authority_district 724 `"Flintshire"', modify
	label define local_authority_district 725 `"Wrexham"', modify
	label define local_authority_district 730 `"Blaenau Gwent"', modify
	label define local_authority_district 731 `"Caerphilly"', modify
	label define local_authority_district 732 `"Monmouthshire"', modify
	label define local_authority_district 733 `"Newport"', modify
	label define local_authority_district 734 `"Torfaen"', modify
	label define local_authority_district 740 `"Bridgend"', modify
	label define local_authority_district 741 `"Cardiff"', modify
	label define local_authority_district 742 `"Merthyr Tydfil"', modify
	label define local_authority_district 743 `"Neath & Port Talbot"', modify
	label define local_authority_district 744 `"Rhondda, Cynon, Taff"', modify
	label define local_authority_district 745 `"Swansea"', modify
	label define local_authority_district 746 `"The Vale of Glamorgan"', modify
	label define local_authority_district 750 `"Ceredigion"', modify
	label define local_authority_district 751 `"Carmarthenshire"', modify
	label define local_authority_district 752 `"Pembrokeshire"', modify
	label define local_authority_district 753 `"Powys"', modify
	label define local_authority_district 910 `"Aberdeen City"', modify
	label define local_authority_district 911 `"Aberdeenshire"', modify
	label define local_authority_district 912 `"Angus"', modify
	label define local_authority_district 913 `"Argyll & Bute"', modify
	label define local_authority_district 914 `"Scottish Borders"', modify
	label define local_authority_district 915 `"Clackmannanshire"', modify
	label define local_authority_district 916 `"West Dunbartonshire"', modify
	label define local_authority_district 917 `"Dumfries & Galloway"', modify
	label define local_authority_district 918 `"Dundee City"', modify
	label define local_authority_district 919 `"East Ayrshire"', modify
	label define local_authority_district 920 `"East Dunbartonshire"', modify
	label define local_authority_district 921 `"East Lothian"', modify
	label define local_authority_district 922 `"East Renfrewshire"', modify
	label define local_authority_district 923 `"City of Edinburgh"', modify
	label define local_authority_district 924 `"Falkirk"', modify
	label define local_authority_district 925 `"Fife"', modify
	label define local_authority_district 926 `"Glasgow City"', modify
	label define local_authority_district 927 `"Highland"', modify
	label define local_authority_district 928 `"Inverclyde"', modify
	label define local_authority_district 929 `"Midlothian"', modify
	label define local_authority_district 930 `"Moray"', modify
	label define local_authority_district 931 `"North Ayrshire"', modify
	label define local_authority_district 932 `"North Lanarkshire"', modify
	label define local_authority_district 933 `"Orkney Islands"', modify
	label define local_authority_district 934 `"Perth & Kinross"', modify
	label define local_authority_district 935 `"Renfrewshire"', modify
	label define local_authority_district 936 `"Shetland Islands"', modify
	label define local_authority_district 937 `"South Ayrshire"', modify
	label define local_authority_district 938 `"South Lanarkshire"', modify
	label define local_authority_district 939 `"Stirling"', modify
	label define local_authority_district 940 `"West Lothian"', modify
	label define local_authority_district 941 `"Western Isles (Eilean Siar)"', modify
	label define day_of_week 1 `"Sunday"', modify
	label define day_of_week 2 `"Monday"', modify
	label define day_of_week 3 `"Tuesday"', modify
	label define day_of_week 4 `"Wednesday"', modify
	label define day_of_week 5 `"Thursday"', modify
	label define day_of_week 6 `"Friday"', modify
	label define day_of_week 7 `"Saturday"', modify
	label define accident_severity 1 `"Fatal"', modify
	label define accident_severity 2 `"Serious"', modify
	label define accident_severity 3 `"Slight"', modify
	label define police_force 1 `"Metropolitan Police"', modify
	label define police_force 3 `"Cumbria"', modify
	label define police_force 4 `"Lancashire"', modify
	label define police_force 5 `"Merseyside"', modify
	label define police_force 6 `"Greater Manchester"', modify
	label define police_force 7 `"Cheshire"', modify
	label define police_force 10 `"Northumbria"', modify
	label define police_force 11 `"Durham"', modify
	label define police_force 12 `"North Yorkshire"', modify
	label define police_force 13 `"West Yorkshire"', modify
	label define police_force 14 `"South Yorkshire"', modify
	label define police_force 16 `"Humberside"', modify
	label define police_force 17 `"Cleveland"', modify
	label define police_force 20 `"West Midlands"', modify
	label define police_force 21 `"Staffordshire"', modify
	label define police_force 22 `"West Mercia"', modify
	label define police_force 23 `"Warwickshire"', modify
	label define police_force 30 `"Derbyshire"', modify
	label define police_force 31 `"Nottinghamshire"', modify
	label define police_force 32 `"Lincolnshire"', modify
	label define police_force 33 `"Leicestershire"', modify
	label define police_force 34 `"Northamptonshire"', modify
	label define police_force 35 `"Cambridgeshire"', modify
	label define police_force 36 `"Norfolk"', modify
	label define police_force 37 `"Suffolk"', modify
	label define police_force 40 `"Bedfordshire"', modify
	label define police_force 41 `"Hertfordshire"', modify
	label define police_force 42 `"Essex"', modify
	label define police_force 43 `"Thames Valley"', modify
	label define police_force 44 `"Hampshire"', modify
	label define police_force 45 `"Surrey"', modify
	label define police_force 46 `"Kent"', modify
	label define police_force 47 `"Sussex"', modify
	label define police_force 48 `"City of London"', modify
	label define police_force 50 `"Devon and Cornwall"', modify
	label define police_force 52 `"Avon and Somerset"', modify
	label define police_force 53 `"Gloucestershire"', modify
	label define police_force 54 `"Wiltshire"', modify
	label define police_force 55 `"Dorset"', modify
	label define police_force 60 `"North Wales"', modify
	label define police_force 61 `"Gwent"', modify
	label define police_force 62 `"South Wales"', modify
	label define police_force 63 `"Dyfed-Powys"', modify
	label define police_force 91 `"Northern"', modify
	label define police_force 92 `"Grampian"', modify
	label define police_force 93 `"Tayside"', modify
	label define police_force 94 `"Fife"', modify
	label define police_force 95 `"Lothian and Borders"', modify
	label define police_force 96 `"Central"', modify
	label define police_force 97 `"Strathclyde"', modify
	label define police_force 98 `"Dumfries and Galloway"', modify
	
	// Added by me, i.e. not taken from UK Data Service Stata files
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
	label define urban_or_rural_area 1 "Urban" , modify
	label define urban_or_rural_area 2 "Rural" , modify 
	label define urban_or_rural_area 3 "Unallocated" , modify
	label define age_band_of_driver	1	"Age 0 - 5", modify
	label define age_band_of_driver	2	"Age 6 - 10", modify
	label define age_band_of_driver	3	"Age 11 - 15", modify
	label define age_band_of_driver	4	"Age 16 - 20", modify
	label define age_band_of_driver	5	"Age 21 - 25", modify
	label define age_band_of_driver	6	"Age 26 - 35", modify
	label define age_band_of_driver	7	"Age 36 - 45", modify
	label define age_band_of_driver	8	"Age 46 - 55", modify
	label define age_band_of_driver	9	"Age 56 - 65", modify
	label define age_band_of_driver	10	"Age 66 - 75", modify
	label define age_band_of_driver	11	"Age Over 75", modify
	label define propulsion_code	1	"Petrol" , modify
	label define propulsion_code	2	"Heavy oil" , modify
	label define propulsion_code	3	"Electric" , modify
	label define propulsion_code	4	"Steam" , modify
	label define propulsion_code	5	"Gas" , modify
	label define propulsion_code	6	"Petrol/Gas (LPG)" , modify
	label define propulsion_code	7	"Gas/Bi-fuel" , modify
	label define propulsion_code	8	"Hybrid electric" , modify
	label define propulsion_code	9	"Fuel cells" , modify
	label define propulsion_code	10	"New fuel technology" , modify
}

// Assign Value labels to variables
label dir
local labnames = r(names)

// Value label names not matched show in red
foreach x in `labnames' {
	capture noisily label value `x' `x' 
}
	
