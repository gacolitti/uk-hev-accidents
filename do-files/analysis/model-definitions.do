
// Model Definitions


global aam1c "i.speed urban vtaxi i.driver_age driver_fatal_per daylight weekday weekend_night i.weather i.season i.year"
global sam1c "urban daylight weekday weekend_night driver_fatal_per vtaxi i.driver_age i.weather i.season i.year"

global aam1d "i.speed urban vtaxi i.driver_age driver_fatal_per daylight weekday weekend_night i.weather i.season i.year i.carriageway_hazards i.road_surface_conditions i.special_conditions_at_site i.vehicle_manoeuvre i.road_type"
global sam1d "urban daylight weekday weekend_night driver_fatal_per vtaxi i.driver_age i.weather i.season i.year i.carriageway_hazards i.road_surface_conditions i.special_conditions_at_site i.vehicle_manoeuvre i.road_type"

global table1c "Baseline Controls = urban daylight weekday weekend_night vtaxi *weather *season *driver_age driver_fatal_per"
global table1d "Table 1D Controls = *carriageway_hazards *road_surface_conditions *special_conditions_at_site *vehicle_manoeuvre *road_type"

global satable1c "Table 1.1C Controls = urban daylight weekday weekend_night vtaxi *weather *season *driver_age"
