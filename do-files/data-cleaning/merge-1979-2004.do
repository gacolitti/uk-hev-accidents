
// Merge 1979-2004 UK Transport Data (Vehicle, Accident, Casualty)  

// Import csv, save temp file
foreach x in accidents vehicles casualty {
	import delimited using "data/road-safety/`x'7904.csv" , clear
	capture noisily rename  ïaccident_index  acc_index
	capture noisily rename ïacc_index acc_index
	tempfile `x'7904
	save ``x'7904' 
}

// Merge accident, vehicle, casualty files
use  `accidents7904' , clear
merge m:m  acc_index using `vehicles7904' , nogenerate
merge m:m  acc_index vehicle_reference using `casualty7904'  , nogenerate

// Save temporary file
tempfile merged7904
save `merged7904' 

