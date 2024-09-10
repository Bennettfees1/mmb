graph close
set graphics off
use .${cleandata}MMB_reg_format.dta, clear



********************************************************************************
* Piq timing -- MAX predicted by NK
********************************************************************************
*Nonmodelvars
foreach var of global nonmodelvars {
	nbreg piq_timing_max rule_itr rule_g `var' if piq_timing_max<${time_limit}, vce(r)
	estimates store `var'
	loc r2_`var' = round(e(${r2measure_timing}), 0.01)
}
glo coefplot_call "coefplot"
foreach var of global nonmodelvars {
	glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(`var'))"
}
glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
loc rownum = 1
glo coefplot_call "${coefplot_call} text("
foreach var of global nonmodelvars {
	 glo coefplot_call `"${coefplot_call} `rownum' 1.85 "R{superscript:2} = `r2_`var''""'
	 loc rownum = `rownum' + 1
}
glo coefplot_call "${coefplot_call} )"
$coefplot_call title("Bivariate Regressions of Timing of Maximum" "Inflation Response on Nonmodel Variables, Rule Fixed Effects", size(*0.8)) name(piq_t_nonmodvars, replace) levels(90) note("Bands represent 90% confidence intervals." "Neg. binomial regressions: ln(quarter of max piq) = c + a*rule_itr + b*rule_g + beta*nonmodelvar") xscale(range(-1 2))	
graph export "./output/coef_plots_timing/piq_timing_max_nonmodvars_ofinterest.pdf", as(pdf) replace

glo coefplot_call "coefplot"
foreach var of global nonmodelvars {
	local x: variable label `var'
	glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(rule_itr rule_g _cons) label(`x'))"
}
glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
$coefplot_call title("Rule Coefficients from Bivariate Regressions of Timing of Maximum" "Inflation Response on Nonmodel Variables", size(*0.8)) xsize(*1.1) name(piq_t_nonmodvars_rules, replace) levels(90) note("Bands represent 90% confidence intervals." "Neg. binomial regressions: ln(quarter of max piq) = c + a*rule_itr + b*rule_g + beta*nonmodelvar")	
estimates drop *
graph export "./output/coef_plots_timing/piq_timing_max_nonmodvars_rules.pdf", as(pdf) replace


*Modelvars
foreach var of global modelvars {
	nbreg piq_timing_max rule_itr rule_g `var' if piq_timing_max<${time_limit}, vce(r)
	estimates store `var'
	loc r2_`var' = round(e(${r2measure_timing}), 0.01)
}
glo coefplot_call "coefplot"
foreach var of global modelvars {
	glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(`var'))"
}
glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
loc rownum = 1
glo coefplot_call "${coefplot_call} text("
foreach var of global modelvars {
	 glo coefplot_call `"${coefplot_call} `rownum' 2.2 "R{superscript:2} = `r2_`var''""'
	 loc rownum = `rownum' + 1
}
glo coefplot_call "${coefplot_call} )"
$coefplot_call title("Bivariate Regressions of Timing of Maximum" "Inflation Response on Model Variables, Rule Fixed Effects", size(*0.8)) name(piq_t_modvars, replace) levels(90) note("Bands represent 90% confidence intervals." "Neg. binomial regressions: ln(quarter of max piq) = c + a*rule_itr + b*rule_g + beta*modelvar") xscale(range(-2 2.5))
graph export "./output/coef_plots_timing/piq_timing_max_modvars_ofinterest.pdf", as(pdf) replace

glo coefplot_call "coefplot"
foreach var of global modelvars {
	local x: variable label `var'
	glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(rule_itr rule_g _cons) label(`x'))"
}
glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
$coefplot_call title("Rule Coefficients from Bivariate Regressions of Timing of Maximum" "Inflation Response on Model Variables", size(*0.8)) xsize(*1.1) name(piq_t_modvars_rules, replace) levels(90) note("Bands represent 90% confidence intervals." "Neg. binomial regressions: ln(quarter of max piq) = c + a*rule_itr + b*rule_g + beta*modelvar")	
estimates drop *
graph export "./output/coef_plots_timing/piq_timing_max_modvars_rules.pdf", as(pdf) replace



********************************************************************************
* y timing -- MAX predicted by NK
********************************************************************************
*Nonmodelvars
foreach var of global nonmodelvars {
	nbreg y_timing_max rule_itr rule_g `var' if y_timing_max<${time_limit}, vce(r)
	estimates store `var'
	loc r2_`var' = round(e(${r2measure_timing}), 0.01)
}
glo coefplot_call "coefplot"
foreach var of global nonmodelvars {
	glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(`var'))"
}
glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
loc rownum = 1
glo coefplot_call "${coefplot_call} text("
foreach var of global nonmodelvars {
	 glo coefplot_call `"${coefplot_call} `rownum' 1.3 "R{superscript:2} = `r2_`var''""'
	 loc rownum = `rownum' + 1
}
glo coefplot_call "${coefplot_call} )"
$coefplot_call title("Bivariate Regressions of Timing of Maximum" "Output Response on Nonmodel Variables, Rule Fixed Effects", size(*0.8)) name(y_t_nonmodvars, replace) levels(90) note("Bands represent 90% confidence intervals." "Neg. binomial regressions: ln(quarter of max y) = c + a*rule_itr + b*rule_g + beta*nonmodelvar") xscale(range(-1 1.5))
graph export "./output/coef_plots_timing/y_timing_max_nonmodvars_ofinterest.pdf", as(pdf) replace

glo coefplot_call "coefplot"
foreach var of global nonmodelvars {
	local x: variable label `var'
	glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(rule_itr rule_g _cons) label(`x'))"
}
glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
$coefplot_call title("Rule Coefficients from Bivariate Regressions of Timing of Maximum" "Output Response on Nonmodel Variables", size(*0.8)) xsize(*1.1) name(y_t_nonmodvars_rules, replace) levels(90) note("Bands represent 90% confidence intervals." "Neg. binomial regressions: ln(quarter of max y) = c + a*rule_itr + b*rule_g + beta*nonmodelvar")	
estimates drop *
graph export "./output/coef_plots_timing/y_timing_max_nonmodvars_rules.pdf", as(pdf) replace


*Modelvars
foreach var of global modelvars {
	nbreg y_timing_max rule_itr rule_g `var' if y_timing_max<${time_limit}, vce(r)
	estimates store `var'
	loc r2_`var' = round(e(${r2measure_timing}), 0.01)
}
glo coefplot_call "coefplot"
foreach var of global modelvars {
	glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(`var'))"
}
glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
loc rownum = 1
glo coefplot_call "${coefplot_call} text("
foreach var of global modelvars {
	 glo coefplot_call `"${coefplot_call} `rownum' 1.2 "R{superscript:2} = `r2_`var''""'
	 loc rownum = `rownum' + 1
}
glo coefplot_call "${coefplot_call} )"
$coefplot_call title("Bivariate Regressions of Timing of Maximum" "Output Response on Model Variables, Rule Fixed Effects", size(*0.8)) name(y_t_modvars, replace) levels(90) note("Bands represent 90% confidence intervals." "Neg. binomial regressions: ln(quarter of max y) = c + a*rule_itr + b*rule_g + beta*modelvar") xscale(range(-1 1.5))
graph export "./output/coef_plots_timing/y_timing_max_modvars_ofinterest.pdf", as(pdf) replace

glo coefplot_call "coefplot"
foreach var of global modelvars {
	local x: variable label `var'
	glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(rule_itr rule_g _cons) label(`x'))"
}
glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
$coefplot_call title("Rule Coefficients from Bivariate Regressions of Timing of Maximum" "Output Response on Model Variables", size(*0.8)) xsize(*1.1) name(y_t_modvars_rules, replace) levels(90) note("Bands represent 90% confidence intervals." "Neg. binomial regressions: ln(quarter of max y) = c + a*rule_itr + b*rule_g + beta*modelvar")	
estimates drop *
graph export "./output/coef_plots_timing/y_timing_max_modvars_rules.pdf", as(pdf) replace


/*
********************************************************************************
* rrate timing -- MIN predicted by NK
********************************************************************************
*Nonmodelvars
loc time_limit = 60
foreach var of global nonmodelvars {
	nbreg rrate_timing_min rule_itr rule_g `var' if rrate_timing_min<${time_limit}, vce(r)
	estimates store `var'
	loc r2_`var' = round(e(${r2measure_timing}), 0.01)
}
glo coefplot_call "coefplot"
foreach var of global nonmodelvars {
	glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(`var'))"
}
glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
loc rownum = 1
glo coefplot_call "${coefplot_call} text("
foreach var of global nonmodelvars {
	 glo coefplot_call `"${coefplot_call} `rownum' 0.12 "R{superscript:2} = `r2_`var''""'
	 loc rownum = `rownum' + 1
}
glo coefplot_call "${coefplot_call} )"
$coefplot_call title("Bivariate Regressions of Timing of Minimum" "Real Rate Response on Nonmodel Variables, Rule Fixed Effects", size(*0.8)) name(rrate_t_nonmodvars, replace) levels(90) note("Bands represent 90% confidence intervals." "Neg. binomial regressions: ln(quarter of min rrate) = c + a*rule_itr + b*rule_g + beta*nonmodelvar") xscale(range(-0.1 0.14))
graph export "./output/coef_plots_timing/rrate_timing_min_nonmodvars_ofinterest.pdf", as(pdf) replace

glo coefplot_call "coefplot"
foreach var of global nonmodelvars {
	local x: variable label `var'
	glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(rule_itr rule_g _cons) label(`x'))"
}
glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
$coefplot_call title("Rule Coefficients from Bivariate Regressions of Timing of Minimum" "Real Rate Response on Nonmodel Variables", size(*0.8)) xsize(*1.1) name(rrate_t_nonmodvars_rules, replace) levels(90) note("Bands represent 90% confidence intervals." "Neg. binomial regressions: ln(quarter of min rrate) = c + a*rule_itr + b*rule_g + beta*nonmodelvar")
estimates drop *	
graph export "./output/coef_plots_timing/rrate_timing_min_nonmodvars_rules.pdf", as(pdf) replace


*Modelvars
foreach var of global modelvars {
	nbreg rrate_timing_min rule_itr rule_g `var' if rrate_timing_min<${time_limit}, vce(r)
	estimates store `var'
	loc r2_`var' = round(e(${r2measure_timing}), 0.01)
}
glo coefplot_call "coefplot"
foreach var of global modelvars {
	glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(`var'))"
}
glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
loc rownum = 1
glo coefplot_call "${coefplot_call} text("
foreach var of global modelvars {
	 glo coefplot_call `"${coefplot_call} `rownum' 0.37 "R{superscript:2} = `r2_`var''""'
	 loc rownum = `rownum' + 1
}
glo coefplot_call "${coefplot_call} )"
$coefplot_call title("Bivariate Regressions of Timing of Minimum" "Real Rate Response on Model Variables, Rule Fixed Effects", size(*0.8)) name(rrate_t_modvars, replace) levels(90) note("Bands represent 90% confidence intervals." "Neg. binomial regressions: ln(quarter of min rrate) = c + a*rule_itr + b*rule_g + beta*modelvar")	
graph export "./output/coef_plots_timing/rrate_timing_min_modvars_ofinterest.pdf", as(pdf) replace

glo coefplot_call "coefplot"
foreach var of global modelvars {
	local x: variable label `var'
	glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(rule_itr rule_g _cons) label(`x'))"
}
glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
$coefplot_call title("Rule Coefficients from Bivariate Regressions of Timing of Minimum" "Real Rate Response on Model Variables", size(*0.8)) xsize(*1.1) name(rrate_t_modvars_rules, replace) levels(90) note("Bands represent 90% confidence intervals." "Neg. binomial regressions: ln(quarter of min rrate) = c + a*rule_itr + b*rule_g + beta*modelvar")	
estimates drop *
graph export "./output/coef_plots_timing/rrate_timing_min_modvars_rules.pdf", as(pdf) replace



********************************************************************************
* irate timing -- MIN predicted by NK
********************************************************************************
*Nonmodelvars
foreach var of global nonmodelvars {
	nbreg irate_timing_min rule_itr rule_g `var' if irate_timing_min<${time_limit}, vce(r)
	estimates store `var'
	loc r2_`var' = round(e(${r2measure_timing}), 0.01)
}
glo coefplot_call "coefplot"
foreach var of global nonmodelvars {
	glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(`var'))"
}
glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
loc rownum = 1
glo coefplot_call "${coefplot_call} text("
foreach var of global nonmodelvars {
	 glo coefplot_call `"${coefplot_call} `rownum' 0.9 "R{superscript:2} = `r2_`var''""'
	 loc rownum = `rownum' + 1
}
glo coefplot_call "${coefplot_call} )"
$coefplot_call title("Bivariate Regressions of Timing of Minimum" "Nominal Rate Response on Nonmodel Variables, Rule Fixed Effects", size(*0.8)) name(irate_t_nonmodvars, replace) levels(90) note("Bands represent 90% confidence intervals." "Neg. binomial regressions: ln(quarter of min irate) = c + a*rule_itr + b*rule_g + beta*nonmodelvar")	
graph export "./output/coef_plots_timing/irate_timing_min_nonmodvars_ofinterest.pdf", as(pdf) replace

glo coefplot_call "coefplot"
foreach var of global nonmodelvars {
	local x: variable label `var'
	glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(rule_itr rule_g _cons) label(`x'))"
}
glo coefplot_call = "${coefplot_call}, legend(off)"
$coefplot_call title("Rule Coefficients from Bivariate Regressions of Timing of Minimum" "Nominal Rate Response on Nonmodel Variables", size(*0.8)) xsize(*1.1) name(irate_t_nonmodvars_rules, replace) levels(90) note("Bands represent 90% confidence intervals." "Neg. binomial regressions: ln(quarter of min irate) = c + a*rule_itr + b*rule_g + beta*nonmodelvar")	
estimates drop *
graph export "./output/coef_plots_timing/irate_timing_min_nonmodvars_rules.pdf", as(pdf) replace


*Modelvars
foreach var of global modelvars {
	nbreg irate_timing_min rule_itr rule_g `var' if irate_timing_min<${time_limit}, vce(r)
	estimates store `var'
	loc r2_`var' = round(e(${r2measure_timing}), 0.01)
}
glo coefplot_call "coefplot"
foreach var of global modelvars {
	glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(`var'))"
}
glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
loc rownum = 1
glo coefplot_call "${coefplot_call} text("
foreach var of global modelvars {
	 glo coefplot_call `"${coefplot_call} `rownum' 2 "R{superscript:2} = `r2_`var''""'
	 loc rownum = `rownum' + 1
}
glo coefplot_call "${coefplot_call} )"
$coefplot_call title("Bivariate Regressions of Timing of Minimum" "Nominal Rate Response on Model Variables, Rule Fixed Effects", size(*0.8)) name(irate_t_modvars, replace) levels(90) note("Bands represent 90% confidence intervals." "Neg. binomial regressions: ln(quarter of min irate) = c + a*rule_itr + b*rule_g + beta*modelvar") xscale(range(-1 2.2))
graph export "./output/coef_plots_timing/irate_timing_min_modvars_ofinterest.pdf", as(pdf) replace

glo coefplot_call "coefplot"
foreach var of global modelvars {
	local x: variable label `var'
	glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(rule_itr rule_g _cons) label(`x'))"
}
glo coefplot_call = "${coefplot_call}, legend(off)"
$coefplot_call title("Rule Coefficients from Bivariate Regressions of Timing of Minimum" "Nominal Rate Response on Model Variables", size(*0.8)) xsize(*1.1) name(irate_t_modvars_rules, replace) levels(90) note("Bands represent 90% confidence intervals." "Neg. binomial regressions: ln(quarter of min irate) = c + a*rule_itr + b*rule_g + beta*modelvar")
estimates drop *
graph export "./output/coef_plots_timing/irate_timing_min_modvars_rules.pdf", as(pdf) replace

set graphics on
*/
