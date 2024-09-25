********************************************************************************
*	This graphs outliers in the MMB against the medians across all 
*	models of a rule.
*	Dependent files: ./data_from_app/csv/
*	Written by Connor Brennan
***************************************************************************

***Set directory
cd /msu/scratch4/m1cmb07/Connor_bob/mmb/


***bring files from csv's to dta's
fs ./data_from_app/csv/
foreach f in `r(files)'{
	import delimited ./data_from_app/csv/`f', clear varnames(1)
	loc i = 1
	foreach var of varlist v6-v26{
		rename `var' y`i'
		loc i = `i' + 1
	}
	loc change_name = rule[1]
	if "`change name'" == "User"{
		loc rule_name = subinstr(substr("`f'", strpos("`f'", "inertial"), strlen("`f'")), ".csv", "", 1)
		replace rule = `rule_name'
		replace rule = "Inertial Taylor" if rule == "inertial"
		replace rule = "Taylor" if rule == "taylor"
		replace rule = "Growth" if rule == "growth"
	}
	loc dta_name = subinstr("`f'", ".csv", ".dta", 1)
	save ./data_from_app/dta/`dta_name', replace
}


***Append the files into one big file
fs ./data_from_app/dta/
loc i = 1
foreach f in `r(files)' {
	di "`f'"
	if `i'==1{
		use ./data_from_app/dta/`f', clear
		loc i = 2
	}
	else{
		append using ./data_from_app/dta/`f'
	}
}


***reshape to long to can treat as panel time series data
reshape long y, i(model variable rule) j(period)
ren y response
egen model_rule_variable = group(model rule variable)
xtset model_rule_variable period


***generate median IRF for each rule/variable pair
bysort rule variable period: egen median_IRF = median(response)



**************************************************************************
***Graph outliers against median_IRF
**************************************************************************
***NK_CGG99
set graphics off
	**Interest
	tsline median_IRF response if variable=="Interest" & rule=="Taylor" & model=="NK_CGG99", scheme(plottig) name(Taylor_interest, replace) legend(off) lcolor(2 red%70) ytitle("Interest Rate") title("Taylor Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Inertial Taylor" & model=="NK_CGG99", scheme(plottig) name(iTaylor_interest, replace) legend(off) lcolor(2 red%70) title("Inertial Taylor Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Growth" & model=="NK_CGG99", scheme(plottig) name(growth_interest, replace) legend(off) lcolor(2 red%70) title("Growth Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Model" & model=="NK_CGG99", scheme(plottig) name(model_interest, replace) legend(off) lcolor(2 red%70)  title("Model Rule") xtitle("")
	
	**Output
	tsline median_IRF response if variable=="Output Gap" & rule=="Taylor" & model=="NK_CGG99", scheme(plottig) name(Taylor_output, replace) legend(off) lcolor(2 red%70) ytitle("Output Gap") xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Inertial Taylor" & model=="NK_CGG99", scheme(plottig) name(iTaylor_output, replace) legend(off) lcolor(2 red%70) xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Growth" & model=="NK_CGG99", scheme(plottig) name(growth_output, replace) legend(off) lcolor(2 red%70) xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Model" & model=="NK_CGG99", scheme(plottig) name(model_output, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-25))
	
	**Inflation
	tsline median_IRF response if variable=="Inflation" & rule=="Taylor" & model=="NK_CGG99", scheme(plottig) name(Taylor_inflation, replace) legend(off) lcolor(2 red%70) ytitle("Inflation") xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Inertial Taylor" & model=="NK_CGG99", scheme(plottig) name(iTaylor_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Growth" & model=="NK_CGG99", scheme(plottig) name(growth_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Model" & model=="NK_CGG99", scheme(plottig) name(model_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))

set graphics on
graph combine Taylor_interest iTaylor_interest growth_interest model_interest Taylor_output iTaylor_output growth_output model_output Taylor_inflation iTaylor_inflation growth_inflation model_inflation, rows(3) cols(4) name(NK_CGG99, replace) title("NK_CGG99 IRF Against Median IRF") ycommon
graph export ./outlier_charts/charts/NK_CGG99.pdf, as(pdf) replace


***NK_ET14
set graphics off
	**Interest
	tsline median_IRF response if variable=="Interest" & rule=="Taylor" & model=="NK_ET14", scheme(plottig) name(Taylor_interest, replace) legend(off) lcolor(2 red%70) ytitle("Interest Rate") title("Taylor Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Inertial Taylor" & model=="NK_ET14", scheme(plottig) name(iTaylor_interest, replace) legend(off) lcolor(2 red%70) title("Inertial Taylor Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Growth" & model=="NK_ET14", scheme(plottig) name(growth_interest, replace) legend(off) lcolor(2 red%70) title("Growth Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Model" & model=="NK_ET14", scheme(plottig) name(model_interest, replace) legend(off) lcolor(2 red%70)  title("Model Rule") xtitle("")
	
	**Output
	tsline median_IRF response if variable=="Output Gap" & rule=="Taylor" & model=="NK_ET14", scheme(plottig) name(Taylor_output, replace) legend(off) lcolor(2 red%70) ytitle("Output Gap") xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Inertial Taylor" & model=="NK_ET14", scheme(plottig) name(iTaylor_output, replace) legend(off) lcolor(2 red%70) xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Growth" & model=="NK_ET14", scheme(plottig) name(growth_output, replace) legend(off) lcolor(2 red%70) xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Model" & model=="NK_ET14", scheme(plottig) name(model_output, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-25))
	
	**Inflation
	tsline median_IRF response if variable=="Inflation" & rule=="Taylor" & model=="NK_ET14", scheme(plottig) name(Taylor_inflation, replace) legend(off) lcolor(2 red%70) ytitle("Inflation") xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Inertial Taylor" & model=="NK_ET14", scheme(plottig) name(iTaylor_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Growth" & model=="NK_ET14", scheme(plottig) name(growth_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Model" & model=="NK_ET14", scheme(plottig) name(model_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))

set graphics on
graph combine Taylor_interest iTaylor_interest growth_interest model_interest Taylor_output iTaylor_output growth_output model_output Taylor_inflation iTaylor_inflation growth_inflation model_inflation, rows(3) cols(4) name(NK_ET14, replace) title("NK_ET14 IRF Against Median IRF") ycommon
graph export ./outlier_charts/charts/NK_ET14.pdf, as(pdf) replace


***US_BKM12
set graphics off
	**Interest
	tsline median_IRF response if variable=="Interest" & rule=="Taylor" & model=="US_BKM12", scheme(plottig) name(Taylor_interest, replace) legend(off) lcolor(2 red%70) ytitle("Interest Rate") title("Taylor Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Inertial Taylor" & model=="US_BKM12", scheme(plottig) name(iTaylor_interest, replace) legend(off) lcolor(2 red%70) title("Inertial Taylor Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Growth" & model=="US_BKM12", scheme(plottig) name(growth_interest, replace) legend(off) lcolor(2 red%70) title("Growth Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Model" & model=="US_BKM12", scheme(plottig) name(model_interest, replace) legend(off) lcolor(2 red%70)  title("Model Rule") xtitle("")
	
	**Output
	tsline median_IRF response if variable=="Output Gap" & rule=="Taylor" & model=="US_BKM12", scheme(plottig) name(Taylor_output, replace) legend(off) lcolor(2 red%70) ytitle("Output Gap") xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Inertial Taylor" & model=="US_BKM12", scheme(plottig) name(iTaylor_output, replace) legend(off) lcolor(2 red%70) xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Growth" & model=="US_BKM12", scheme(plottig) name(growth_output, replace) legend(off) lcolor(2 red%70) xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Model" & model=="US_BKM12", scheme(plottig) name(model_output, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-25))
	
	**Inflation
	tsline median_IRF response if variable=="Inflation" & rule=="Taylor" & model=="US_BKM12", scheme(plottig) name(Taylor_inflation, replace) legend(off) lcolor(2 red%70) ytitle("Inflation") xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Inertial Taylor" & model=="US_BKM12", scheme(plottig) name(iTaylor_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Growth" & model=="US_BKM12", scheme(plottig) name(growth_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Model" & model=="US_BKM12", scheme(plottig) name(model_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))

set graphics on
graph combine Taylor_interest iTaylor_interest growth_interest model_interest Taylor_output iTaylor_output growth_output model_output Taylor_inflation iTaylor_inflation growth_inflation model_inflation, rows(3) cols(4) name(US_BKM12, replace) title("US_BKM12 IRF Against Median IRF") ycommon
graph export ./outlier_charts/charts/US_BKM12.pdf, as(pdf) replace


***US_IR15
set graphics off
	**Interest
	tsline median_IRF response if variable=="Interest" & rule=="Taylor" & model=="US_IR15", scheme(plottig) name(Taylor_interest, replace) legend(off) lcolor(2 red%70) ytitle("Interest Rate") title("Taylor Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Inertial Taylor" & model=="US_IR15", scheme(plottig) name(iTaylor_interest, replace) legend(off) lcolor(2 red%70) title("Inertial Taylor Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Growth" & model=="US_IR15", scheme(plottig) name(growth_interest, replace) legend(off) lcolor(2 red%70) title("Growth Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Model" & model=="US_IR15", scheme(plottig) name(model_interest, replace) legend(off) lcolor(2 red%70)  title("Model Rule") xtitle("")
	
	**Output
	tsline median_IRF response if variable=="Output Gap" & rule=="Taylor" & model=="US_IR15", scheme(plottig) name(Taylor_output, replace) legend(off) lcolor(2 red%70) ytitle("Output Gap") xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Inertial Taylor" & model=="US_IR15", scheme(plottig) name(iTaylor_output, replace) legend(off) lcolor(2 red%70) xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Growth" & model=="US_IR15", scheme(plottig) name(growth_output, replace) legend(off) lcolor(2 red%70) xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Model" & model=="US_IR15", scheme(plottig) name(model_output, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-25))
	
	**Inflation
	tsline median_IRF response if variable=="Inflation" & rule=="Taylor" & model=="US_IR15", scheme(plottig) name(Taylor_inflation, replace) legend(off) lcolor(2 red%70) ytitle("Inflation") xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Inertial Taylor" & model=="US_IR15", scheme(plottig) name(iTaylor_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Growth" & model=="US_IR15", scheme(plottig) name(growth_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Model" & model=="US_IR15", scheme(plottig) name(model_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))

set graphics on
graph combine Taylor_interest iTaylor_interest Taylor_output iTaylor_output Taylor_inflation iTaylor_inflation, rows(3) cols(2) name(US_IR15, replace) title("US_IR15 IRF Against Median IRF") ycommon
graph export ./outlier_charts/charts/US_IR15.pdf, as(pdf) replace


***US_PM08
set graphics off
	**Interest
	tsline median_IRF response if variable=="Interest" & rule=="Taylor" & model=="US_PM08", scheme(plottig) name(Taylor_interest, replace) legend(off) lcolor(2 red%70) ytitle("Interest Rate") title("Taylor Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Inertial Taylor" & model=="US_PM08", scheme(plottig) name(iTaylor_interest, replace) legend(off) lcolor(2 red%70) title("Inertial Taylor Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Growth" & model=="US_PM08", scheme(plottig) name(growth_interest, replace) legend(off) lcolor(2 red%70) title("Growth Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Model" & model=="US_PM08", scheme(plottig) name(model_interest, replace) legend(off) lcolor(2 red%70)  title("Model Rule") xtitle("")
	
	**Output
	tsline median_IRF response if variable=="Output Gap" & rule=="Taylor" & model=="US_PM08", scheme(plottig) name(Taylor_output, replace) legend(off) lcolor(2 red%70) ytitle("Output Gap") xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Inertial Taylor" & model=="US_PM08", scheme(plottig) name(iTaylor_output, replace) legend(off) lcolor(2 red%70) xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Growth" & model=="US_PM08", scheme(plottig) name(growth_output, replace) legend(off) lcolor(2 red%70) xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Model" & model=="US_PM08", scheme(plottig) name(model_output, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-25))
	
	**Inflation
	tsline median_IRF response if variable=="Inflation" & rule=="Taylor" & model=="US_PM08", scheme(plottig) name(Taylor_inflation, replace) legend(off) lcolor(2 red%70) ytitle("Inflation") xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Inertial Taylor" & model=="US_PM08", scheme(plottig) name(iTaylor_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Growth" & model=="US_PM08", scheme(plottig) name(growth_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Model" & model=="US_PM08", scheme(plottig) name(model_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))

set graphics on
graph combine Taylor_interest iTaylor_interest growth_interest model_interest Taylor_output iTaylor_output growth_output model_output Taylor_inflation iTaylor_inflation growth_inflation model_inflation, rows(3) cols(4) name(US_PM08, replace) title("US_PM08 IRF Against Median IRF") ycommon
graph export ./outlier_charts/charts/US_PM08.pdf, as(pdf) replace


***US_PV15
set graphics off
	**Interest
	tsline median_IRF response if variable=="Interest" & rule=="Taylor" & model=="US_PV15", scheme(plottig) name(Taylor_interest, replace) legend(off) lcolor(2 red%70) ytitle("Interest Rate") title("Taylor Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Inertial Taylor" & model=="US_PV15", scheme(plottig) name(iTaylor_interest, replace) legend(off) lcolor(2 red%70) title("Inertial Taylor Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Growth" & model=="US_PV15", scheme(plottig) name(growth_interest, replace) legend(off) lcolor(2 red%70) title("Growth Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Model" & model=="US_PV15", scheme(plottig) name(model_interest, replace) legend(off) lcolor(2 red%70)  title("Model Rule") xtitle("")
	
	**Output
	tsline median_IRF response if variable=="Output Gap" & rule=="Taylor" & model=="US_PV15", scheme(plottig) name(Taylor_output, replace) legend(off) lcolor(2 red%70) ytitle("Output Gap") xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Inertial Taylor" & model=="US_PV15", scheme(plottig) name(iTaylor_output, replace) legend(off) lcolor(2 red%70) xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Growth" & model=="US_PV15", scheme(plottig) name(growth_output, replace) legend(off) lcolor(2 red%70) xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Model" & model=="US_PV15", scheme(plottig) name(model_output, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-25))
	
	**Inflation
	tsline median_IRF response if variable=="Inflation" & rule=="Taylor" & model=="US_PV15", scheme(plottig) name(Taylor_inflation, replace) legend(off) lcolor(2 red%70) ytitle("Inflation") xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Inertial Taylor" & model=="US_PV15", scheme(plottig) name(iTaylor_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Growth" & model=="US_PV15", scheme(plottig) name(growth_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Model" & model=="US_PV15", scheme(plottig) name(model_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))

set graphics on
graph combine Taylor_interest iTaylor_interest growth_interest model_interest Taylor_output iTaylor_output growth_output model_output Taylor_inflation iTaylor_inflation growth_inflation model_inflation, rows(3) cols(4) name(US_PV15, replace) title("US_PV15 IRF Against Median IRF") ycommon
graph export ./outlier_charts/charts/US_PV15.pdf, as(pdf) replace


***NK_NS14
set graphics off
	**Interest
	tsline median_IRF response if variable=="Interest" & rule=="Taylor" & model=="NK_NS14", scheme(plottig) name(Taylor_interest, replace) legend(off) lcolor(2 red%70) ytitle("Interest Rate") title("Taylor Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Inertial Taylor" & model=="NK_NS14", scheme(plottig) name(iTaylor_interest, replace) legend(off) lcolor(2 red%70) title("Inertial Taylor Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Growth" & model=="NK_NS14", scheme(plottig) name(growth_interest, replace) legend(off) lcolor(2 red%70) title("Growth Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Model" & model=="NK_NS14", scheme(plottig) name(model_interest, replace) legend(off) lcolor(2 red%70)  title("Model Rule") xtitle("")
	
	**Output
	tsline median_IRF response if variable=="Output Gap" & rule=="Taylor" & model=="NK_NS14", scheme(plottig) name(Taylor_output, replace) legend(off) lcolor(2 red%70) ytitle("Output Gap") xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Inertial Taylor" & model=="NK_NS14", scheme(plottig) name(iTaylor_output, replace) legend(off) lcolor(2 red%70) xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Growth" & model=="NK_NS14", scheme(plottig) name(growth_output, replace) legend(off) lcolor(2 red%70) xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Model" & model=="NK_NS14", scheme(plottig) name(model_output, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-25))
	
	**Inflation
	tsline median_IRF response if variable=="Inflation" & rule=="Taylor" & model=="NK_NS14", scheme(plottig) name(Taylor_inflation, replace) legend(off) lcolor(2 red%70) ytitle("Inflation") xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Inertial Taylor" & model=="NK_NS14", scheme(plottig) name(iTaylor_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Growth" & model=="NK_NS14", scheme(plottig) name(growth_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Model" & model=="NK_NS14", scheme(plottig) name(model_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))

set graphics on
graph combine Taylor_interest iTaylor_interest growth_interest model_interest Taylor_output iTaylor_output growth_output model_output Taylor_inflation iTaylor_inflation growth_inflation model_inflation, rows(3) cols(4) name(NK_NS14, replace) title("NK_NS14 IRF Against Median IRF") ycommon
graph export ./outlier_charts/charts/NK_NS14.pdf, as(pdf) replace


***NK_GM07
set graphics off
	**Interest
	tsline median_IRF response if variable=="Interest" & rule=="Taylor" & model=="NK_GM07", scheme(plottig) name(Taylor_interest, replace) legend(off) lcolor(2 red%70) ytitle("Interest Rate") title("Taylor Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Inertial Taylor" & model=="NK_GM07", scheme(plottig) name(iTaylor_interest, replace) legend(off) lcolor(2 red%70) title("Inertial Taylor Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Growth" & model=="NK_GM07", scheme(plottig) name(growth_interest, replace) legend(off) lcolor(2 red%70) title("Growth Rule") xtitle("")
	tsline median_IRF response if variable=="Interest" & rule=="Model" & model=="NK_GM07", scheme(plottig) name(model_interest, replace) legend(off) lcolor(2 red%70)  title("Model Rule") xtitle("")
	
	**Output
	tsline median_IRF response if variable=="Output Gap" & rule=="Taylor" & model=="NK_GM07", scheme(plottig) name(Taylor_output, replace) legend(off) lcolor(2 red%70) ytitle("Output Gap") xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Inertial Taylor" & model=="NK_GM07", scheme(plottig) name(iTaylor_output, replace) legend(off) lcolor(2 red%70) xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Growth" & model=="NK_GM07", scheme(plottig) name(growth_output, replace) legend(off) lcolor(2 red%70) xtitle("")
	tsline median_IRF response if variable=="Output Gap" & rule=="Model" & model=="NK_GM07", scheme(plottig) name(model_output, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-25))
	
	**Inflation
	tsline median_IRF response if variable=="Inflation" & rule=="Taylor" & model=="NK_GM07", scheme(plottig) name(Taylor_inflation, replace) legend(off) lcolor(2 red%70) ytitle("Inflation") xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Inertial Taylor" & model=="NK_NS14", scheme(plottig) name(iTaylor_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Growth" & model=="NK_GM07", scheme(plottig) name(growth_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))
	tsline median_IRF response if variable=="Inflation" & rule=="Model" & model=="NK_GM07", scheme(plottig) name(model_inflation, replace) legend(off) lcolor(2 red%70) xtitle("") //yscale(titlegap(*-2))

set graphics on
graph combine Taylor_interest iTaylor_interest growth_interest model_interest Taylor_output iTaylor_output growth_output model_output Taylor_inflation iTaylor_inflation growth_inflation model_inflation, rows(3) cols(4) name(NK_GM07, replace) title("NK_GM07 IRF Against Median IRF") ycommon
graph export ./outlier_charts/charts/NK_GM07.pdf, as(pdf) replace
