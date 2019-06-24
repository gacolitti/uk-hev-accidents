

****************************************************************************************************

* Link Cyclist to Vehicle

****************************************************************************************************

/* 

Cyclist casualties (injuries) originally assigned to the cyclist not to the vehicle that hit them. Cyclists
are considered vehicles in the original dataset. For the purposes of the current research, we would like
to know which type of vehicle (HEV or ICE) hit the cyclist. For accidents with only two vehicles involved
(one being the cyclist), we can determine which vehicle hit the cyclist and reassign the cyclist casualty 
to the correct vehicle before estimating a model. 

*/
		
// Create accident level cyclist variable ( = 1 if accident involved cyclist casualty)
// anycyclist var is equal to 1 if cyclist is equal to 1 for any vehicle involved in a particular accident
// Cyclists are considered vehicles here still

egen anycyclist = max(cyclist), by(acc_index) 

// Set casualty vars equal to 0 if missing & invovled in cyclist crash
// When number_of_vehicles > 2 we don't know which car hit the cyclist

foreach x in driver passenger pedestrian pedestrian_dup cyclist motocyc50 motocyc125 motocyc125p motocyc500p taxi occupant1 minibus1 bus jockey agvehocc tramocc goodsveh1 goodsveh2 goodsveh3 mobilscoot elecmotocyc othervehocc othermotocyc othergoodsveh motocycscootpass motocycriderpass motocyccomb motocyc125p_riderpass taxinotprivate occupant2 minibus2 goodsvehocc {

	replace `x' = 0 if anycyclist == 1 & `x' == . & number_of_vehicles == 2

	}

// Gen dummy for vehilces with no casualties
// This code must come after replacing missing casualty vars (including driver) to 0 for obs involved in cyclist accident and only two vehicles
// This code must come before replacing casualty vars to 0 instead of missing for vehicles with no casualties (damage-only vehicles)

gen damageonly = (driver == .) 
label var damageonly "Vehicle involved in personal injury accident that did not cause or suffer any injuries (casualties)"

// Replace casualty vars to 0 instead of missing for vehicles with no casualties (damage-only vehicles)
// Damage-only vehicles are vehicles involved in personal-injury accident but didn't cause or suffer injuries

foreach x in driver passenger pedestrian pedestrian_dup cyclist motocyc50 motocyc125 motocyc125p motocyc500p taxi occupant1 minibus1 bus jockey agvehocc tramocc goodsveh1 goodsveh2 goodsveh3 mobilscoot elecmotocyc othervehocc othermotocyc othergoodsveh motocycscootpass motocycriderpass motocyccomb motocyc125p_riderpass taxinotprivate occupant2 minibus2 goodsvehocc {

	replace `x' = 0 if damageonly == 1 

	}


****************************************************************************************************

// Reassign cyclist casualty to vehicles that hit them

replace cyclist = anycyclist if anycyclist == 1 & number_of_vehicles == 2

// Gen accident level cyclist injury severity 

egen any_cyc_casualty_severity1 = min(cyc_casualty_severity) , by(acc_index)

// Reassign cyclist casualty severity to vehicles that hit them

replace cyc_casualty_severity = any_cyc_casualty_severity1 if anycyclist == 1 & number_of_vehicles == 2

****************************************************************************************************

// Number cyclist vehicles we COULD match to vehicles
// vehicle_type = 1 for cyclist vehicles
count if number_of_vehicles == 2 & vehicle_type == 1 & year > 1999 & damageonly != 1
local x = r(N)

// Number of total cyclist vehicles 
count if vehicle_type == 1 & year > 1999 & damageonly != 1
local y = r(N)

// Percent of cyclist vehicles matched to vehicles
di `x'/`y'
local per = `x'/`y'

****************************************************************************************************

// Number cyclist we COULD NOT match to vehicles
// Number of cyclists involved in cyclist accident where number of vehicles involved is > 2 
count if number_of_vehicles > 2 & vehicle_type == 1 & year > 1999 & damageonly != 1
local `x' = r(N)

di `x'/`y'

// Number of cyclists involved in a cycllist-only-accident (only cyclists or ped invovled/injured)
preserve
gen cycveh = (vehicle_type ==1)

egen allcyclist = min(cycveh) , by(acc_index) // Equals 1 if all vehicles invovlved in an accident are cyclists

count if allcyclist == 1 & year > 1999 & damageonly != 1
local x = r(N)

restore

di `x'/`y'


****************************************************************************************************

// Drop original obs that treated cylists as vehicles
drop if vehicle_type == 1 


