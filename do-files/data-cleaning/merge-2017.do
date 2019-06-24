
// Merge 2017 UK Transport Data (Vehicle, Make, Accident, Casualty) 

// Import csv, save temp file
foreach x in accidents casualties vehicles {
	import delimited using "data/road-safety/`x'_2017.csv" , clear
	capture noisily rename ïaccident_index acc_index
	capture noisily rename accident_index acc_index
	tempfile `x'2017
	save ``x'2017'
}

// Merge accident, vehicle, & casualty files
use `vehicles2017' , clear	
merge m:m acc_index vehicle_reference using `casualties2017' , nogenerate
merge m:m acc_index  using `accidents2017' , nogenerate

// Save temporary file
tempfile merged2017
save `merged2017'


