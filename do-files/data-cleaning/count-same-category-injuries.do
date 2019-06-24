

****************************************************************************************************


* Count Same-Category Injuries

****************************************************************************************************



// Determine the number of multiple same-category casualties by category
	
foreach x in driver passenger pedestrian {	

	tabstat tot_`x' if tot_`x' > 1 , statistics(count) save
	tabstat `x' , statistics(sum) save
	
	return list
	
	}

// Multiple driver casualties
di  100*(8/2243652)
note: Only 8 out of more than 2,200,000 vehicles with driver casualties had multiple driver casualties.

// Multiple passenger casualties
di 100*(157897/792113)
note: 20% of vehicles with passenger casualties had multiple passenger casualties. 

// Multiple pedestrian casualties
di 100*(15002/493296)
note: 3% of vehicles  with pedestrian casualties had multiple pedestrian casualties.

note: Cannot determine number of multiple cyclist casualties because in order to match the cyclist casualties we had to limit it to accidents involving only one cyclist casualty (vehnum ==2, where cyclist is considered a vehicle)
