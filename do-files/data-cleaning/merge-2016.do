
// Merge 2016 UK Transport Data (Vehicle, Make, Accident, Casualty) 

// Import csv, save temp file
foreach x in accidents casualties vehicles {
	import delimited using "data/road-safety/`x'_2016.csv" , clear
	capture noisily rename ïaccident_index acc_index
	capture noisily rename accident_index acc_index
	tempfile `x'2016
	save ``x'2016'
}

// Merge accident, vehicle, & casualty files
use `vehicles2016' , clear	
merge m:m acc_index vehicle_reference using `casualties2016' , nogenerate
merge m:m acc_index  using `accidents2016' , nogenerate
destring speed_limit , replace force

// Save temporary file
tempfile merged2016
save `merged2016'


