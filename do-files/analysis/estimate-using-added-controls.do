

**********************************************
// Estimate Using Added Controls
**********************************************

// Estimate Models

foreach x in ped_slight ped_sf cyc_slight cyc_sf {
	
	// All Speed Zones
	preserve
	logit `x' 1.hyb_elec 1.hyb_elec#ib1.speed $aam1d $aam1c ulev_per , or vce(cluster acc_index)
	est store `x'_aafsac
	
	* Margins
	// Over Speed Zones
	margins , dydx(hyb_elec) over(speed) post mcompare(bonferroni)
	est store `x'_aafsac_ame
	restore

	// Low Speed Zones
	preserve
	drop if speed_low != 1
	logit `x' 1.hyb_elec $sam1d $sam1c ulev_per , or vce(cluster acc_index)
	est store `x'safsac
	
	* Margins
	margins , dydx(hyb_elec) post mcompare(bonferroni)
	est store `x'_safsac_ame
	restore
	
	}

****************************************

// Output Tables

// All Speed Zones

* Odds ratios
esttab ped*aafsac cyc*aafsac  using "Tables/Logit Estimation Results, All Speed Zones, Added Controls.doc" ,  html width(100%) eform nogaps nonumbers nobaselevels legend collabels(none) eqlabels(none) onecell b(3) p(2) pr2(3) obslast label replace ///
drop(2.speed 3.speed _cons) ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
indicate("$table1c" "$table1d" "Year Dummies = *year") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors clustered at accident level" ) ///
title("Logistic Regression Estimation Results by Injury Group, All Speed Zones, Added Controls") 

* Marginal effects
esttab ped*aafsac_ame cyc*aafsac_ame  using "Tables/Logit Estimation Results, All Speed Zones, Added Controls.doc",  html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) obslast noomitted label append ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV Over Speed Zones, Added Controls")


// Low Speed Zones

* Odds ratios
esttab ped*safsac cyc*safsac  using "Tables/Logit Estimation Results, Low Speed Zones, Added Controls.doc" ,  html width(100%) eform collabels(none) eqlabels(none) nogaps nonumbers nobaselevels onecell b(3) p(2) pr2(3) obslast label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal")  ///
indicate("$satable1c" "$table1d" "Year Dummies = *year") ///
addnotes("Standard errors clustered at accident level") ///
title("Logistic Regression Estimation Results by Injury Group, Low Speed Zones, Added Controls")  

* Marginal effects
esttab ped*safsac_ame cyc*safsac_ame  using "Tables/Logit Estimation Results, Low Speed Zones, Added Controls.doc" ,  html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) noomitted onecell obslast b(3) p(2) label append ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
varlabels(hyb_elec "dydx(HEV)") ///
addnotes("Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV, Low Speed Zones, Added Controls")  


