

*********************************************
// Include Driver Accidents & Monthly Dummies
*********************************************

// Estimate Models


foreach x in ped_slight ped_sf cyc_slight cyc_sf {
	
	// All areas
	preserve
	logit `x' hyb_elec##speed_low hyb_elec##speed_high daylight rain snow fog urban old_driver young_driver weekday weekend_night driver_fatal_per i.month i.year , or vce(cluster acc_index)
	est store `x'_aafs_dm
	
	* Margins
	// Over speed limit
	margins , dydx(hyb_elec) over(speed_low speed_high) post mcompare(bonferroni)
	est store `x'_aafs_dm_ame
	restore

	// Slow areas
	preserve
	drop if speed_low != 1
	logit `x' hyb_elec daylight rain snow fog urban old_driver young_driver weekday weekend_night driver_fatal_per i.month i.year , or vce(cluster acc_index)
	est store `x'safs_dm
	
	* Margins
	margins , dydx(hyb_elec) post mcompare(bonferroni)
	est store `x'_safs_dm_ame
	restore
	
	}

****************************************

// Output Tables

// All Areas

* Odds ratios
esttab ped*aafs_dm cyc*aafs_dm  using "Tables/Logit Estimation Results, All Speed Zones, Control Unobserved Emergency Response & Include Month Dummies" , rtf eform nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) pr2(3) obslast replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
keep(  1.hyb_elec 1.hyb_elec#1.speed_low	1.hyb_elec#1.speed_high  driver_fatal_per )  ///
order(1.hyb_elec 1.hyb_elec#1.speed_low	1.hyb_elec#1.speed_high 1.speed_low 1.speed_high  driver_fatal_per ) ///
varlabels( 1.hyb_elec "HEV" 1.hyb_elec#1.speed_low "HEV*Low Speed Zone" 1.hyb_elec#1.speed_high "HEV*High Speed Zone"  driver_fatal_per "Driver Fatal %") ///
addnotes( "Year dummies ommited to save space" "Standard errors clustered at accident level" ) ///
title("Logistic Regression Estimation Results by Injury Group, All Speed Zones, Control Unobserved Emergency Response & Include Month Dummies") 

* Marginal effects
esttab ped*aafs_dm_ame cyc*aafs_dm_ame  using "Tables/Logit Estimation Results, All Speed Zones, Control Unobserved Emergency Response & Include Month Dummies.rtf", rtf nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) obslast noomitted append ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
keep( 0.speed_low#0.speed_high 0.speed_low#1.speed_high 1.speed_low#0.speed_high) ///
varlabels(0.speed_low#0.speed_high "Low Speed = 0, High Speed = 0" 0.speed_low#1.speed_high "Low Speed = 0, High Speed = 1"	1.speed_low#0.speed_high "Low Speed = 1, High Speed = 0" )  /// 
addnotes("Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV Over Low/High Speed Zones, Control Unobserved Emergency Response & Include Month Dummies")


// Slow Areas

* Odds ratios
esttab ped*safs_dm cyc*safs_dm  using "Tables/Logit Estimation Results, Slow Speed Zones, Full Sample, Control Unobserved Emergency Response & Include Month Dummies.rtf" , rtf eform collabels(none) eqlabels(none) nonumbers onecell b(3) p(2) pr2(3) replace ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal")  ///
keep(hyb_elec  driver_fatal_per  )  ///
order(hyb_elec  driver_fatal_per ) ///
varlabels( hyb_elec "HEV"  driver_fatal_per "Driver Fatal %") ///
addnotes( "Year dummies ommited to save space" "Standard errors clustered at accident level") ///
title("Logistic Regression Estimation Results by Injury Group, Low Speed Zones, Full Sample, Control Unobserved Emergency Response & Include Month Dummies")  

* Marginal effects
esttab ped*safs_dm_ame cyc*safs_dm_ame  using "Tables/Logit Estimation Results, Slow Speed Zones, Full Sample, Control Unobserved Emergency Response & Include Month Dummies.rtf" , rtf nonumbers legend collabels(none) eqlabels(none) noomitted onecell b(3) p(2) append ///
mlabels("Pedestrian Slight" "Pedestrian Severe/Fatal" "Cyclist Slight" "Cyclist Severe/Fatal") ///
varlabels(hyb_elec "dydx(HEV)") ///
addnotes("Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV, Low Speed Zones, Full Sample, Control Unobserved Emergency Response & Include Month Dummies")  


