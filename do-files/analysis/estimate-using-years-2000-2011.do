

****************************************
// Estimate Using Years 2000-2011
****************************************

// Estimate Models

foreach x in ped_slight ped_sf cyc_slight cyc_sf {
		
	// All Speed Zones
	preserve
	drop if year > 2011
	logit `x' 1.hyb_elec 1.hyb_elec#ib1.speed $aam1c , or vce(cluster acc_index)
	est store `x'_aa0011
	
	* Margins
	// Over speed zones
	margins , dydx(hyb_elec) over(speed) post mcompare(bonferroni)
	est store `x'_aa0011_ame
	restore

	// Low Speed Zones
	preserve
	drop if year > 2011
	drop if speed_low != 1
	logit `x' 1.hyb_elec $sam1c , or vce(cluster acc_index)
	est store `x'_sa0011
	
	* Margins
	margins , dydx(hyb_elec) post mcompare(bonferroni)
	est store `x'_sa0011_ame
	restore
	
	}
	
****************************************

// Output Tables

// All Speed Zones

* Odds ratios
esttab ped*aa0011 cyc*aa0011  using "Tables/Logit Estimation Results, All Speed Zones, 2000-2011.doc" ,  html width(100%) eform nogaps nonumbers nobaselevels legend collabels(none) eqlabels(none) onecell b(3) p(2) pr2(3) obslast label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal")  ///
indicate("$table1c" "Year Dummies = *year") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors clustered at accident level") ///
title("Logistic Regression Estimation Results by Injury Group, All Speed Zones, 2000-2011") 

* Marginal effects
esttab ped*aa0011_ame cyc*aa0011_ame using "Tables/Logit Estimation Results, All Speed Zones, 2000-2011.doc" ,  html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) obslast noomitted label append ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV Over Speed Zones, 2000-2011") 


// Low Speed Zones

* Odds ratios
esttab ped*sa0011 cyc*sa0011  using "Tables/Logit Estimation Results, Low Speed Zones, 2000-2011.doc" ,  html width(100%) eform collabels(none) eqlabels(none) nogaps nonumbers onecell b(3) p(2) pr2(3) obslast label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal")  ///
indicate("$satable1c" "Year Dummies = *year") ///
addnotes( "Standard errors clustered at accident level") ///
title("Logistic Regression Estimation Results by Injury Group, Low Speed Zones, 2000-2011")  

* Marginal effects
esttab ped*sa0011_ame cyc*sa0011_ame  using "Tables/Logit Estimation Results, Low Speed Zones, 2000-2011.doc" ,  html width(100%) nogaps nonumbers nobaselevels legend collabels(none) eqlabels(none) noomitted onecell b(3) p(2)obslast label append ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
varlabels(hyb_elec "dydx(HEV)") ///
addnotes("Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV, Low Speed Zones, 2000-2011")  

