

/*

wget options meaning:

-r            recursive
-l1           maximum recursion depth (1=use only this directory)
-H            span hosts (visit other hosts in the recursion)
-t1           Number of retries
-nd           Don't make new directories, put downloaded files in this one
-N            turn on timestamping
-A.zip        download only zip files
-erobots=off  execute "robots.off" as if it were a part of .wgetrc

*/

// Change working directory
global master_dir "/Users/Gio/Documents/stata/uk-hev-accidents/"
cd $master_dir

// Download road safety data
local toget "https://data.gov.uk/dataset/cb7ae6f0-4be6-4935-9277-47e5ce24a11f/road-safety-data/"
local dest "data/road-safety"
capture noisily mkdir "`dest'"
shell /usr/local/bin/wget -r -l1 -H -t1 -nd -N -np -A.zip -erobots=off `toget' -P `dest' --no-check-certificate

// Get 2018 data
local toget "https://data.gov.uk/dataset/cb7ae6f0-4be6-4935-9277-47e5ce24a11f/road-safety-data/"
local dest "data/road-safety"
shell /usr/local/bin/wget -r -l1 -H -t1 -nd -N -np -A.csv -erobots=off `toget' -P `dest' --no-check-certificate

// local dest "data/road-safety"
local dest "data/road-safety"
cd "`dest'"
local files : dir . files "*.zip"
foreach file of local files {
	di "Working on `file'"
	if strmatch("`file'", "*2017*") {
		shell mkdir 2017
		cd "2017" 
		unzipfile "../`file'"
		shell /usr/local/bin/rename -f 'y/A-Z/a-z/' *
		shell /usr/local/bin/rename -f 's/cas/casualties-2017/' cas.csv
		shell /usr/local/bin/rename -f 's/veh/vehicles-2017/' veh.csv
		shell /usr/local/bin/rename -f 's/acc/accidents-2017/' acc.csv
		shell /usr/local/bin/rename -f 's/dftroadsafety_//' *
		cd "../"
	} 
	else if strmatch("`file'", "*2016*") {
		shell mkdir 2016
		cd "2016"
		unzipfile "../`file'"
		shell /usr/local/bin/rename -f 'y/A-Z/a-z/' *
		shell /usr/local/bin/rename -f 's/cas/casualties-2016/' cas.csv
		shell /usr/local/bin/rename -f 's/veh/vehicles-2016/' veh.csv
		shell /usr/local/bin/rename -f 's/acc/accidents-2016/' acc.csv
		shell /usr/local/bin/rename -f 's/dftroadsafety_//' *
		cd "../"
	}
	else {
		unzipfile "`file'", replace
	}
	rm "`file'"
}

shell ditto 2016 .
shell ditto 2017 .
shell rm -R 2016
shell rm -R 2017

shell /usr/local/bin/rename -f 'y/A-Z/a-z/' *
shell /usr/local/bin/rename -f 's/dftroadsafety_//' *
shell /usr/local/bin/rename -f 's/dftroadsafetydata_//' *
shell /usr/local/bin/rename -f 's/([a-z])([0-9])/$1-$2/g' *
shell /usr/local/bin/rename -f 's/_/-/g' *
shell /usr/local/bin/rename -f 's/casualty/casualties/' *

// Rename 2019 files
shell /usr/local/bin/rename -f 's/ /-/g' *
shell /usr/local/bin/rename -f 's/road-safety-data---//' *
shell /usr/local/bin/rename -f 's/road-safety-data--//' *


shell /usr/local/bin/rename -f 's/_/-/g' *


local files : dir . files "bloodalcoholcontent-coronersdata*"
foreach file of local files {
	rm "`file'"
}

local files : dir . files "digitalbreathtestdata*"
foreach file of local files {
	rm "`file'"
}

rm "final-dft-casualties-dashboard-(2011-to-2015).xlsm"

// Remove unneeded year files 2009-2014 
local files : dir . files "*"
foreach file of local files {
	if regexm("`file'", "2009|2010|2011|2012|2013|2014") {
		rm "`file'"
	}
}

cd $master_dir

// Download vehicle license data
local dest "data/vehicle-license"
capture noisily mkdir "`dest'"
cd "`dest'"
local toget1 "https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/794454/veh0101.ods"
local toget2 "https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/794446/veh0130.ods"
local toget3 "https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/794453/veh0170.ods"

shell /usr/local/bin/wget -r -l1 -H -t1 -nd -N -np -A.ods -erobots=off `toget1' -P . --no-check-certificate
shell /usr/local/bin/wget -r -l1 -H -t1 -nd -N -np -A.ods -erobots=off `toget2' -P . --no-check-certificate
shell /usr/local/bin/wget -r -l1 -H -t1 -nd -N -np -A.ods -erobots=off `toget3' -P . --no-check-certificate

// Must install soffice first
// https://computingforgeeks.com/install-openoffice-libreoffice-macos-sierra/
shell /usr/local/bin/soffice --headless --convert-to xlsx *.ods

local files : dir . files "*.ods"
foreach file of local files {
	rm "`file'"
}

cd $master_dir
