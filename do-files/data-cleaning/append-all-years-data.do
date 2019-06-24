
// Append UK Transprt Data 

// Append 2005-2014, 2015, 2016 to 1979-2004
use `merged7904' , clear
append using `merged0514' , force
append using `merged2015' , force
append using `merged2016' , force
append using `merged2017' , force

label var acc_index "Unique accident identifer code"
destring longitude latitude, replace ignore("NULL")





