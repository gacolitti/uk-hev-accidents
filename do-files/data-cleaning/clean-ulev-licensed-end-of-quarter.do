
****************************************************************************************************

* Clean Ultra-Low Emissions Vehicles Licensed End-of-Quarter

****************************************************************************************************

import excel "data/vehicle-license/veh0130.xlsx", sheet("VEH0130") cellrange(A7:U44) firstrow case(lower) clear
drop in 1

replace quarter = "2010 Q1" in 1

gen cqtr = quarterly(quarter, "YQ")
format %tq cqtr

expand 3
sort cqtr

drop quarter

bysort cqtr: gen mdate = mofd(dofq(cqtr)) + _n - 1
format %tm mdate

missings dropvars , force

// combine plug-in grant eligible vehicles
gen pigeligiblecars = pigeligiblecars23 + c
drop pigeligiblecars23 c

// Rename & Label

rename total lic_ulev
label var lic_ulev "ULEV licenses"

rename pigeligiblecars lic_plugincars_g
label var lic_plugincars_g "Plug-in grand-eligible licenses"

rename nonpigeligibleplugincars2 lic_plugincar_ng
label var lic_plugincar_ng "Plug-in non-grant eligible licenses"

rename nonplugincars lic_nonplugincars
label var lic_nonplugincars "Non-plug-in licenses"

rename quadricycles lic_quadricycles
label var lic_quadricycles "Quadricycle licenses"

tempfile ulev_eoq

destring *, replace

save `ulev_eoq'
