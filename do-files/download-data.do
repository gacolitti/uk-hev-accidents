

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

// Download road safety data
local toget "https://data.gov.uk/dataset/cb7ae6f0-4be6-4935-9277-47e5ce24a11f/road-safety-data/"
local dest "data/road-safety"
capture noisily mkdir "`dest'"
shell /usr/local/bin/wget -r -l1 -H -t1 -nd -N -np -A.zip -erobots=off `toget' -P `dest' --no-check-certificate

cd "`dest'"
local files : dir . files "*.zip"
foreach file of local files {
	di "Working on `file'"
	if strmatch("`file'", "*2017*") {
		shell mkdir 2017
		cd "2017" 
		unzipfile "../`file'"
		shell /usr/local/bin/rename -f 'y/A-Z/a-z/' *
		shell /usr/local/bin/rename 's/cas/casualties_2017/' cas.csv
		shell /usr/local/bin/rename 's/veh/vehicles_2017/' veh.csv
		shell /usr/local/bin/rename 's/acc/accidents_2017/' acc.csv
		shell /usr/local/bin/rename 's/dftroadsafety_//' *
		cd "../"
	} 
	else if strmatch("`file'", "*2016*") {
		shell mkdir 2016
		cd "2016"
		unzipfile "../`file'"
		shell /usr/local/bin/rename -f 'y/A-Z/a-z/' *
		shell /usr/local/bin/rename 's/cas/casualties_2016/' cas.csv
		shell /usr/local/bin/rename 's/veh/vehicles_2016/' veh.csv
		shell /usr/local/bin/rename 's/acc/accidents_2016/' acc.csv
		shell /usr/local/bin/rename 's/dftroadsafety_//' *
		cd "../"
	}
	else {
		unzipfile "`file'", replace
	}
	rm "`file'"
}

shell /usr/local/bin/rename -f 'y/A-Z/a-z/' *
shell /usr/local/bin/rename 's/dftroadsafety_//' *

shell ditto 2016 .
shell ditto 2017 .

shell rm -R 2016
shell rm -R 2017

local files : dir . files "bloodalcoholcontent_coronersdata*"
foreach file of local files {
	rm "`file'"
}

local files : dir . files "digitalbreathtestdata*"
foreach file of local files {
	rm "`file'"
}

rm "final dft casualty dashboard (2011 to 2015).xlsm"
rm "q2_road_safety_data_2018_datagov.csv"

cd "$master_dir"

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

cd "$master_dir"