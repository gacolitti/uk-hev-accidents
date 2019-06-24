

****************************************
// Electric vs Hybrid/Electric
****************************************

// Estimate Models

foreach x in ped_slight ped_sf cyc_slight cyc_sf {
	
	// All Speed Zones
	preserve
	logit `x' hyb##ib1.speed elec##ib1.speed ulev_per $aam1c , or vce(cluster acc_index)
	est store `x'_aafs_he
	
	* Margins
	// Over speed zones
	margins , dydx(hyb elec) over(speed) post mcompare(bonferroni)
	est store `x'_aafs_he_ame
	restore

	// Low Speed Zones
	preserve
	drop if speed_low != 1
	logit `x' hyb elec ulev_per $aam1c , or vce(cluster acc_index)
	est store `x'safs_he
	
	* Margins
	margins , dydx(hyb elec) post mcompare(bonferroni)
	est store `x'_safs_he_ame
	restore
	
	}

****************************************

// Output Tables

// All Speed Zones

* Odds ratios
esttab ped*aafs_he cyc*aafs_he  using "Tables/Logit Estimation Results, All Speed Zones, 2010-2017, Hybrid vs. Electric.doc" , html width(100%) eform nogaps nonumbers nobaselevels legend collabels(none) eqlabels(none) onecell b(3) p(2) pr2(3) obslast label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
drop(2.speed 3.speed _cons) ///
indicate("$table1c" "Year Dummies = *year") ///
addnotes("Model includes interaction between HEV and low speed"  "Standard errors clustered at accident level" ) ///
title("Logistic Regression Estimation Results by Injury Group, All Speed Zones, 2010-2017, Hybrid vs. Electric") 

* Marginal effects
esttab ped*aafs_he_ame cyc*aafs_he_ame  using "Tables/AME, All Speed Zones, 2010-2017, Hybrid vs. Electric.doc", html width(100%) nogaps nonumbers legend collabels(none) eqlabels("dydx(Hybrid)" "dydx(Electric)") onecell b(3) p(2) obslast noomitted label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
addnotes("Model includes interaction between HEV and low speed" "Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of Hybrid/Electric Over Speed Zones, 2010-2017, Hybrid vs. Electric")


// Low Speed Zones

* Odds ratios
esttab ped*safs_he cyc*safs_he  using "Tables/Logit Estimation Results, Low Speed Zones, 2010-2017, Hybrid vs. Electric.doc" , html width(100%) eform collabels(none) eqlabels(none) nogaps nonumbers nobaselevels onecell b(3) p(2) pr2(3) label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal")  ///
indicate("$satable1c" "Year Dummies = *year") ///
addnotes("Year dummies and other covariates ommited to save space" "Standard errors clustered at accident level") ///
title("Logistic Regression Estimation Results by Injury Group, Low Speed Zones, 2010-2017, Hybrid vs. Electric")  

* Marginal effects
esttab ped*safs_he_ame cyc*safs_he_ame  using "Tables/AME, Low Speed Zones, 2010-2017, Hybrid vs. Electric.doc" , html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) noomitted onecell b(3) p(2) label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
varlabels(hyb "dydx(Hybrid)" elec "dydx(Electric)") ///
addnotes("Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of Hybrid/Electric, Low Speed Zones, 2010-2017, Hybrid vs. Electric")  


