
//* Link Cyclist to Vehicle

/* 

Cyclist casualties (injuries) originally assigned to the cyclist not to the vehicle that hit them. Cyclists
are considered vehicles in the original dataset. For the purposes of the current research, we would like
to know which type of vehicle (HEV or ICE) hit the cyclist. For accidents with only two vehicles involved
(one being the cyclist), we can determine which vehicle hit the cyclist and reassign the cyclist casualty 
to the correct vehicle before estimating a model. 

*/

// Reassign cyclist casualty to vehicles that hit them
foreach x in cyclist cyc_slight_injury cyc_sf_injury {
	egen `x'_max = max(`x'), by(accident_index)
	replace `x' = `x'_max if `x'_max > 0 & number_of_vehicles == 2
}

// Number of cyclist injuries matched to a vehicle
count if number_of_vehicles == 2 & vehicle_type == 1 & driver_slight_injury != .
note: `: di %9.0fc `r(N)'' cyclist matched to vehicle that hit them.

// Number of cyclist injuries not matched to a vehicle
count if number_of_vehicles != 2 & vehicle_type == 1 & driver_slight_injury != .
note: `: di %9.0fc `r(N)'' cyclist not matched to vehicle that hit them and dropped.

foreach x in cyclist driver pedestrian passenger driver_slight_injury driver_sf_injury /// 
pssngr_slight_injury pssngr_sf_injury ///
ped_slight_injury ped_sf_injury {
	replace `x' = 0 if cyc_slight_injury_max > 0 & `x' == . & number_of_vehicles == 2
	replace `x' = 0 if cyc_sf_injury_max > 0 & `x' == . & number_of_vehicles == 2
}

// Remove orginal cyclist vehicles
drop if vehicle_type == 1

count
local n = `r(N)'
// Remove damage only vehicles
drop if driver_slight_injury == .

count
local damageonly = `n' - `r(N)'
note: `: di %9.0fc `damageonly'' damage-only vehicles dropped.
