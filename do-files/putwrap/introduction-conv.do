
// Introduction

distinct accident_index
global vehicles_cnt = `r(N)'
global accidents_cnt = `r(ndistinct)'

putdocx begin
putdocx paragraph, style(Heading2)
putdocx text (`"Introduction "')
putdocx paragraph, 
putdocx text (`"Within the past decade, hybrid and electric vehicles (HEVs) have become increasingly popular "')
putdocx text (`"around the world. Global HEV car stock surpassed 3 million vehicles in 2017, up from less than "')
putdocx text (`"0.5 million in 2013 (IEA, 2018, Figure 2.1). This acceleration in the stock of HEV vehicles is "')
putdocx text (`"fueled in part by world governments’ recognition that emissions from internal combustion "')
putdocx text (`"engine (ICE) vehicles significantly increase atmospheric pollutants, particularly carbon dioxide, "')
putdocx text (`"and that subsidizing the electrification of transport is necessary to reduce these emissions "')
putdocx text (`"(Paris Agreement 2015; IEA, 2017, p. 34). Moreover, technological advancements including "')
putdocx text (`"dramatic reductions in production cost and increases in efficiency of HEV batteries may "')
putdocx text (`"also be contributing to demand (IEA, 2018, Figure 5.3). Still, HEVs only represent a small share "')
putdocx text (`"of the total passenger vehicle market. In 2017, Norway led in HEV adoption with a rate of 29 percent, "')
putdocx text (`"followed by a distant second 6.4 percent in the Netherlands, 3.4 percent in Sweden, 1.5 percent "')
putdocx text (`"in China, France, and the UK, and 0.9 percent in the U.S. (IEA, 2017, Figure 14).  "')
putdocx paragraph, 
putdocx text (`"While transport electrification reduces noise and particulate pollution, recent evidence indicates "')
putdocx text (`"that HEVs are also harder for pedestrians and cyclists (P & C) to detect (Mendoca et al., 2013; "')
putdocx text (`"Michael et al., 2014). In addition to road pavement type and vehicle speed, the engine represents a "')
putdocx text (`"main source of noise propagated from vehicles, especially at low speeds. Therefore, HEVs may pose an "')
putdocx text (`"increased risk to P & C safety compared to ICE engines by reducing or eliminating noise signals that "')
putdocx text (`"would normally alert P & C to oncoming traffic. "')
putdocx paragraph, 
putdocx text (`"At least two groups have empirically investigated the extent of this problem. In its latest report, "')
putdocx text (`"the National Highway Traffic Safety Administration (NHTSA) used data for 15,328,393 accidents from "')
putdocx text (`"16 U.S. states during the period 2000-2011 to estimate a logistic regression of pedestrian accidents "')
putdocx text (`"on HEVs.1 Net of other covariates including city size, maneuver type, vehicle age, driver age, and "')
putdocx text (`"year, the report found that HEVs significantly increased the odds of hitting a pedestrian by 17.6 "')
putdocx text (`"percent (p < 0.05) (NHTSA 2017). In a separate analysis, the Transportation Report Laboratory (TRL) "')
putdocx text (`"used data on 782,852 accidents from the UK during the period 2005-2008 and found that, relative to "')
putdocx text (`"the number of registered vehicles, HEVs were 30 percent less likely to be involved in an accident, "')
putdocx text (`"and equally as likely to be involved in an accident with a pedestrian compared to an ICE vehicle. "')
putdocx text (`"These relative rates taken together indicate that HEVs result in proportionately more pedestrian "')
putdocx text (`"collisions. "')
putdocx paragraph, 
putdocx text (`"Prior research, therefore, provides some evidence that HEVs increase the risk to pedestrian safety, "')
putdocx text (`"consistent with the hypothesis that quieter electric engines are harder for pedestrians to detect. "')
putdocx text (`"However, the NHTSA report only used data through 2011, and since then, the number of HEVs has "')
putdocx text (`"skyrocketed. Moreover, the TRL report only used data through 2008 and did not control for other "')
putdocx text (`"important covariates such as urbanization, speed, weather, driver’s age, and time trends.  This "')
putdocx text (`"paper contributes to the above literature by analyzing the most recent data on "')
putdocx text ("$accidents_cnt"), nformat(%9.0fc)
putdocx text (`" accidents involving "')
putdocx text ($vehicles_cnt), nformat(%9.0fc)
putdocx text (`" vehicles "')
putdocx text (`"in the UK during the period 2000-2017. Furthermore, the present "')
putdocx text (`"analysis includes more control variables, considers the effect of HEVs on cyclists in addition to "')
putdocx text (`"pedestrians, shows disaggregated electric vs. hybrid vehicle effects, and investigates the effect "')
putdocx text (`"over time. "')
putdocx paragraph, 
putdocx text (`"Using the most recent data and a logistic regression model, I find that HEVs increase the odds of "')
putdocx text (`"hitting a cyclist by 84% and increase the odds of hitting a pedestrian by 52% in low speed zones "')
putdocx text (`"(LSZ), but there is very little evidence for an effect in high speed or medium speed zones. "')
putdocx text (`"Moreover, while different model specifications produce slightly different magnitudes of the effect "')
putdocx text (`"of HEVs on cyclist and pedestrian injuries, the effect remains consistently positive. The average "')
putdocx text (`"marginal effects (AME) of HEV are also significant and positive for cyclist and pedestrian "')
putdocx text (`"casualties in LSZ. Therefore, estimates presented in this paper concur with prior analyses conducted "')
putdocx text (`"by NHTSA and TRL, yet the magnitude of the effect may be larger than previously thought.  The "')
putdocx text (`"remainder of this paper is organizedas follows. Section 1 discusses the data and reports descriptive "')
putdocx text (`"statistics, section 2 presents results from different models using odds-ratios and marginal effects. "')
putdocx text (`"Section 3 discusses the results. Section 4 provides concluding remarks. "')
putdocx paragraph, 
putdocx save introduction, replace
