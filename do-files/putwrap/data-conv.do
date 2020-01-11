
// Data
// local cyc_inj_nomtch_veh_per2 = trim("`: di %5.2f $cyc_inj_nomtch_veh_cnt / $vehicles_cnt'")
local cyc_inj_nomtch_veh_per2 = ($cyc_inj_nomtch_veh_cnt / $vehicles_cnt) * 100


putdocx begin
putdocx paragraph, style(Heading2)
putdocx text (`"II. Data "')
putdocx paragraph, style(Heading3)
putdocx text (`"UK Road Accidents Data "')
putdocx paragraph, 
putdocx text (`"	The data for this study come from the UK Department for Transport STATS19 "')
putdocx text (`"reporting system, which includes detailed information on all reported personal injury traffic "')
putdocx text (`"accidents. The data contain information pertinent to the accident including accident severity, "')
putdocx text (`"number of vehicles involved, number of injuries/casualties, speed limit, light and weather "')
putdocx text (`"conditions, and urbanization.1 Also included is information on the driver(s)/vehicle(s) involved in "')
putdocx text (`"the accident including variables for vehicle type, vehicle propulsion, and age of driver. Finally, "')
putdocx text (`"information on the person(s) injured/killed in the accident is also present, including variables for "')
putdocx text (`"whether the injury was sustained by a pedestrian, cyclist, driver, or passenger, the sex of the "')
putdocx text (`"injured person(s), their age, and the severity of the injury.  The interaction of injured party "')
putdocx text (`"(pedestrian or cyclist) and injury severity (slight and serious/fatal), represent our four outcome "')
putdocx text (`"variables.  Data are collapsed by unique “causing” vehicle after omitting vehicles that were "')
putdocx text (`"involved in the accident but did not cause injuries or contain passengers that experienced injuries "')
putdocx text (`"(i.e. damage-only vehicles). Therefore, every vehicle (observation) in the dataset is responsible "')
putdocx text (`"for at least one injury of some degree.(footnote) "')
putdocx paragraph, 
putdocx text (`"	Given the structure of the data, for accidents involving two or more vehicles in which a cyclist was "')
putdocx text (`"injured, it is not possible to determine which vehicle hit the cyclist, so these observations are "')
putdocx text (`"dropped. These comprise about "')
putdocx text ($cyc_inj_nomtch_veh_per), nformat(%4.2f)
putdocx text (`"% of cyclist injuries/casualties and "')
putdocx text (`cyc_inj_nomtch_veh_per2'), nformat(%4.2f)
putdocx text (`"% of the data. Only "')
putdocx text ($mult_ped_inj_per), nformat(%4.2f) 
putdocx text (`"% of incidents in which pedestrians were injured involved more than one pedestrian. As such, an "')
putdocx text (`"indicator for whether the injured party was a pedestrian is used rather than a continuous variable "')
putdocx text (`"for the number of pedestrians injured. "')
putdocx paragraph, 
putdocx text (`"	Hybrid/electric is the independent variable of interest "')
putdocx text (`"for most analyses, and is equal to 1 if a vehicle is either hybrid electric or full electric. "')
putdocx text (`"Table 1 lists the frequency of hybrid/electric vehicles involved in a personal injury accident "')
putdocx text (`"between 2000 and 2017. "')
putdocx text (`"The four interactions of injured party and injury-type represent our outcome variables, and are listed "')
putdocx text (`"in Table 2. Pedestrian Slight (PS), Pedestrian Severe/Fatal (PSF), Cyclist Slight (CS), and Cyclist "')
putdocx text (`"Severe/Fatal (CSF) are indicator variables equal to 1 if an injury was sustained by at least one "')
putdocx text (`"individual belonging to that group (person type/injury type). "')
putdocx paragraph, 
putdocx text (`"	The remaining variables are used to control for other circumstances surrounding the accident that "')
putdocx text (`"might be correlated with both the outcome variable and HEV. A summary of these control variables is "')
putdocx text (`"presented in Table 3. High speed (HSZ) is equal to 1 if the posted speed limit where an accident "')
putdocx text (`"occurred is greater than 50 mph, medium speed (MSZ) is equal to 1 if the posted speed limit is "')
putdocx text (`"between 30 and 51 mph, and low speed (LSZ) is equal to 1 if the posted speed limit is less than or "')
putdocx text (`"equal to 30 mph. Urban is equal to 1 if the accident occurred in an urban area. Dark is equal to "')
putdocx text (`"1 if an accident occurred at night. Spring, Summer, Winter, and Fall are season indicators. "')
putdocx text (`"Rain, snow, and fog indicate the weather during the time of the accident. Old driver, mid-age "')
putdocx text (`"driver, and young driver are indicator variables equal to 1 if the driver’s age is greater than or "')
putdocx text (`"equal to 66, between 36 and 65, or less than or equal to 35, respectively. Weekday is equal to 1 if "')
putdocx text (`"the accident occurred on a weekday, and weekend night is equal to 1 if the accident occurred on a "')
putdocx text (`"Friday night or Saturday night. Finally, taxi is a dummy equal to 1 if the vehicle is a taxi. "')
putdocx text (`"Driver fatal injury % is the percent of driver accidents that resulted in a fatality by district "')
putdocx text (`"and month, and is included "')
putdocx text (`"to control for unobserved emergency response and safety standards. ULEV % is the percent of licensed "')
putdocx text (`"vehicles that are classified as ultra-low emissions vehicles; Hybrid and electric vehicles comprise "')
putdocx text (`"the vast majority of this category. ULEV % is meant to control for the effect that an increased "')
putdocx text (`"stock of HEV vehicles might have on pedestrian and cyclist awareness of noise signals on the road. "')
putdocx text (`"Moreover, insofar as year dummies are insufficient in capturing the growth in ULEV stock because, "')
putdocx text (`"for example, the growth in ULEV stock varies by district and quarter, ULEV % is a necessary control. "')
putdocx text (`"ULEV % varies by district and quarter, but is only available for years 2010-2017. "')
putdocx paragraph, 
putdocx text (`"	Of the control variables, perhaps most important are the urban and speed variables. HEV accidents "')
putdocx text (`"are likely positively correlated with urban and low speed limit areas given the range limitations of "')
putdocx text (`"HEV vehicles (particularly electric vehicles), and at the same time urban and low speed limit areas "')
putdocx text (`"tend to have a denser concentration of pedestrians and cyclists. Therefore, omitting these variables "')
putdocx text (`"would likely positively bias the coefficient on HEV.(footnote) Furthermore, while HEVs emit less "')
putdocx text (`"sound at low "')
putdocx text (`"speeds, the noise propagated from HEVs converges to that of a normal internal combustion engine as "')
putdocx text (`"the speed of the vehicle increases and engine noise is dwarfed by wind and road surface noise. This "')
putdocx text (`"suggests that if HEVs pose an increased risk to pedestrians and cyclists, the effect should depend "')
putdocx text (`"upon low speed operation (i.e. an interaction effect). "')
count if hyb_elec == .
local hyb_elec_miss_per = (`r(N)' / $vehicles_cnt) * 100
putdocx paragraph, 
putdocx text (`"	A small fraction (<5%) of observations are missing one or more variables used in the analysis. "')
putdocx text (`"Moreover, "')
putdocx text (`hyb_elec_miss_per'), nformat(%4.2f)
putdocx text (`"% of vehicles are unidentified in the dataset, and "')
putdocx text (`"thus HEV is missing for these observations. The majority of these missing vehicle observations are "')
putdocx text (`"due to hit-and-run accidents, which likely account for about 11% of the data.(footnote)  The "')
putdocx text (`"remainder are likely mobility scooters, horses, and trams; vehicle "')
putdocx text (`"information is not recorded for these modes of transport. After omitting observations with missing "')
putdocx text (`"values in HEV and the main control variables, there remain "')
putdocx text ($vehicle_cnt), nformat(%9.0fc)
putdocx text (`"vehicles in the sample. "')
qui su ped_inj
local ped_inj_per = r(mean) * 100

qui su cyc_inj
local cyc_inj_per = r(mean) * 100

qui su hyb_elec
local hyb_elec_cnt = r(N)
local hyb_elec_per = r(mean) * 100

qui su hyb
local hyb_cnt = r(N)

qui su elec
local elec_cnt = r(N)

local hyb_per = (`hyb_cnt' / `hyb_elec_cnt') * 100
putdocx paragraph, 
putdocx text (`"	Pedestrians and cyclists constitute only "')
putdocx text (`ped_inj_per'), nformat(%4.2f)
putdocx text (`"% and "')
putdocx text (`cyc_inj_per'), nformat(%4.2f)
putdocx text (`"% of vehicles involved in a personal injury "')
putdocx text (`"accident, respectively.(footnote) Moreover, the vast majority of these are slight injuries, as "')
putdocx text (`"opposed to severe/fatal injuries. Over the sample period, only "')
putdocx text (`hyb_elec_cnt'), nformat(%9.0fc)
putdocx text (`"vehicles involved in personal injury accidents are either hybrid or electric. "')
putdocx text (`"This translates to about "')
putdocx text (`hyb_elec_per'), nformat(%4.2f)
putdocx text (`"% of all vehicles. Of this "')
putdocx text (`hyb_elec_per'), nformat(%4.2f)
putdocx text (`"%, "')
putdocx text (`hyb_cnt'), nformat(%9.0fc)
putdocx text (`"are hybrid and "')
putdocx text (`elec_cnt'), nformat(%9.0fc)
putdocx text (`"are electric vehicles. Therefore, "')
putdocx text (`hyb_per'), nformat(%4.2f)
putdocx text (`"% of HEVs are hybrid. "')
putdocx text (`"Moreover, the vast majority of both electric and hybrid vehicles in "')
putdocx text (`"the sample occur towards the end of the sample as the HEV stock has increased exponentially between "')
putdocx text (`"2000-2017. "')
preserve
ds, has(type string)
drop `r(varlist)'
ds
local varlist "`r(varlist)'"
tabstat `varlist', stats(mean n) save
matrix stats = r(StatTotal)

foreach x in `varlist' {
	local `x'_mean = stats[1, colnumb(stats, "`x'")]
	local `x'_per = ``x'_mean' * 100
	local `x'_cnt = stats[2, colnumb(stats, "`x'")]
}
restore
putdocx paragraph, 
putdocx text (`"	Looking at the control variables, "')
putdocx text (`dark_per'), nformat(%4.2f)
putdocx text (`"% of the sample occurred during the night. "')
putdocx text (`rain_per'), nformat(%4.2f)
putdocx text (`"% of the sample occurred during rainy conditions, and < "')
putdocx text (`fog_per'), nformat(%4.2f)
putdocx text (`"% occurred in fog. "')
putdocx text (`urban_per'), nformat(%4.2f)
putdocx text (`"% of the sample is in urban areas, compared to rural or unallocated areas which constitute the remainder. "')
putdocx text (`old_driver_per'), nformat(%4.2f)
putdocx text (`"% of drivers were at "')
putdocx text (`"least 66 years old, "')
putdocx text (`mid_age_driver_per'), nformat(%4.2f)
putdocx text (`"% were mid-age, and "')
putdocx text (`young_driver_per'), nformat(%4.2f)
putdocx text (`"% were 35 years of age or younger. "')
putdocx text (`speed_low_per'), nformat(%4.2f)
putdocx text (`"% of the sample occurred on roads with speed limits at or below 30 mph, "')
putdocx text (`speed_med_per'), nformat(%4.2f)
putdocx text (`"% between 31 and 50 mph, and "')
putdocx text (`speed_high_per'), nformat(%4.2f)
putdocx text (`"% at or above 50 mph. "')
putdocx text (`weekday_per'), nformat(%4.2f)
putdocx text (`"% of the sample occurred on a weekday, "')
putdocx text (`weekend_night_per'), nformat(%4.2f)
putdocx text (`"% occurred on a weekend night, and "')
putdocx text (`weekend_per'), nformat(%4.2f)
putdocx text (`"% occured on a weekend. For the full list of control variables, consult Table 3. "')
putdocx paragraph, 
putdocx text (`"	The main takeaways are 1) the vast majority of HEV accidents have occurred in recent years "')
putdocx text (`"coinciding with rapid HEV proliferation and 2) the cooccurrence of HEV and pedestrian or cyclist "')
putdocx text (`"injuries is still exceedingly rare, which makes estimation less precise. "')
putdocx paragraph, 
putdocx save manuscripts/data, replace
