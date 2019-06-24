

*************************************************************
// 2010-2016, Separate Year Regressions
*************************************************************

note: Coefplot: Dropped interaction between high speed/medium speed & hyb_elec because not enough high speed pedestrian accidents.

// Baseline + ULEV%
foreach x in ped_slight ped_sf cyc_slight cyc_sf {

	forvalues i = 2010/2017 {

		// All Speed Zones
		preserve
		drop if year != `i' 
		logit `x' hyb_elec##1.speed $aam1c ulev_per , or vce(cluster acc_index) iterate(100) 
		est store `x'_aa_`i'
		
		* Margins
		// Over speed zones
		margins , dydx(hyb_elec) over(speed) post
		est store `x'_aa_ame_`i'
		restore
	
		// Low Speed Zones
		preserve
		drop if year != `i' 
		drop if speed_low != 1
		logit `x' hyb_elec $aam1c ulev_per , or vce(cluster acc_index) iterate(100) 
		est store `x'sa_`i'
		
		* Margins
		margins , dydx(hyb_elec) post
		est store `x'_sa_ame_`i'
		restore
	}
	
}


// Baseline + ULEV% + Added Controls
foreach x in ped_slight ped_sf cyc_slight cyc_sf {

	forvalues i = 2010/2017 {

		// All Speed Zones
		preserve
		drop if year != `i' 
		logit `x' hyb_elec##1.speed $aam1c $aam1d ulev_per , or vce(cluster acc_index) iterate(100) 
		est store `x'_aaac_`i'
		
		* Margins
		// Over speed zones
		margins , dydx(hyb_elec) over(speed) post
		est store `x'_aaac_ame_`i'
		restore
	
		// Low Speed Zones
		preserve
		drop if year != `i' 
		drop if speed_low != 1
		logit `x' hyb_elec $aam1c $aam1d ulev_per , or vce(cluster acc_index) iterate(100) 
		est store `x'saac_`i'
		
		* Margins
		margins , dydx(hyb_elec) post
		est store `x'_saac_ame_`i'
		restore
	}
	
}	


****************************************	
*** Coefplot- Graph Separate Year Regressions
*** Baseline + ULEV%

// Pedestrian Slight

graph drop _all
#delimit ;

coefplot ped_slight_aa_ame* , 
if(abs(@t) < 15)
name(ped_slight_aa_sy)
scale(0.70)
swapnames
aseq 
legend(off) 
mcolor(navy)
nooffset 
eqlabels( , labels labsize(vsmall))
xline(0) 
cismooth(color(navy)) 
grid(none) 
xtitle("{&Delta} Proability", size(vsmall)) 
ytitle( , size(vsmall)) 
ylabel( , labsize(vsmall)) 
xlabel(-.16(.04).16, labsize(vsmall) ) 
coeflabels( *2010 = "2010" *2011 = "2011" *2012 = "2012" *2013 = "2013" *2014 = "2014" *2015 = "2015" *2016 = "2016" *2017 = "2017") 
title("AME of HEV on Pedestrian Slight Injury, Annual Regressions", tstyle(size(small)))  
note("AME calculated from separate annual regressions" "Model includes all control variables listed in Table 1.1C & 1.2C" "Model includes interaction between HEV and low speed"  "Confidence intervals for 50 equally spaced levels (1, 3, ..., 99) with graduated color intensities and varying line widths" , size(vsmall)) ;

graph export "Graphs/Pedestrian Slight, All Speed Zones, Separate Year Regressions.eps" , orientation(portrait) logo(off) preview(on) replace ;

coefplot ped_slight_sa_ame* , 
if(abs(@t) < 15)
eqlabels( , labels labsize(vsmall))
name(ped_slight_sa_sy) 
scale(0.7)
swapnames 
aseq 
nolabels 
legend(off) 
mcolor(navy)
nooffset 
xline(0) 
cismooth(color(navy)) 
grid(none) 
xtitle("{&Delta} Proability", size(vsmall)) 
ytitle( , size(vsmall)) 
ylabel( , labsize(vsmall)) 
xlabel(-.16(.04).16, labsize(vsmall) ) 
title("AME of HEV on Pedestrian Slight Injury in Low Speed Limit Areas, Annual Regressions", tstyle(size(small)))  
coeflabels( *2010 = "2010" *2011 = "2011" *2012 = "2012" *2013 = "2013" *2014 = "2014" *2015 = "2015" *2016 = "2016" *2017 = "2017") 
note("AME calculated from separate annual regressions" "Model includes all control variables listed in Table 1.1C & 1.2C" "Confidence intervals for 50 equally spaced levels (1, 3, ..., 99) with graduated color intensities and varying line widths" , size(vsmall)) ;

graph export "Graphs/Pedestrian Slight, Low Speed Zones, Separate Year Regressions.eps" , orientation(portrait) logo(off) preview(on) replace ;

// Pedestrian severe/fatal
coefplot ped_sf_aa_ame* , 
if(abs(@t) < 15)
eqlabels( , labels labsize(vsmall))
name(ped_sf_aa_sy) 
swapnames 
scale(0.7) 
aseq 
nolabels 
legend(off) 
mcolor(navy)
nooffset 
xline(0) 
cismooth(color(navy)) 
grid(none) 
xtitle("{&Delta} Proability", size(vsmall)) 
ytitle( , size(vsmall)) 
ylabel( , labsize(vsmall)) 
xlabel(-.16(.04).16, labsize(vsmall) )
coeflabels(*2010 = "2010" *2011 = "2011" *2012 = "2012" *2013 = "2013" *2014 = "2014" *2015 = "2015" *2016 = "2016" *2017 = "2017") 
title("AME of HEV on Pedestrian Severe/Fatal Injury, Annual Regressions", tstyle(size(small)))  
note("AME calculated from separate annual regressions" "Model includes all control variables listed in Table 1.1C & 1.2C" "Model includes interaction between HEV and low speed"   "Confidence intervals for 50 equally spaced levels (1, 3, ..., 99) with graduated color intensities and varying line widths" , size(vsmall)) ;

graph export "Graphs/Pedestrian Severe-Fatal, All Speed Zones, Separate Year Regressions.eps" , orientation(portrait) logo(off) preview(on) replace ;

coefplot ped_sf_sa_ame* , 
if(abs(@t) < 15)
eqlabels( , labels labsize(vsmall))
name(ped_sf_sa_sy) 
swapnames 
scale(0.7) 
aseq 
nolabels 
legend(off) 
mcolor(navy)
nooffset 
xline(0) 
cismooth(color(navy)) 
grid(none) 
xtitle("{&Delta} Proability", size(vsmall)) 
ytitle( , size(vsmall)) 
ylabel( , labsize(vsmall)) 
xlabel(-.16(.04).16, labsize(vsmall) ) 
coeflabels( *2010 = "2010" *2011 = "2011" *2012 = "2012" *2013 = "2013" *2014 = "2014" *2015 = "2015" *2016 = "2016" *2017 = "2017") 
title("AME of HEV on Pedestrian Severe/Fatal Injury in Low Speed Zones, Annual Regressions", tstyle(size(small)))  
note("AME calculated from separate annual regressions" "Model includes all control variables listed in Table 1.1C & 1.2C"  "Confidence intervals for 50 equally spaced levels (1, 3, ..., 99) with graduated color intensities and varying line widths" , size(vsmall)) ;

graph export "Graphs/Pedestrian Severe-Fatal, Low Speed Zones, Separate Year Regressions.eps" , orientation(portrait) logo(off) preview(on) replace ;

// Cyclist Slight
coefplot cyc_slight_aa_ame* , 
if(abs(@t) < 15)
eqlabels( , labels labsize(vsmall))
name(cyc_slight_aa_sy) 
swapnames 
scale(0.7) 
aseq 
nolabels 
legend(off) 
mcolor(navy)
nooffset 
xline(0) 
cismooth(color(navy)) 
grid(none) 
xtitle("{&Delta} Proability", size(vsmall)) 
ytitle( , size(vsmall)) 
ylabel( , labsize(vsmall)) 
xlabel(-.16(.04).16, labsize(vsmall)) 
coeflabels(*2010 = "2010" *2011 = "2011" *2012 = "2012" *2013 = "2013" *2014 = "2014" *2015 = "2015" *2016 = "2016" *2017 = "2017") 
title("AME of HEV on Cyclist Slight Injury, Annual Regressions", tstyle(size(small)))  
note("AME calculated from separate annual regressions" "Model includes all control variables listed in Table 1.1C & 1.2C" "Model includes interaction between HEV and slow speed"   "Confidence intervals for 50 equally spaced levels (1, 3, ..., 99) with graduated color intensities and varying line widths" , size(vsmall)) ;

graph export "Graphs/Cyclist Slight, All Speed Zones, Separate Year Regressions.eps" , orientation(portrait) logo(off) preview(on) replace ;

coefplot cyc_slight_sa_ame* ,
if(abs(@t) < 15)
eqlabels( , labels labsize(vsmall))
name(cyc_slight_sa_sy) 
swapnames 
scale(0.7) 
aseq 
nolabels 
legend(off) 
mcolor(navy)
nooffset 
xline(0) 
cismooth(color(navy)) 
grid(none) 
xtitle("{&Delta} Proability", size(vsmall)) 
ytitle( , size(vsmall)) 
ylabel( , labsize(vsmall)) 
xlabel(-.16(.04).16, labsize(vsmall) ) 
coeflabels( *2010 = "2010" *2011 = "2011" *2012 = "2012" *2013 = "2013" *2014 = "2014" *2015 = "2015" *2016 = "2016" *2017 = "2017") 
title("AME of HEV on Cyclist Slight Injury in Low Speed Zones, Annual Regressions", tstyle(size(small)))  
note("AME calculated from separate annual regressions" "Model includes all control variables listed in Table 1.1C & 1.2C" "Confidence intervals for 50 equally spaced levels (1, 3, ..., 99) with graduated color intensities and varying line widths" , size(vsmall)) ;

graph export "Graphs/Cyclist Slight, Low Speed Zones, Sepearate Year Regressions.eps" , orientation(portrait) logo(off) preview(on) replace ;

// Cyclist severe/fatal
coefplot cyc_sf_aa_ame* , 
if(abs(@t) < 15)
eqlabels( , labels labsize(vsmall))
name(cyc_sf_aa_sy) 
swapnames 
scale(0.7)
aseq 
nolabels 
legend(off) 
mcolor(navy)
nooffset 
xline(0) 
cismooth(color(navy)) 
grid(none) 
xtitle("{&Delta} Proability", size(vsmall)) 
ytitle( , size(vsmall)) 
ylabel( , labsize(vsmall)) 
xlabel(-.16(.04).16, labsize(vsmall) ) 
coeflabels(*2010 = "2010" *2011 = "2011" *2012 = "2012" *2013 = "2013" *2014 = "2014" *2015 = "2015" *2016 = "2016" *2017 = "2017") 
title("AME of HEV on Cyclist Severe/Fatal Injury, Annual Regressions", tstyle(size(small)))  
note("AME calculated from separate annual regressions" "Model includes all control variables listed in Table 1.1C & 1.2C" "Model includes interaction between HEV and slow speed"   "Confidence intervals for 50 equally spaced levels (1, 3, ..., 99) with graduated color intensities and varying line widths" , size(vsmall)) ;

graph export "Graphs/Cyclist Severe-Fatal, All Speed Zones, Separate Year Regressions.eps" , orientation(portrait) logo(off) preview(on) replace ;

coefplot cyc_sf_sa_ame* , 
if(abs(@t) < 15)
eqlabels( , labels labsize(vsmall))
name(cyc_sf_sa_sy) 
swapnames 
scale(0.7) 
aseq 
nolabels 
legend(off) 
mcolor(navy)
nooffset 
xline(0) 
cismooth(color(navy)) 
grid(none) 
xtitle("{&Delta} Proability", size(vsmall)) 
ytitle( , size(vsmall)) 
ylabel( , labsize(vsmall)) 
xlabel(-.16(.04).16, labsize(vsmall) ) 
coeflabels( *2010 = "2010" *2011 = "2011" *2012 = "2012" *2013 = "2013" *2014 = "2014" *2015 = "2015" *2016 = "2016" *2017 = "2017") 
title("AME of HEV on Cyclist Severe/Fatal Injury in Low Speed Zones, Annual Regressions", tstyle(size(small)))  
note("AME calculated from separate annual regressions" "Model includes all control variables listed in Table 1.1C & 1.2C" "Confidence intervals for 50 equally spaced levels (1, 3, ..., 99) with graduated color intensities and varying line widths" , size(vsmall)) ;

graph export "Graphs/Cyclist Severe-Fatal, Low Speed Zones, Separate Year Regressions.eps" , orientation(portrait) logo(off) preview(on) replace ;


****************************************	
*** Coefplot- Graph Separate Year Regressions
*** Baseline + ULEV% + Added Controls

// Pedestrian Slight

graph drop _all
#delimit ;

coefplot ped_slight_aaac_ame* , 
if(abs(@t) < 15)
name(ped_slight_aaac_sy)
scale(0.70)
swapnames
aseq 
legend(off) 
mcolor(navy)
nooffset 
eqlabels( , labels labsize(vsmall))
xline(0) 
cismooth(color(navy)) 
grid(none) 
xtitle("{&Delta} Proability", size(vsmall)) 
ytitle( , size(vsmall)) 
ylabel( , labsize(vsmall)) 
xlabel(-.16(.04).16, labsize(vsmall) ) 
coeflabels( *2010 = "2010" *2011 = "2011" *2012 = "2012" *2013 = "2013" *2014 = "2014" *2015 = "2015" *2016 = "2016" *2017 = "2017") 
title("AME of HEV on Pedestrian Slight Injury, Added Controls, Annual Regressions", tstyle(size(small)))  
note("AME calculated from separate annual regressions" "Model includes all control variables listed in Table 1.1C, 1.2C, & 1D" "Model includes interaction between HEV and low speed"  "Confidence intervals for 50 equally spaced levels (1, 3, ..., 99) with graduated color intensities and varying line widths" , size(vsmall)) ;

graph export "Graphs/Pedestrian Slight, All Speed Zones, Added Controls, Separate Year Regressions.eps" , orientation(portrait) logo(off) preview(on) replace ;

coefplot ped_slight_saac_ame* , 
if(abs(@t) < 15)
eqlabels( , labels labsize(vsmall))
name(ped_slight_saac_sy) 
scale(0.7)
swapnames 
aseq 
nolabels 
legend(off) 
mcolor(navy)
nooffset 
xline(0) 
cismooth(color(navy)) 
grid(none) 
xtitle("{&Delta} Proability", size(vsmall)) 
ytitle( , size(vsmall)) 
ylabel( , labsize(vsmall)) 
xlabel(-.16(.04).16, labsize(vsmall) ) 
title("AME of HEV on Pedestrian Slight Injury in Low Speed Limit Areas,  Added Controls, Annual Regressions", tstyle(size(small)))  
coeflabels( *2010 = "2010" *2011 = "2011" *2012 = "2012" *2013 = "2013" *2014 = "2014" *2015 = "2015" *2016 = "2016" *2017 = "2017") 
note("AME calculated from separate annual regressions" "Model includes all control variables listed in Table 1.1C, 1.2C, & 1D" "Confidence intervals for 50 equally spaced levels (1, 3, ..., 99) with graduated color intensities and varying line widths" , size(vsmall)) ;

graph export "Graphs/Pedestrian Slight, Low Speed Zones, Added Controls, Separate Year Regressions.eps" , orientation(portrait) logo(off) preview(on) replace ;

// Pedestrian severe/fatal
coefplot ped_sf_aaac_ame* , 
if(abs(@t) < 15)
eqlabels( , labels labsize(vsmall))
name(ped_sf_aaac_sy) 
swapnames 
scale(0.7) 
aseq 
nolabels 
legend(off) 
mcolor(navy)
nooffset 
xline(0) 
cismooth(color(navy)) 
grid(none) 
xtitle("{&Delta} Proability", size(vsmall)) 
ytitle( , size(vsmall)) 
ylabel( , labsize(vsmall)) 
xlabel(-.16(.04).16, labsize(vsmall) )
coeflabels(*2010 = "2010" *2011 = "2011" *2012 = "2012" *2013 = "2013" *2014 = "2014" *2015 = "2015" *2016 = "2016" *2017 = "2017") 
title("AME of HEV on Pedestrian Severe/Fatal Injury, Added Controls, Annual Regressions", tstyle(size(small)))  
note("AME calculated from separate annual regressions" "Model includes all control variables listed in Table 1.1C, 1.2C, & 1D" "Model includes interaction between HEV and low speed"   "Confidence intervals for 50 equally spaced levels (1, 3, ..., 99) with graduated color intensities and varying line widths" , size(vsmall)) ;

graph export "Graphs/Pedestrian Severe-Fatal, All Speed Zones, Added Controls, Separate Year Regressions.eps" , orientation(portrait) logo(off) preview(on) replace ;

coefplot ped_sf_saac_ame* , 
if(abs(@t) < 15)
eqlabels( , labels labsize(vsmall))
name(ped_sf_saac_sy) 
swapnames 
scale(0.7) 
aseq 
nolabels 
legend(off) 
mcolor(navy)
nooffset 
xline(0) 
cismooth(color(navy)) 
grid(none) 
xtitle("{&Delta} Proability", size(vsmall)) 
ytitle( , size(vsmall)) 
ylabel( , labsize(vsmall)) 
xlabel(-.16(.04).16, labsize(vsmall) ) 
coeflabels( *2010 = "2010" *2011 = "2011" *2012 = "2012" *2013 = "2013" *2014 = "2014" *2015 = "2015" *2016 = "2016" *2017 = "2017") 
title("AME of HEV on Pedestrian Severe/Fatal Injury in Low Speed Zones, Added Controls, Annual Regressions", tstyle(size(small)))  
note("AME calculated from separate annual regressions" "Model includes all control variables listed in Table 1.1C, 1.2C, & 1D"  "Confidence intervals for 50 equally spaced levels (1, 3, ..., 99) with graduated color intensities and varying line widths" , size(vsmall)) ;

graph export "Graphs/Pedestrian Severe-Fatal, Low Speed Zones, Added Controls, Separate Year Regressions.eps" , orientation(portrait) logo(off) preview(on) replace ;

// Cyclist Slight
coefplot cyc_slight_aaac_ame* , 
if(abs(@t) < 15)
eqlabels( , labels labsize(vsmall))
name(cyc_slight_aaac_sy) 
swapnames 
scale(0.7) 
aseq 
nolabels 
legend(off) 
mcolor(navy)
nooffset 
xline(0) 
cismooth(color(navy)) 
grid(none) 
xtitle("{&Delta} Proability", size(vsmall)) 
ytitle( , size(vsmall)) 
ylabel( , labsize(vsmall)) 
xlabel(-.16(.04).16, labsize(vsmall)) 
coeflabels(*2010 = "2010" *2011 = "2011" *2012 = "2012" *2013 = "2013" *2014 = "2014" *2015 = "2015" *2016 = "2016" *2017 = "2017") 
title("AME of HEV on Cyclist Slight Injury, Added Controls, Annual Regressions", tstyle(size(small)))  
note("AME calculated from separate annual regressions" "Model includes all control variables listed in Table 1.1C, 1.2C, & 1D" "Model includes interaction between HEV and slow speed"   "Confidence intervals for 50 equally spaced levels (1, 3, ..., 99) with graduated color intensities and varying line widths" , size(vsmall)) ;

graph export "Graphs/Cyclist Slight, All Speed Zones, Added Controls, Separate Year Regressions.eps" , orientation(portrait) logo(off) preview(on) replace ;

coefplot cyc_slight_saac_ame* ,
if(abs(@t) < 15)
eqlabels( , labels labsize(vsmall))
name(cyc_slight_saac_sy) 
swapnames 
scale(0.7) 
aseq 
nolabels 
legend(off) 
mcolor(navy)
nooffset 
xline(0) 
cismooth(color(navy)) 
grid(none) 
xtitle("{&Delta} Proability", size(vsmall)) 
ytitle( , size(vsmall)) 
ylabel( , labsize(vsmall)) 
xlabel(-.16(.04).16, labsize(vsmall) ) 
coeflabels( *2010 = "2010" *2011 = "2011" *2012 = "2012" *2013 = "2013" *2014 = "2014" *2015 = "2015" *2016 = "2016" *2017 = "2017") 
title("AME of HEV on Cyclist Slight Injury in Low Speed Zones, Added Controls, Annual Regressions", tstyle(size(small)))  
note("AME calculated from separate annual regressions" "Model includes all control variables listed in Table 1.1C, 1.2C, & 1D" "Confidence intervals for 50 equally spaced levels (1, 3, ..., 99) with graduated color intensities and varying line widths" , size(vsmall)) ;

graph export "Graphs/Cyclist Slight, Low Speed Zones, Added Controls, Sepearate Year Regressions.eps" , orientation(portrait) logo(off) preview(on) replace ;

// Cyclist severe/fatal
coefplot cyc_sf_aaac_ame* , 
if(abs(@t) < 15)
eqlabels( , labels labsize(vsmall))
name(cyc_sf_aaac_sy) 
swapnames 
scale(0.7)
aseq 
nolabels 
legend(off) 
mcolor(navy)
nooffset 
xline(0) 
cismooth(color(navy)) 
grid(none) 
xtitle("{&Delta} Proability", size(vsmall)) 
ytitle( , size(vsmall)) 
ylabel( , labsize(vsmall)) 
xlabel(-.16(.04).16, labsize(vsmall) ) 
coeflabels(*2010 = "2010" *2011 = "2011" *2012 = "2012" *2013 = "2013" *2014 = "2014" *2015 = "2015" *2016 = "2016" *2017 = "2017") 
title("AME of HEV on Cyclist Severe/Fatal Injury, Added Controls, Annual Regressions", tstyle(size(small)))  
note("AME calculated from separate annual regressions" "Model includes all control variables listed in Table 1.1C, 1.2C, & 1D" "Model includes interaction between HEV and slow speed"   "Confidence intervals for 50 equally spaced levels (1, 3, ..., 99) with graduated color intensities and varying line widths" , size(vsmall)) ;

graph export "Graphs/Cyclist Severe-Fatal, All Speed Zones, Added Controls, Separate Year Regressions.eps" , orientation(portrait) logo(off) preview(on) replace ;

coefplot cyc_sf_saac_ame* , 
if(abs(@t) < 15)
eqlabels( , labels labsize(vsmall))
name(cyc_sf_saac_sy) 
swapnames 
scale(0.7) 
aseq 
nolabels 
legend(off) 
mcolor(navy)
nooffset 
xline(0) 
cismooth(color(navy)) 
grid(none) 
xtitle("{&Delta} Proability", size(vsmall)) 
ytitle( , size(vsmall)) 
ylabel( , labsize(vsmall)) 
xlabel(-.16(.04).16, labsize(vsmall) ) 
coeflabels( *2010 = "2010" *2011 = "2011" *2012 = "2012" *2013 = "2013" *2014 = "2014" *2015 = "2015" *2016 = "2016" *2017 = "2017") 
title("AME of HEV on Cyclist Severe/Fatal Injury in Low Speed Zones, Added Controls, Annual Regressions", tstyle(size(small)))  
note("AME calculated from separate annual regressions" "Model includes all control variables listed in Table 1.1C, 1.2C, & 1D" "Confidence intervals for 50 equally spaced levels (1, 3, ..., 99) with graduated color intensities and varying line widths" , size(vsmall)) ;

graph export "Graphs/Cyclist Severe-Fatal, Low Speed Zones, Added Controls, Separate Year Regressions.eps" , orientation(portrait) logo(off) preview(on) replace ;




