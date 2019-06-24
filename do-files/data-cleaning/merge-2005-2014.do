
// Merge 2005-2014 UK Transport Data (Vehicle, Accident, Casualty)

clear 

// Import csv, save temp file
foreach x in accidents casualties vehicles {
	import delimited using "data/road-safety/`x'0514.csv"
	rename ïaccident_index acc_index
	tempfile `x'0514
	save ``x'0514'
	clear
}
		
// Merge accident, vehicle, casualty files
use `casualties0514'  , clear
merge m:m  acc_index vehicle_reference  using `vehicles0514' , nogenerate
merge m:m acc_index using `accidents0514'  , nogenerate

// Save temporary file
tempfile merged0514
save `merged0514' , replace
