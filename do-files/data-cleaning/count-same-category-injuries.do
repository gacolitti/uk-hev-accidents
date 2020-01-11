
// Count Same-Category Injuries
// Determine the number of multiple same-category casualties by category
	
foreach x in driver passenger pedestrian {	
	tabstat tot_`x' if tot_`x' > 1 , statistics(count) save
	tabstat `x' , statistics(sum) save
	return list
}

// Multiple driver casualties
count if driver == 1
local vehicles_with_driver_injury = `r(N)'

count if driver_injury_sum > 1
local multiple_driver_injuries_per = 100 * (`r(N)' / `vehicles_with_driver_injury')

note: `: di %9.0fc `r(N)'' out of `: di %9.0fc `vehicles_with_driver_injury'' vehicles with driver ///
injuries had multiple driver injuries (`: di %9.2g `multiple_driver_injuries_per''%).

// Multiple passenger casualties
count if passenger == 1
local vehicles_with_passenger_injury = `r(N)'

count if passenger_injury_sum > 1
local multiple_passenger_injuries_per = 100 * (`r(N)' / `vehicles_with_passenger_injury')

note: `: di %9.0fc `r(N)'' out of `: di %9.0fc `vehicles_with_passenger_injury'' vehicles with ///
passenger injuries had multiple passenger injuries (`: di 9.2g `multiple_passenger_injuries_per''%)

// Multiple pedestrian casualties
count if pedestrian == 1
local vehicles_with_pedestrian_injury = `r(N)'

count if pedestrian_injury_sum > 1
local multiple_pedestrian_injuries_per = 100 * (`r(N)' / `vehicles_with_pedestrian_injury')

note: `: di %9.0fc `r(N)'' out of `: di %9.0fc `vehicles_with_pedestrian_injury'' vehicles with ///
pedestrian injuries had multiple pedestrian injuries ///
(`: di 9.2g `multiple_pedestrian_injuries_per''%)

note: Cannot determine number of multiple cyclist injuries because in order to match cyclist ///
injuries we had to limit it to accidents involving only one cyclist injury ///
(vehnum == 2, where cyclist is considered a vehicle)
