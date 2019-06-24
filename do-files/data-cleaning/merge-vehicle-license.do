
****************************************************************************************************

* Merge ULEV & All License Data

****************************************************************************************************

use `all_lic_veh' , clear

merge 1:1 mdate using `ulev_eoq' , nogenerate

order mdate cqtr licveh lic_ulev , first

gen ulev_per = (lic_ulev/licveh)*100
label var ulev_per "ULEV (%)"

tempfile ulev_market_share

save `ulev_market_share'


