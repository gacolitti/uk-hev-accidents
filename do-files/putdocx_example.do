estimates table ped*aafs cyc*aafs, varlabel equations(1) varwidth(30) noomitted b(%10.2f) star ///  
eform stats(N r2_p) keep(1.hyb_elec 1.hyb_elec#ib1.speed ib1.speed urban)

putdocx clear
putdocx begin
putdocx table reg = etable , layout(autofitcontents) width(100%) ///
title("Logistic Regression Estimation Results by Injury Group, All Speed Zones, 2000-2017") ///
note("Standard errors clustered at accident level") ///
note("Models include all controls listed in Table 1C") ///
note("* p < 0.05, ** p < 0.01, *** p < 0.001")

putdocx table reg(7,1) = ("HEV * Medium Speed")
putdocx table reg(8,1) = ("HEV * High Speed")
putdocx table reg(11,1) = ("Medium Speed")
putdocx table reg(12,1) = ("High Speed")
putdocx table reg(2,2) = ("Pedestrian Slight")
putdocx table reg(2,3) = ("Pedestrian Severe/Fatal")
putdocx table reg(2,4) = ("Cyclist Slight")
putdocx table reg(2,5) = ("Cyclist Severe/Fatal")
putdocx table reg(2, 1) = ("")
putdocx table reg(15, 1) = ("Pseudo R2")

putdocx table reg(3,.), drop
putdocx table reg(4,.), drop
putdocx table reg(4,.), drop
putdocx table reg(6,.), drop
putdocx table reg(6,.), drop

putdocx table reg(.,.), halign(left) 
putdocx table reg(1,.), bold

putdocx save example, replace
