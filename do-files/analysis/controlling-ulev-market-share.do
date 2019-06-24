

*************************************************
// Full Sample, Controlling for ULEV Market Share
*************************************************

// Estimate Model

foreach x in ped_slight ped_sf cyc_slight cyc_sf {

	// All Speed Zones
	preserve
	logit `x' 1.hyb_elec 1.hyb_elec#ib1.speed $aam1c ulev_per , or vce(cluster acc_index)
	est store `x'_aafs_u
	
	* Margins	
	// Over speed zones
	margins , dydx(hyb_elec) over(speed) post mcompare(bonferroni)
	est store `x'_aafs_u_ame
	restore


	// Low Speed Zones
	preserve
	drop if speed_low != 1
	logit `x' 1.hyb_elec $sam1c ulev_per , or vce(cluster acc_index)
	est store `x'safs_u
	
	* Margins
	margins , dydx(hyb_elec) post mcompare(bonferroni)
	est store `x'_safs_u_ame
	restore
	
	}
	
// Output Tables

// All Speed Zones

* Odds ratios
esttab ped*aafs_u cyc*aafs_u  using "Tables/Logit Estimation Results, All Speed Zones, Controlling for ULEV.doc" , html width(100%) nogaps eform nonumbers nobaselevels legend collabels(none) eqlabels(none) onecell b(3) p(2) pr2(3) obslast label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal")  ///
drop(_cons 2.speed 3.speed) ///
indicate("$table1c" "Year Dummies = *year") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors clustered at accident level" "ULEV % available for years 2010-2017") ///
title("Logistic Regression Estimation Results by Injury Group, All Speed Zones, Controlling for ULEV") 

* Marginal effects
esttab ped*aafs_u_ame cyc*aafs_u_ame using "Tables/AME, All Speed Zones, Controlling for ULEV.doc" , html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) obslast noomitted label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal")  ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV Over Low/High Speed Zones, Controlling for ULEV") 


// Low Speed Zones

* Odds ratios
esttab ped*safs_u cyc*safs_u  using "Tables/Logit Estimation Results, Low Speed Zones, Controlling for ULEV.doc" , html width(100%) nogaps eform collabels(none) eqlabels(none) nonumbers nobaselevels onecell b(3) p(2) pr2(3) obslast nocons label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal")  ///
indicate("$satable1c" "Year Dummies = *year") ///
addnotes("Standard errors clustered at accident level" "ULEV % available for years 2010-2017") ///
title("Logistic Regression Estimation Results by Injury Group, Low Speed Zones, Controlling for ULEV")  

* Marginal effects
esttab ped*safs_u_ame cyc*safs_u_ame  using "Tables/AME, Low Speed Zones, Controlling for ULEV.doc" , html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) noomitted onecell b(3) p(2)obslast label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
varlabels(hyb_elec "dydx(HEV)") ///
addnotes("Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV, Low Speed Zones, Controlling for ULEV")  

	
