

******************************************************************
// 2010-2017, Controlling for ULEV, HEV Marginal Effects Over Year
******************************************************************

graph drop _all

foreach x in ped_slight ped_sf cyc_slight cyc_sf {

	if `"`x'"' == "ped_slight" {
		local injury "Pedestrian Slight Injury"
		}
	
	if `"`x'"' == "ped_sf" {
		local injury "Pedestrian Severe-Fatal Injury"
		}
		
	if `"`x'"' == "cyc_slight" {
		local injury "Cyclist Slight Injury"
		}
		
	if `"`x'"' == "cyc_sf" {
		local injury "Cyclist Severe-Fatal Injury"
		}

	// All Speed Zones
	preserve
	logit `x' $aam1c 1.hyb_elec#i.year ulev_per , or vce(cluster acc_index)

	
	* Margins	
	margins , dydx(hyb_elec) over(i.year) mcompare(bonferroni) post
	est store `x'_aa_oy_ame
	
	coefplot , ///
	name(`x'_aa_oy) ///
	scale(0.7) ///
	cismooth ///
	grid(none) ///
	xline(0) ///
	xtitle("{&Delta} Probability", size(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	xlabel(-.1(.02).1, labsize(vsmall) ) ///
	coeflabels(2010* = "2010" 2011* = "2011" 2012* = "2012" 2013* = "2013" 2014* = "2014" 2015* = "2015" 2016* = "2016" 2017* = "2017") ///
	title(`"AME of HEV on `injury' Over Year"', tstyle(size(small))) ///
	note("Model includes all HEV*Year interactions and control variables listed in Table 1C & 1D" "Model includes all interactions between HEV and speed" "Confidence intervals for 50 equally spaced levels (1, 3, ..., 99) with graduated color intensities and varying line widths." "Bonferroni adjustments for multiple comparisons made to confidence intervals.", size(vsmall))	
	graph export `"Graphs/`injury', All Speed Zones, Marginal Effects Over Year.eps"' , orientation(portrait) logo(off) preview(on) replace
	restore


	// Low Speed Zones
	preserve
	drop if speed_low != 1
	
	logit `x' $sam1c 1.hyb_elec#i.year ulev_per , or vce(cluster acc_index)
	
	* Margins
	margins , dydx(hyb_elec) post over(i.year) mcompare(bonferroni)
	est store `x'_sa_oy_ame
	
	coefplot , ///
	name(`x'_sa_oy)  ///
	scale(0.7) ///
	cismooth ///
	grid(none) ///
	xline(0) ///
	xtitle("{&Delta} Probability" , size(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	xlabel( -.1(.02).1 , labsize(vsmall) ) ///
	coeflabels(2010* = "2010" 2011* = "2011" 2012* = "2012" 2013* = "2013" 2014* = "2014" 2015* = "2015" 2016* = "2016" 2017* = "2017") ///
	title(`"AME of HEV on `injury' Over Year, Low Speed Zones"', tstyle(size(small))) ///
	note("Model includes all HEV*Year interactions and control variables listed in Table 1C & 1D" "Confidence intervals for 50 equally spaced levels (1, 3, ..., 99) with graduated color intensities and varying line widths." "Bonferroni adjustments for multiple comparisons made to confidence intervals." , size(vsmall))
	graph export `"Graphs/`injury', Low Speed Zones, Marginal Effects Over Year.eps"' , orientation(portrait) logo(off) preview(on) replace
	restore
	
	}

	

	
	

