
/*

Master do file for uk-hev-accidents project

NOTE: First change directory to match the project directory
NOTE: Temp files create interdependencies
NOTE: Must run data-cleaning do-files contemporaneously
NOTE: Must install wget, rename, and soffice oon your
machine before running download-data.do

1. Clean UK Transport Data 

2. Analyzie the effect of hybrid-electric vehicles (HEVs) 
on pedestrian & cyclist collisions

*/

// CHANGE DIRECTORY FIRST!!!
global master_dir "~/Documents/Projects/uk-hev-accidents"
cd "$master_dir"

// Download data
// Must install wget, rename, and soffice first
do "do-files/download-data.do"

/*

1. Clean UK Transport Data

*/

timer on 1
capture log close
log using "log/data-cleaning-log" , replace

// Merge 1979-2004 vehicle, accident, casualty data files
include "do-files/data-cleaning/merge-1979-2004.do"

// Merge 2005-2014 Vehicle, Accident, Casualty Data Files
include "do-files/data-cleaning/merge-2005-2014.do"

// Merge 2015 Vehicle, Make, Accident, Casualty Data Files
include "do-files/data-cleaning/merge-2015.do"

// Merge 2016 Vehicle, Make, Accident, Casualty Data Files
include "do-files/data-cleaning/merge-2016.do"

// Merge 2017 Vehicle, Make, Accident, Casualty Data Files
include "do-files/data-cleaning/merge-2017.do"

// Append All Years UK Transport Data
include "do-files/data-cleaning/append-all-years-data.do"

// Collapse UK Transport Data
include "do-files/data-cleaning/collapse-uk-transport-data.do"

// Link Cyclist to Vehicle
include "do-files/data-cleaning/link-cyclist-to-vehicle.do"

// Drop Damage-Only Vehicles
drop if damageonly == 1 
note: 1,836,811 vehicles neither caused nor suffered injuries ///
(damage-only vehicles) between 2000-2016

preserve

// Clean ULEV Licensed End-of-Quarter
include "do-files/data-cleaning/clean-ulev-licensed-end-of-quarter.do"

// Clean All Licensed Vehicles
include "do-files/data-cleaning/clean-all-licensed-vehicles.do"

// Merge ULEV & All Vehicle License Data
include "do-files/data-cleaning/merge-vehicle-license.do"

restore

// Merge Vehicle Licenses with Collapsed Accident Data
gen mdate = mofd(date)
merge m:1 mdate using `ulev_market_share' , keep(match master) nogenerate

// Apply value labels
include "do-files/data-cleaning/apply-value-labels.do"

// Order variables alphabetically
order * , alpha

// Save Cleaned Data to File
save "data/cleaned-data.dta" , replace

// End data-cleaning Log File
log close 
timer off 1
timer list
local time : di %9.1f r(t1)/3600
di "Time for data-cleaning: " `time' " hours"
capture noisily statapush , message(data-cleaning done. Time: `time' hours)

/* 

2. Analyzie the effect of hybrid-electric vehicles (HEVs) on pedestrian & cyclist collisions

*/

// Begin Data Analysis Log File
est clear
timer clear
timer on 2
capture log close
set graphics off
log using "log/data-analysis-log" , replace

// Load cleaned data
use "data/cleaned-data.dta" , clear

// Gen Vars
do "do-files/data-cleaning/gen-variables.do"

// Model Definitions
do "do-files/analysis/model-definitions.do"
 
// Count Same-Category Injuries
do "do-files/data-cleaning/count-same-category-injuries.do"

// Descriptive Statistics
do "do-files/analysis/descriptive-statistics.do"

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

// Interact HEV with Summer
// do "do-files/Analysis/Interact HEV with Summer.do"

log close
timer off 2
timer list
local time : di %9.1f r(t2)/3600
di "Time for analysis: " `time' " hours"

statapush , message(Analysis done. Time: `time' hours)

