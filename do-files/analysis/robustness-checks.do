
********************************
// Robustness Checks
********************************


**********************************************
// Baseline


// Estimate Models

foreach x in ped_slight ped_sf cyc_slight cyc_sf {
	
	// All Speed Zones
	preserve
	logit `x' 1.hyb_elec 1.hyb_elec#ib1.speed $aam1c $aam1d , or vce(cluster acc_index)
	est store `x'_aafsacb
	
	* Margins
	// Over Speed Zones
	margins , dydx(hyb_elec) over(speed) post mcompare(bonferroni)
	est store `x'_aafsacb_ame
	restore

	// Low Speed Zones
	preserve
	drop if speed_low != 1
	logit `x' 1.hyb_elec $sam1c $sam1d , or vce(cluster acc_index)
	est store `x'safsacb
	
	* Margins
	margins , dydx(hyb_elec) post mcompare(bonferroni)
	est store `x'_safsacb_ame
	restore
	
	}



****************************************************
// Baseline + ULEV %

// Estimate Models

foreach x in ped_slight ped_sf cyc_slight cyc_sf {
	
	// All Speed Zones
	preserve
	logit `x' 1.hyb_elec 1.hyb_elec#ib1.speed $aam1c $aam1d ulev_per , or vce(cluster acc_index)
	est store `x'_aafsacbu
	
	* Margins
	// Over Speed Zones
	margins , dydx(hyb_elec) over(speed) post mcompare(bonferroni)
	est store `x'_aafsacbu_ame
	restore

	// Low Speed Zones
	preserve
	drop if speed_low != 1
	logit `x' 1.hyb_elec $sam1c $sam1d ulev_per , or vce(cluster acc_index)
	est store `x'safsacbu
	
	* Margins
	margins , dydx(hyb_elec) post mcompare(bonferroni)
	est store `x'_safsacbu_ame
	restore
}
	
******************************************************
// Hybrid vs. Electric


// Estimate Models

foreach x in ped_slight ped_sf cyc_slight cyc_sf {
	
	// All Speed Zones
	preserve
	logit `x' hyb elec $aam1c $aam1d ulev_per , or vce(cluster acc_index)
	est store `x'_aafsache
	
	* Margins
	// Over Speed Zones
	margins , dydx(hyb elec) over(speed) post mcompare(bonferroni)
	est store `x'_aafsache_ame
	restore

	// Low Speed Zones
	preserve
	drop if speed_low != 1
	logit `x' hyb elec $sam1c $sam1d ulev_per , or vce(cluster acc_index)
	est store `x'safsache
	
	* Margins
	margins , dydx(hyb elec) post mcompare(bonferroni)
	est store `x'_safsache_ame
	restore
}

// Output Tables

// All Speed Zones

// Ped slight

* Odds ratios
esttab ped_slight*aafs ped_slight*aafsacb ped_slight*safs ped_slight*aafs_u ped_slight*aafsacbu ped_slight*safs_u  using "Tables/Robustness Checks.doc" ,  html width(100%) eform nogaps nonumbers nobaselevels legend collabels(none) eqlabels(none) onecell b(3) p(2) pr2(3) obslast label replace unstack ///
drop(2.speed 3.speed _cons) ///
mlabels("Baseline" "Baseline + Added Controls" "Baseline + Full Interaction" "Baseline + ULEV %" "Baseline + ULEV % + Added Controls" "Baseline + ULEV % + Full Interaction") ///
indicate("$table1c" "$table1d" "Year Dummies = *year") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors clustered at accident level" ) ///
title("Logistic Regression Estimation Results for Pedestrian Slight Injuries, All Speed Zones, Added Controls") 

* Marginal effects
esttab ped_slight*aafs_ame ped_slight*aafsacb_ame ped_slight*safs_ame ped_slight*aafs_u_ame ped_slight*aafsacbu_ame  ped_slight*safs_u_ame using "Tables/Robustness Checks.doc",  html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) obslast noomitted label append ///
mlabels("Baseline" "Baseline + Added Controls" "Baseline + Full Interaction" "Baseline + ULEV %" "Baseline + ULEV % + Added Controls" "Baseline + ULEV % + Full Interaction") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV on Pedestrian Slight Injuries Over Speed Zones, Added Controls")


// Ped severe/fatal

* Odds ratios
esttab ped_sf*aafs ped_sf*aafsacb ped_sf*safs ped_sf*aafs_u ped_sf*aafsacbu ped_sf*safs_u using "Tables/Robustness Checks.doc" ,  html width(100%) eform nogaps nonumbers nobaselevels legend collabels(none) eqlabels(none) onecell b(3) p(2) pr2(3) obslast label append unstack ///
drop(2.speed 3.speed _cons) ///
mlabels("Baseline" "Baseline + Added Controls" "Baseline + Full Interaction" "Baseline + ULEV %" "Baseline + ULEV % + Added Controls" "Baseline + ULEV % + Full Interaction") ///
indicate("$table1c" "$table1d" "Year Dummies = *year") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors clustered at accident level" ) ///
title("Logistic Regression Estimation Results for Pedestrian Severe/Fatal Injuries, All Speed Zones, Added Controls") 

* Marginal effects
esttab ped_sf*aafs_ame ped_sf*aafsacb_ame ped_sf*safs_ame ped_sf*aafs_u_ame ped_sf*aafsacbu_ame  ped_sf*safs_u_ame using "Tables/Robustness Checks.doc",  html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) obslast noomitted label append ///
mlabels("Baseline" "Baseline + Added Controls" "Baseline + Full Interaction" "Baseline + ULEV %" "Baseline + ULEV % + Added Controls" "Baseline + ULEV % + Full Interaction") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV on Pedestrian Severe/Fatal Injuries Over Speed Zones, Added Controls")

// cyc slight

* Odds ratios
esttab cyc_slight*aafs cyc_slight*safs cyc_slight*aafsacb cyc_slight*aafs_u cyc_slight*aafsacbu cyc_slight*safs_u using "Tables/Robustness Checks.doc" ,  html width(100%) eform nogaps nonumbers nobaselevels legend collabels(none) eqlabels(none) onecell b(3) p(2) pr2(3) obslast label append unstack ///
drop(2.speed 3.speed _cons) ///
mlabels("Baseline" "Baseline + Added Controls" "Baseline + Full Interaction" "Baseline + ULEV %" "Baseline + ULEV % + Added Controls" "Baseline + ULEV % + Full Interaction") ///
indicate("$table1c" "$table1d" "Year Dummies = *year") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors clustered at accident level" ) ///
title("Logistic Regression Estimation Results for Cyclist Slight Injuries, All Speed Zones, Added Controls") 

* Marginal effects
esttab cyc_slight*aafs_ame cyc_slight*aafsacb_ame cyc_slight*safs_ame cyc_slight*aafs_u_ame cyc_slight*aafsacbu_ame cyc_slight*safs_u_ame using "Tables/Robustness Checks.doc",  html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) obslast noomitted label append ///
mlabels("Baseline" "Baseline + Added Controls" "Baseline + Full Interaction" "Baseline + ULEV %" "Baseline + ULEV % + Added Controls" "Baseline + ULEV % + Full Interaction") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV on Cyclist Slight Injuries Over Speed Zones, Added Controls")

// cyc severe/fatal


* Odds ratios
esttab cyc_sf*aafs cyc_sf*aafsacb cyc_sf*safs cyc_sf*aafs_u cyc_sf*aafsacbu cyc_sf*safs_u using "Tables/Robustness Checks.doc" ,  html width(100%) eform nogaps nonumbers nobaselevels legend collabels(none) eqlabels(none) onecell b(3) p(2) pr2(3) obslast label append unstack ///
drop(2.speed 3.speed _cons) ///
mlabels("Baseline" "Baseline + Added Controls" "Baseline + Full Interaction" "Baseline + ULEV %" "Baseline + ULEV % + Added Controls" "Baseline + ULEV % + Full Interaction") ///
indicate("$table1c" "$table1d" "Year Dummies = *year") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors clustered at accident level" ) ///
title("Logistic Regression Estimation Results for Cyclist Severe/Fatal Injuries, All Speed Zones, Added Controls") 

* Marginal effects
esttab cyc_sf*aafs_ame cyc_sf*aafsacb_ame cyc_sf*safs_ame cyc_sf*aafs_u_ame cyc_sf*aafsacbu_ame  cyc_sf*safs_u_ame using "Tables/Robustness Checks.doc",  html width(100%) nogaps nonumbers legend collabels(none) eqlabels(none) onecell b(3) p(2) obslast noomitted label append ///
mlabels("Baseline" "Baseline + Full Interaction" "Baseline + Added Controls" "Baseline + ULEV %" "Baseline + ULEV % + Added Controls" "Baseline + ULEV % + Full Interaction") ///
addnotes("Model includes all interactions between HEV and speed" "Standard errors adjusted for multiple comparisons using Bonferroni") /// 
title("Average Marginal Effects of HEV on Cyclist Severe/Fatal Injuries Over Speed Zones, Added Controls")


