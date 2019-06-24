
****************************************
// Interact HEV with Summer
****************************************

// Estimate Models

// HEV*Summer
foreach x in ped_slight ped_sf cyc_slight cyc_sf {
	
	// All Speed Zones
	preserve
	logit `x' 1.hyb_elec#1.summer $aam1c ulev_per , or vce(cluster acc_index)
	est store `x'_aafs_is
	
	* Margins
	// Over speed limit
	margins , dydx(hyb_elec) over(speed) post mcompare(bonferroni)
	est store `x'_aafs_is_ame
	restore

	// Low Speed Zone
	preserve
	drop if speed_low != 1
	logit `x' 1.hyb_elec#1.summer $sam1c ulev_per  , or vce(cluster acc_index)
	est store `x'safs_is
	
	* Margins
	margins , dydx(hyb_elec) post mcompare(bonferroni)
	est store `x'_safs_is_ame
	restore
	
	}

// HEV*Summer*Daylight
foreach x in ped_slight ped_sf cyc_slight cyc_sf {
	
	// All Speed Zones
	preserve
	logit `x' 1.hyb_elec#1.summer#1.daylight $aam1c ulev_per  , or vce(cluster acc_index)
	est store `x'_aafs_isd
	
	* Margins
	// Over speed limit
	margins , dydx(hyb_elec) over(speed) post mcompare(bonferroni)
	est store `x'_aafs_isd_ame
	restore

	// Low Speed Zone
	preserve
	drop if speed_low != 1
	logit `x' 1.hyb_elec#1.summer#1.daylight $sam1c ulev_per  , or vce(cluster acc_index)
	est store `x'safs_isd
	
	* Margins
	margins , dydx(hyb_elec) post mcompare(bonferroni)
	est store `x'_safs_isd_ame
	restore
	
	}
	
// HEV*Daylight*NoRain
foreach x in ped_slight ped_sf cyc_slight cyc_sf {
	
	// All Speed Zones
	preserve
	logit `x' 1.hyb_elec#1.daylight#1.norain $aam1c ulev_per  , or vce(cluster acc_index)
	est store `x'_aafs_idn
	
	* Margins
	// Over speed limit
	margins , dydx(hyb_elec) over(speed) post mcompare(bonferroni)
	est store `x'_aafs_idn_ame
	restore

	// Low Speed Zone
	preserve
	drop if speed_low != 1
	logit `x' 1.hyb_elec#1.daylight#1.norain $sam1c ulev_per  , or vce(cluster acc_index)
	est store `x'safs_idn
	
	* Margins
	margins , dydx(hyb_elec) post mcompare(bonferroni)
	est store `x'_safs_idn_ame
	restore
	
	}

// HEV*Summer*Daylight*NoRain
foreach x in ped_slight ped_sf cyc_slight cyc_sf {
	
	// All Speed Zones
	preserve
	logit `x' 1.hyb_elec#1.summer#1.daylight#1.norain $aam1c ulev_per  , or vce(cluster acc_index)
	est store `x'_aafs_isdn
	
	* Margins
	// Over speed limit
	margins , dydx(hyb_elec) over(speed) post mcompare(bonferroni)
	est store `x'_aafs_isdn_ame
	restore

	// Low Speed Zone
	preserve
	drop if speed_low != 1
	logit `x' 1.hyb_elec#1.summer#1.daylight#1.norain $sam1c ulev_per , or vce(cluster acc_index)
	est store `x'safs_isdn
	
	* Margins
	margins , dydx(hyb_elec) post mcompare(bonferroni)
	est store `x'_safs_isdn_ame
	restore
	
	}
	
****************************************

// Output Tables

// Interact Summer

// All Speed Zones

* Odds ratios
esttab ped*aafs_is cyc*aafs_is  using "Tables/Logit Estimation Results, All Speed Zones, 2010-2016, Interact Summer.doc" ,  html width(100%) eform nogaps nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) pr2(3) obslast label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
indicate("$table1c" "Year Dummies = *year") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors clustered at accident level" ) ///
title("Logistic Regression Estimation Results by Injury Group, All Speed Zones, 2010-2016, Interact Summer") 

* Marginal effects
esttab ped*aafs_is_ame cyc*aafs_is_ame  using "Tables/Logit Estimation Results, All Speed Zones, 2010-2016, Interact Summer.doc",  html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) obslast noomitted label append ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV Over Speed Zones, 2010-2016, Interact Summer")


// Low Speed Zone

* Odds ratios
esttab ped*safs_is cyc*safs_is  using "Tables/Logit Estimation Results, Low Speed Zones, 2010-2016, Interact Summer.doc" ,  html width(100%) eform collabels(none) eqlabels(none) nogaps nonumbers onecell b(3) p(2) pr2(3) obslast label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal")  ///
indicate("$satable1c" "Year Dummies = *year") ///
addnotes("Standard errors clustered at accident level") ///
title("Logistic Regression Estimation Results by Injury Group, Low Speed Zones, 2010-2016, Interact Summer")  

* Marginal effects
esttab ped*safs_is_ame cyc*safs_is_ame  using "Tables/Logit Estimation Results, Low Speed Zones, 2010-2016, Interact Summer.doc" ,  html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) noomitted onecell b(3) p(2) obslast label append ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
varlabels(1.hyb_elec "dydx(HEV)") ///
addnotes("Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV, Low Speed Zones, 2010-2016, Interact Summer")  


****************************************
// Interact Summer, Daylight

// All Speed Zones

* Odds ratios
esttab ped*aafs_isd cyc*aafs_isd  using "Tables/Logit Estimation Results, All Speed Zones, 2010-2016, Interact Summer*Daylight.doc" ,  html width(100%) eform nogaps nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) pr2(3) obslast label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
indicate("$table1c" "Year Dummies = *year") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors clustered at accident level" ) ///
title("Logistic Regression Estimation Results by Injury Group, All Speed Zones, 2010-2016, Interact Summer*Daylight") 

* Marginal effects
esttab ped*aafs_isd_ame cyc*aafs_isd_ame  using "Tables/Logit Estimation Results, All Speed Zones, 2010-2016, Interact Summer*Daylight.doc",  html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) obslast noomitted label append ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV Over Speed Zones, 2010-2016, Interact Summer*Daylight")


// Low Speed Zone

* Odds ratios
esttab ped*safs_isd cyc*safs_isd  using "Tables/Logit Estimation Results, Low Speed Zones, 2010-2016, Interact Summer*Daylight.doc" ,  html width(100%) eform collabels(none) eqlabels(none) nogaps nonumbers onecell b(3) p(2) pr2(3) obslast label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal")  ///
indicate("$satable1c" "Year Dummies = *year") ///
addnotes("Standard errors clustered at accident level") ///
title("Logistic Regression Estimation Results by Injury Group, Low Speed Zones, 2010-2016, Interact Summer*Daylight")  

* Marginal effects
esttab ped*safs_isd_ame cyc*safs_isd_ame  using "Tables/Logit Estimation Results, Low Speed Zones, 2010-2016, Interact Summer*Daylight.doc" ,  html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) noomitted onecell b(3) p(2) obslast label append ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
varlabels(hyb_elec "dydx(HEV)") ///
addnotes("Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV, Low Speed Zones, 2010-2016, Interact Summer*Daylight")  


****************************************
// Interact Daylight, No Rain

// All Speed Zones

* Odds ratios
esttab ped*aafs_idn cyc*aafs_idn  using "Tables/Logit Estimation Results, All Speed Zones, 2010-2016, Interact Daylight*No Rain.doc" ,  html width(100%) eform nogaps nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) pr2(3) obslast label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
indicate("$table1c" "Year Dummies = *year") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors clustered at accident level" ) ///
title("Logistic Regression Estimation Results by Injury Group, All Speed Zones, 2010-2016, Interact Daylight*No Rain") 

* Marginal effects
esttab ped*aafs_idn_ame cyc*aafs_idn_ame  using "Tables/Logit Estimation Results, All Speed Zones, 2010-2016, Interact Daylight*No Rain.doc",  html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) obslast noomitted label append ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV Over Speed Zones, 2010-2016, Interact Daylight*No Rain")


// Low Speed Zone

* Odds ratios
esttab ped*safs_idn cyc*safs_idn  using "Tables/Logit Estimation Results, Low Speed Zones, 2010-2016, Interact Daylight*No Rain.doc" ,  html width(100%) eform collabels(none) eqlabels(none) nogaps nonumbers onecell b(3) p(2) pr2(3) obslast label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal")  ///
indicate("$satable1c" "Year Dummies = *year") ///
addnotes( "Standard errors clustered at accident level") ///
title("Logistic Regression Estimation Results by Injury Group, Low Speed Zones, 2010-2016, Interact Daylight*No Rain")  

* Marginal effects
esttab ped*safs_idn_ame cyc*safs_idn_ame  using "Tables/Logit Estimation Results, Low Speed Zones, 2010-2016, Interact Daylight*No Rain.doc" ,  html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) noomitted onecell b(3) p(2) obslast label append ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
varlabels(1.hyb_elec "dydx(HEV)") ///
addnotes("Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV, Low Speed Zones, 2010-2016, Interact Daylight*No Rain")  


****************************************
// Interact Summer, Daylight, No Rain

// All Speed Zones

* Odds ratios
esttab ped*aafs_isdn cyc*aafs_isdn using "Tables/Logit Estimation Results, All Speed Zones, 2010-2016, Interact Summer*Daylight*No Rain.doc" ,  html width(100%) eform nogaps nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) pr2(3) obslast label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
indicate("$table1c" "Year Dummies = *year") ///
addnotes( "Model includes all interactions between HEV and speed" "Standard errors clustered at accident level" ) ///
title("Logistic Regression Estimation Results by Injury Group, All Speed Zones, 2010-2016, Interact Summer*Daylight*No Rain") 

* Marginal effects
esttab ped*aafs_isdn_ame cyc*aafs_isdn_ame  using "Tables/Logit Estimation Results, All Speed Zones, 2010-2016, Interact Summer*Daylight*No Rain.doc",  html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) obslast noomitted label append ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV Over Speed Zones, 2010-2016, Interact Summer*Daylight*No Rain")


// Low Speed Zone

* Odds ratios
esttab ped*safs_isdn cyc*safs_isdn  using "Tables/Logit Estimation Results, Low Speed Zones, 2010-2016, Interact Summer*Daylight*No Rain.doc" ,  html width(100%) eform collabels(none) eqlabels(none) nogaps nonumbers onecell b(3) p(2) pr2(3) obslast label replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal")  ///
indicate("$satable1c" "Year Dummies = *year") ///
addnotes("Standard errors clustered at accident level") ///
title("Logistic Regression Estimation Results by Injury Group, Low Speed Zones, 2010-2016, Interact Summer*Daylight*No Rain")  

* Marginal effects
esttab ped*safs_isdn_ame cyc*safs_isdn_ame  using "Tables/Logit Estimation Results, Low Speed Zones, 2010-2016, Interact Summer*Daylight*No Rain.doc" ,  html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) noomitted onecell b(3) p(2) obslast label append ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
varlabels(1.hyb_elec "dydx(HEV)") ///
addnotes("Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV, Low Speed Zones, 2010-2016, Interact Summer*Daylight*No Rain")  


