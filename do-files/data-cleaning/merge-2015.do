
// Merge 2015 UK Transport Data (Vehicle, Make, Accident, Casualty) 

// Import csv, save temp file
foreach x in accidents casualties vehicles {
	import delimited using "data/road-safety/`x'_2015.csv" , clear
	capture noisily rename ïaccident_index acc_index
	capture noisily rename accident_index acc_index
	tempfile `x'2015
	save ``x'2015'
}

// Merge accident, vehicle, and casualty files
use `vehicles2015' , clear	
merge m:m acc_index vehicle_reference using `casualties2015' , nogenerate
merge m:m acc_index  using `accidents2015' , nogenerate

// Save temporary file
tempfile merged2015
save `merged2015' 


