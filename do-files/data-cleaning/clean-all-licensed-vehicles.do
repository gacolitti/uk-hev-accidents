
****************************************************************************************************

* Clean All Licensed Vehicles Data

****************************************************************************************************

import excel "data/vehicle-license/veh0101.xlsx", sheet("VEH0101") case(lower) cellrange(A9:J109) firstrow clear

destring cars-j , replace force

missings dropvars , force

drop total

gen cqtr = quarterly(quarter, "YQ")
format %tq cqtr

expand 3
sort cqtr

bysort cqtr: gen mdate = mofd(dofq(cqtr)) + _n - 1
format %tm mdate

drop quarter j

// Rename & label vars

label var cars "Licensed cars"

rename motorcycles mcyc
label var mcyc "Licensed motorcycles"

rename lightgoodsvehicles lgveh
label var lgveh "Licensed light-goods vehicles"

rename heavygoodsvehicles hgveh 
label var hgveh "Licensed heavy goods vehicles"

rename busesandcoaches buscoach 
label var buscoach "Licensed buses and coach vehicles"

rename othervehicles1 oveh
label var oveh "Licensed other vehicles"

rename i licveh 
label var licveh "Total licensed vehicles"

// Licenses originally in thousands, convert

foreach var in cars mcyc lgveh hgveh buscoach oveh licveh {
	
	replace `var' = `var'*1000
	
	}
	
tempfile all_lic_veh

save `all_lic_veh'



