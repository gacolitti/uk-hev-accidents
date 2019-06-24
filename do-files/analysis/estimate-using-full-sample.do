

****************************************
// Estimate Using 2000-2017
****************************************

// Estimate Models

foreach x in ped_slight ped_sf cyc_slight cyc_sf {
	
	// All Speed Zones
	preserve
	logit `x' 1.hyb_elec 1.hyb_elec#ib1.speed $aam1c , or vce(cluster acc_index)
	est store `x'_aafs
	
	* Margins
	// Over speed zones
	margins , dydx(hyb_elec) over(speed) post mcompare(bonferroni)
	est store `x'_aafs_ame
	restore

	// Low Speed Zones
	preserve
	drop if speed_low != 1
	logit `x' 1.hyb_elec $sam1c , or vce(cluster acc_index)
	est store `x'safs
	
	* Margins
	margins , dydx(hyb_elec) post mcompare(bonferroni)
	est store `x'_safs_ame
	restore
}

****************************************

// Output Tables

// All Speed Zones

* Odds ratios
esttab ped*aafs cyc*aafs using "Tables/Logit Estimation Results, All Speed Zones, 2000-2017.doc" ,  html width(100%) noomitted nobaselevels eform nogaps nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) pr2(3) obslast label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
indicate("Weather Groups = *weather" "Season Groups = *season" "Year Dummies = *year") ///
addnotes("Standard errors clustered at accident level" ) ///
title("Logistic Regression Estimation Results by Injury Group, All Speed Zones, 2000-2017") 

* Marginal effects
esttab ped*aafs_ame cyc*aafs_ame using "Tables/AME, All Speed Zones, 2000-2017.doc" , html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) obslast noomitted label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV Over Speed Zones, 2000-2017")


// Low Speed Zones

* Odds ratios
esttab ped*safs cyc*safs using "Tables/Logit Estimation Results, Low Speed Zones, 2000-2017.doc" , html width(100%) noomitted nobaselevels eform collabels(none) eqlabels(none) nogaps nonumbers onecell b(3) p(2) pr2(3) obslast label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal")  ///
indicate("$satable1c" "Year Dummies = *year") ///
addnotes("Standard errors clustered at accident level") ///
title("Logistic Regression Estimation Results by Injury Group, Low Speed Zones, 2000-2017")  

* Marginal effects
esttab ped*safs_ame cyc*safs_ame using "Tables/AME, Low Speed Zones, 2000-2017.doc" , html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) noomitted onecell b(3) p(2) obslast label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
varlabel(hyb_elec "dydx(HEV)") ///
addnotes("Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV, Low Speed Zones, 2000-2017")  


