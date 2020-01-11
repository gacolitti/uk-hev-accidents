
/*

Master do file for uk-hev-accidents project

NOTE: First change directory to match the project directory
NOTE: Temp files create interdependencies
NOTE: Must run data-cleaning do-files contemporaneously
NOTE: Must install wget, rename, and soffice on your
machine before running download-data.do

1. Clean UK Transport Data 

2. Analyzie the effect of hybrid-electric vehicles (HEVs) 
on pedestrian & cyclist collisions

*/

// CHANGE DIRECTORY FIRST!!!
global master_dir "~/Documents/stata/uk-hev-accidents"
cd "$master_dir"

timer clear
timer on 1
// Download data
// Must install wget, rename, and soffice first
do "do-files/download-data.do"
timer off 1
timer list
if r(t1) < 3600 {
	local time: di %9.0f r(t1) / 60
	local units "min."
} 
else {
	local time: di %9.1f r(t1) / 3600
	local units "hrs."
}

di `"Time for data-download: `time' `units'"'
capture noisily statapush , message(Data download completed in `time' `units')

timer on 2
capture log close
log using "log/data-cleaning-log" , replace

// Clean Data
include "do-files/data-cleaning/clean-data.do"

log close 

timer off 2
timer list
if r(t2) < 3600 {
	local time: di %9.0f r(t2) / 60
	local units "min."
} 
else {
	local time: di %9.1f r(t2) / 3600
	local units "hrs."
}
di `"Time for data-cleaning: `time' `units'"'
capture noisily statapush , message(Data cleaning completed in `time' `units')

est clear
timer on 3
capture log close
set graphics off
log using "log/data-analysis-log" , replace

// Load cleaned data
use "data/cleaned-data.dta" , clear

// Data
putdocx clear
tempfile data_conv
putwrap using do-files/analysis/data.do, saving(`data_conv') replace
include "`data_conv'"

// Estimate Using Full Sample
do "do-files/analysis/estimate-using-full-sample.do"

est clear 

// Controlling For ULEV Market Share
do "do-files/analysis/controlling-ulev-market-share.do"

est clear

// Electric vs Hybrid
do "do-files/analysis/electric-vs-hybrid.do"

est clear

// Separate Year Regressions
do "do-files/analysis/separate-year-regressions.do"

est clear

// Estimate using Full Sample & Added Controls
do "do-files/analysis/estimate-using-added-controls.do"

est clear

// Marginal Effects Over Year
do "do-files/analysis/marginal-effects-over-year.do"

est clear

// Logistic Regression Using Years 2000-2011
do "do-files/analysis/estimate-using-years-2000-2011.do"

est clear

// Logistic Regression Using Years 2012-2017
do "do-files/analysis/estimate-using-years-2012-2017.do"

est clear

// Intro
putdocx clear
putwrap using do-files/analysis/introduction.do, saving(do-files/putwrap/introduction-conv.do) replace
do "do-files/putwrap/introduction-conv.do"

log close
timer off 2
timer list
local time : di %9.1f r(t2)/3600
di "Time for analysis: " `time' " hours"

statapush , message(Analysis done. Time: `time' hours)

