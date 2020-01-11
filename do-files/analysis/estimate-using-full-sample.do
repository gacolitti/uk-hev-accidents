
// Estimate Using 2000-2017
set graphics off
graph drop _all

foreach x in ped_slight_inj ped_serious_inj cyc_slight_inj cyc_serious_inj {

	if `"`x'"' == "ped_slight_inj" {
		local injury "Pedestrian Slight Injury"
		}
	
	if `"`x'"' == "ped_serious_inj" {
		local injury "Pedestrian Severe-Fatal Injury"
		}
		
	if `"`x'"' == "cyc_slight_inj" {
		local injury "Cyclist Slight Injury"
		}
		
	if `"`x'"' == "cyc_serious_inj" {
		local injury "Cyclist Severe-Fatal Injury"
		}
	
	// All Speed Zones
	preserve
	logit `x' hyb_elec c.hyb_elec#c.speed_low speed_low speed_med urban ///
	dark fog rain ///
	slippery_road carriageway_hazard roundabout oneway_street ///
	ped_cross_facilities ped_cross_human_ctrl special_cond_at_site ///
	taxi young_driver mid_age_driver ///
	moving_off reversing slowing turning ///
  winter spring summer weekday weekend ///
	weekend_night drv_serious_inj_per i.year, ///
	or vce(cluster accident_index)
	est store `x'_aafs
	
	* Margins
	// Over speed zones
	margins, dydx(hyb_elec) over(speed_low speed_med speed_high) mcompare(bonferroni) post
	est store `x'_aafs_ame
	
	restore
}

// Logistic regression
estimates table ped*aafs cyc*aafs, varlabel equations(1) varwidth(30) noomitted b(%10.2f) star ///  
eform stats(N r2_p) keep(hyb_elec c.hyb_elec#c.speed_low speed_low urban)

putdocx clear
putdocx begin
putdocx table reg1 = etable , layout(autofitcontents) width(100%) ///
title("Table 4a: Logistic Estimation Results by Injury Group, 2000-2017") ///
note("Standard errors clustered at accident level") ///
note("Models include all controls listed in Table 3") ///
note("* p < 0.05, ** p < 0.01, *** p < 0.001")

putdocx table reg1(5,1) = ("HEV * Low Speed")
putdocx table reg1(2,2) = ("Pedestrian Slight")
putdocx table reg1(2,3) = ("Pedestrian Severe/Fatal")
putdocx table reg1(2,4) = ("Cyclist Slight")
putdocx table reg1(2,5) = ("Cyclist Severe/Fatal")
putdocx table reg1(2, 1) = ("")
putdocx table reg1(9, 1) = ("Pseudo R2")
putdocx table reg1(.,.), halign(left) 
putdocx table reg1(1,.), bold


// Marginal effects
estimates table ped*aafs_ame cyc*aafs_ame, varlabel equations(1) varwidth(30) noomitted b(%10.2g) star

putdocx table ame1 = etable, layout(autofitcontents) width(100%) ///
title("Table 4b: Average Marginal Effects of HEV Over Low Speed, 2000-2017") ///
note("Significance levels adjusted for multiple comparisons using Bonferroni") ///
note("* p < 0.05, ** p < 0.01, *** p < 0.001")

putdocx table ame1(2, 2) = ("Pedestrian Slight")
putdocx table ame1(2, 3) = ("Pedestrian Severe/Fatal")
putdocx table ame1(2, 4) = ("Cyclist Slight")
putdocx table ame1(2, 5) = ("Cyclist Severe/Fatal")
putdocx table ame1(2, 1) = ("")
putdocx table ame1(3, .), drop
putdocx table ame1(5, 1) = ("Low Speed")
putdocx table ame1(4, 1) = ("Medium Speed")
putdocx table ame1(3, 1) = ("High Speed")
putdocx table ame1(., .), halign(left) 
putdocx table ame1(1, .), bold

coefplot ped_slight_inj_aafs_ame, bylabel(Pedestrian Slight) || ///
ped_serious_inj_aafs_ame, bylabel(Pedestrian Serious) || ///
cyc_slight_inj_aafs_ame, bylabel(Cyclist Slight) || ///
cyc_serious_inj_aafs_ame, bylabel(Cyclist Serious) || , ///
scale(0.7) cismooth grid(none) xline(0) xlabel(-.08(.04).08, labsize(small) ) ///
xtitle("Average Marginal Effects", size(small)) ///
ylabel(, labsize(small)) ///
coeflabels(*1.speed_high* = "High Speed" *1.speed_med* = "Medium Speed" *1.speed_low* = "Low Speed") ///
byopts(rows(4) title("Figure 1", tstyle(size(medsmall)))) ///
subtitle(, size(small)) 
	
graph export "graphs/estimate-using-full-sample-ame.png", width(800) height(600) replace

putdocx paragraph, halign(center)
putdocx image "graphs/estimate-using-full-sample-ame.png"

putdocx save "manuscripts/estimate-using-full-sample", replace

