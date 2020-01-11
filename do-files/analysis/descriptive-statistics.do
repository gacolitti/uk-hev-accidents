
// Descriptive statistics

// Left hand drive vehicles don't have propulsion info
count if was_vehicle_left_hand_drive == 2
note was_vehicle_left_hand_drive: `r(N)' vehicles left-hand-drive & thus don't include vehicle propulsion information

// HEV Accidents by Accident Category
summtab, by(hyb_elec) cat_vars(ped_slight ped_sf cyc_slight cyc_sf) ///
pval landscape replace word wordname(hev-by-accident-category) ///
title(HEV Accidents by Accident Category)

// HEV Accidents by Year
summtab, by(hyb_elec) cat_vars(year) replace word wordname("hev-accidents-by-year") ///
title("HEV Accidents by Year")

tabout speed_low speed_medium speed_high urban daylight winter spring summer fall rain snow fog young_driver mid_age_driver ///
old_driver weekday weekend_night vtaxi using ///
"./tables/group-control-variables.doc" , replace style(htm) twidth(80) units(%) ///
cells(freq col) oneway format(0c 2p) mi lines(single) ptotal(none) font(times new roman) ///
title("Table 1.1C: Group Control Variables") 

tabout carriageway_hazards road_surface_conditions special_conditions_at_site vehicle_manoeuvre ///
road_type using "./tables/additional-group-control-variables" , replace ///
 style(htm) twidth(100) units(%) cells(freq col) oneway format(0c 2p) mi lines(single) ///
 ptotal(none) font(times new roman) title("Table 1D: Additional Group Control Variables") 

estpost tabstat driver_fatal_per ulev_per, statistics(mean p50 sd) columns(statistics) 
esttab using "./tables/continuous-control-variables" , rtf replace nonumbers ///
label nomtitles noobs onecell cells("mean(fmt(a2)) p50 sd") ///
title("Table 1.2C: Continous Control Variables") ///
addnotes("ULEV % varies by district and quarter; Data only available for years 2010-2017" ///
"Driver Fatal % varies by district & month; Data available for all years (2000-2017)")





