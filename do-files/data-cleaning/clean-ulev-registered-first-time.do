
****************************************************************************************************

* Clean Ultra-low Emissions Vehicles Registered First Time

****************************************************************************************************

import excel "data/vehicle-license/veh0170.xlsx", sheet("VEH0170") cellrange(A7:U53) case(lower) firstrow clear

drop in 1/10
replace date = "2010 Q1" in 1
rename date quarter

gen cqtr = quarterly(quarter, "YQ")
format %tq cqtr

expand 3
sort cqtr

drop quarter

bysort cqtr: gen mdate = mofd(dofq(cqtr)) + _n - 1
format %tm mdate

missings dropvars , force

// Rename & Label

rename total ulev_reg
label var ulev_reg "Total number of registered first time ultra-low emissions vehicles"

rename pigeligiblecars plugincars_greg
label var plugincars_greg "Registered first time plug-in grant eligible cars"

rename nonpigeligibleplugincars2 plugincar_ngreg
label var plugincar_ngreg "Registered first time plug-in non-grant eligible cars"

rename nonplugincars nonplugincars_reg
label var nonplugincars_reg "Registered first time non-plug-in cars"

rename quadricycles quadricycles_reg
label var quadricycles_reg "Registered first time quadricycles"

tempfile ULEV_R

save `ULEV_R'


