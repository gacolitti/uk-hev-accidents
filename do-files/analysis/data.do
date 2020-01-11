
// Data

local cat_vars "urban speed_low speed_med speed_high dark fog rain young_driver mid_age_driver old_driver winter spring summer fall slippery_road weekday weekend weekend_night carriageway_hazard moving_off reversing slowing turning roundabout oneway_street ped_cross_facilities ped_cross_human_ctrl special_cond_at_site taxi"

local cont_vars "ulev_per drv_serious_inj_per"

tempvar miss
egen `miss' = rowmiss(hyb_elec drv_serious_inj_per `cat_vars')

count
local obs_cnt = `r(N)'
local obs_cnt_str = trim("`: di %9.0fc `obs_cnt''")


count if `miss' == 0
local complete_obs_cnt = `r(N)'
local complete_obs_cnt_str = trim("`: di %9.0fc `complete_obs_cnt''")

preserve
ds, has(type string)
drop `r(varlist)'
ds
local varlist "`r(varlist)'"
tabstat `varlist', stats(mean sum) save
matrix stats = r(StatTotal)

foreach x in `varlist' {
	local `x'_mean = stats[1, colnumb(stats, "`x'")]
	local `x'_per = ``x'_mean' * 100
	local `x'_cnt = stats[2, colnumb(stats, "`x'")]
	
	local `x'_mean_str = trim("`: di %9.1gc ``x'_mean''")
	local `x'_per_str = trim("`: di %9.1g ``x'_per''" + "%")
	local `x'_cnt_str = trim("`: di %9.0fc ``x'_cnt''")
	
	if (``x'_per' < 1) {
		local `x'_per_str = trim("`: di %09.2fc ``x'_per''")
	}
}

restore

local cyc_inj_nomtch_veh_per_str = trim("`: di %9.1g scalar(cyc_inj_nomtch_veh_per)'%")
local mult_ped_inj_per_str = trim("`: di %9.1g scalar(mult_ped_inj_per)'%")

putdocx begin
putdocx paragraph, style(Heading2)
II. Data

putdocx paragraph, style(Heading3) 
UK Road Accidents Data 


	The data for this study come from the UK Department for Transport STATS19
reporting system, which includes detailed information on all reported personal injury traffic
accidents. The data contain information pertinent to the accident including accident severity,
number of vehicles involved, number of injuries/casualties, speed limit, light and weather
conditions, and urbanization.(footnote) 
Also included is information on the driver(s)/vehicle(s) involved in
the accident including variables for vehicle type, vehicle propulsion, and age of driver. Finally,
information on the person(s) injured/killed in the accident is also present, including variables for
whether the injury was sustained by a pedestrian, cyclist, driver, or passenger, the sex of the
injured person(s), their age, and the severity of the injury.  The interaction of injured party
(pedestrian or cyclist) and injury severity (slight and serious), represent our four outcome
variables.  Data are collapsed by unique “causing” vehicle after omitting vehicles that were
involved in the accident but did not cause injuries or contain passengers that experienced injuries
(i.e. damage-only vehicles). Therefore, every vehicle (observation) in the dataset is responsible
for at least one injury of some degree.(footnote)

	Given the structure of the data, for accidents involving two or more vehicles in which a cyclist was
injured, it is not possible to determine which vehicle hit the cyclist, so these observations are
dropped. These comprise about
putdocx text ("`cyc_inj_nomtch_veh_per_str'")
of vehicles with cyclist injuries. Only 
putdocx text ("`mult_ped_inj_per_str'") 
of vehicles in causing pedestrian injuries caused more than one pedestrian injury. As such, an
indicator for whether the injured party was a pedestrian is used rather than a continuous variable
for the number of pedestrians injured.

	Hybrid/electric is the independent variable of interest
for most analyses, and is equal to 1 if a vehicle is either hybrid electric or full electric. 
Table 1 lists the frequency of hybrid/electric vehicles involved in a personal injury accident
between 2000 and 2017. 
The four interactions of injured party and injury-type represent our outcome variables, and are listed
in Table 2. Pedestrian Slight (PS), Pedestrian serious (PSF), Cyclist Slight (CS), and Cyclist
serious (CSF) are indicator variables equal to 1 if an injury was sustained by at least one
individual belonging to that group (person type/injury type).
	
	The remaining variables are used to control for other circumstances surrounding the accident that
might be correlated with both the outcome variable and HEV. A summary of these control variables is
presented in Table 3. High speed (HSZ) is equal to 1 if the posted speed limit where an accident
occurred is greater than 50 mph, medium speed (MSZ) is equal to 1 if the posted speed limit is
between 30 and 51 mph, and low speed (LSZ) is equal to 1 if the posted speed limit is less than or
equal to 30 mph. Urban is equal to 1 if the accident occurred in an urban area. Dark is equal to
1 if an accident occurred at night. Spring, Summer, Winter, and Fall are season indicators.
Rain and fog indicate the weather during the time of the accident, and slippery road indicates
road conditions that reduce vehicle traction such as snow, ice, mud, or water. Old driver, mid-age
driver, and young driver are indicator variables equal to 1 if the driver’s age is greater than or
equal to 66, between 36 and 65, or less than or equal to 35, respectively. Weekday is equal to 1 if
the accident occurred on a weekday, weekend is equal to 1 if the accident occurred on a Friday
or Saturday, and weekend night is equal to 1 if the accident occurred on a
Friday night or Saturday night. Moving off, reversing, slowing, and turning are indicators for
the vehicle maneuver during the time of the accident. Roundabout and oneway street indicate the
type of street where the accident occured. Pedestrian crossing is an indicator for whether there
is a pedestrian crossing 	such as a zebra or footbridge within 50 meters from
where the accident occured. Pedestrian human control is equal to 1 if if there is a school crossing
patrol or other authorized patrol within 50 meters from the accident. Special conditions at sight
is equal to 1 if there is a special condition at the sight such as a traffic signal malfunction, 
defective sign, or roadwork. Finally, taxi is a dummy equal to 1 if the vehicle is a taxi.
Driver serious injury % is the percent of driver accidents that resulted in a fatality by district 
and month, and is included
to control for unobserved emergency response and safety standards. ULEV % is the percent of licensed
vehicles that are classified as ultra-low emissions vehicles; Hybrid and electric vehicles comprise
the vast majority of this category. ULEV % is meant to control for the effect that an increased
stock of HEV vehicles might have on pedestrian and cyclist awareness of noise signals on the road.
Moreover, insofar as year dummies are insufficient in capturing the growth in ULEV stock because,
for example, the growth in ULEV stock varies by district and quarter, ULEV % is a necessary control.
ULEV % varies by district and quarter, but is only available for years 2010-2017.
	
	Of the control variables, perhaps most important are the urban and speed variables. HEV accidents
are likely positively correlated with urban and low speed limit areas given the range limitations of
HEV vehicles (particularly electric vehicles), and at the same time urban and low speed limit areas
tend to have a denser concentration of pedestrians and cyclists. Therefore, omitting these variables
would likely positively bias the coefficient on HEV.(footnote) Furthermore, while HEVs emit less
sound at low
speeds, the noise propagated from HEVs converges to that of a normal internal combustion engine as
the speed of the vehicle increases and engine noise is dwarfed by wind and road surface noise. This
suggests that if HEVs pose an increased risk to pedestrians and cyclists, the effect should depend
upon low speed operation (i.e. an interaction effect).
	
putdocx pause
count if hyb_elec == .
local hyb_elec_miss_per = (`r(N)' / `obs_cnt') * 100
local hyb_elec_miss_per_str = trim("`: di %9.1gc `hyb_elec_miss_per''%")
putdocx resume
	
	A small fraction (<5%) of observations are missing one or more variables used in the analysis. 
Moreover, 
putdocx text ("`hyb_elec_miss_per_str'")
 of vehicles are unidentified in the dataset, and
thus HEV is missing for these observations. The majority of these missing vehicle observations are
hit-and-run accidents, which likely account for about 11% of the data.(footnote)  The
remainder are likely mobility scooters, horses, and trams; vehicle
information is not recorded for these modes of transport. After omitting observations with missing
values in HEV and the main control variables, there remain
 putdocx text ("`complete_obs_cnt_str'")
 vehicles in the sample.

putdocx pause
local hyb_per_of_hev = (`hyb_cnt' / `hyb_elec_cnt') * 100
local hyb_per_of_hev_str = trim("`: di %9.1gc `hyb_per_of_hev''%")
putdocx resume
	
	Pedestrians and cyclists constitute only 
putdocx text ("`ped_inj_per_str'")
 and
putdocx text ("`cyc_inj_per_str'")
 of vehicles involved in a personal injury
accident, respectively.(footnote) Moreover, the vast majority of these are slight injuries, as 
opposed to serious injuries. Over the sample period, only 
putdocx text ("`hyb_elec_cnt_str'")
 vehicles involved in personal injury accidents are either hybrid or electric. 
This translates to about 
putdocx text ("`hyb_elec_per_str'")
 of all vehicles. Of this
putdocx text ("`hyb_elec_per_str'")
, 
putdocx text ("`hyb_cnt_str'")
 are hybrid and 
putdocx text ("`elec_cnt_str'")
 are electric vehicles. Therefore, 
putdocx text ("`hyb_per_of_hev_str'")
of HEVs are hybrid.
Moreover, the vast majority of both electric and hybrid vehicles in
the sample occur towards the end of the sample as the HEV stock has increased exponentially between
2000-2018.
	
	Looking at the control variables, 
putdocx text ("`dark_per_str'")
 of the sample occurred during the night. 
putdocx text ("`rain_per_str'")
 of the sample occurred during rainy conditions, and < 
putdocx text ("`fog_per_str'"), nformat(%4.2f)
 occurred in fog. 
putdocx text ("`urban_per_str'")
 of the sample is in urban areas, compared to rural or unallocated areas which constitute the remainder.
putdocx text ("`old_driver_per_str'")
 of drivers were at least 66 years old, 
putdocx text ("`mid_age_driver_per_str'")
 were mid-age, and
putdocx text ("`young_driver_per_str'")
 were 35 years of age or younger. 
putdocx text ("`speed_low_per_str'")
 of the sample occurred on roads with speed limits at or below 30 mph, 
putdocx text ("`speed_med_per_str'")
 between 31 and 50 mph, and 
putdocx text ("`speed_high_per_str'")
 at or above 50 mph. 
putdocx text ("`weekday_per_str'")
 of the sample occurred on a weekday, 
putdocx text ("`weekend_night_per_str'")
 occurred on a weekend night, and
putdocx text ("`weekend_per_str'")
 occurred on a weekend. For the full list of control variables, consult Table 3.
	
	The main takeaways are 1) the vast majority of HEV accidents have occurred in recent years
coinciding with rapid HEV proliferation and 2) the cooccurrence of HEV and pedestrian or cyclist
injuries is still exceedingly rare, which makes estimation less precise.

putdocx pagebreak
putdocx save manuscripts/data, replace
putdocx pause

// // HEV freq by year
// summtab if `miss' == 0, by(hyb_elec) cat_vars(year) append ///
// word rowperc pnonmissfmt(3) catfmt(3) total ///
// wordname("manuscripts/data") ///
// title("Table 1: HEV Frequency by Year")

// putdocx resume
// putdocx begin
// putdocx pagebreak
// putdocx save manuscripts/data, append
// putdocx pause

// // Injury category freq 
// summtab if `miss' == 0, cat_vars(cyc_slight_inj cyc_serious_inj ped_slight_inj ped_serious_inj) ///
// append word wordname("manuscripts/data") total ///
// title("Table 2: Injury Category Frequency")

// putdocx resume
// putdocx begin
// putdocx pagebreak
// putdocx save manuscripts/data, append
// putdocx pause

// // Main control variables freq 
// summtab if `miss' == 0, cat_vars(`cat_vars') cont_vars(`cont_vars') ///
// append word wordname("manuscripts/data") total pnonmiss mean ///
// title("Table 3: Summary of Control Variables")

// putdocx resume
// putdocx begin
// putdocx pagebreak
// putdocx save manuscripts/data, append
// putdocx pause

