graph close
use .${cleandata}MMB_reg_format.dta, clear



set graphics off
forvalues i=20(20)60{
	glo horizon = `i'
	
	********************************************************************************
	*** IS Slope
	********************************************************************************
	*Nonmodelvars
	foreach var of varlist $nonmodelvars {
		robreg m IScurve${horizon} rule_tr rule_g `var', k(4.685) bis center updatescale
		estimates store `var'
		loc r2_`var' = round(e(${r2measure_outcomes}), 0.01)
	}
	glo coefplot_call "coefplot"
	foreach var of varlist $nonmodelvars {
		glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(`var'))"
	}
	glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
	loc rownum = 1
	glo coefplot_call "${coefplot_call} text("
	foreach var of varlist $nonmodelvars {
		 glo coefplot_call `"${coefplot_call} `rownum' 0.35 "R{superscript:2} = `r2_`var''""'
		 loc rownum = `rownum' + 1
	}
	glo coefplot_call "${coefplot_call} )"
	$coefplot_call title("Bivariate Regressions of {it:y-slope} on Non-model" "Attribute Variables, Rule Fixed Effects", size(*0.8)) name(IS${horizon}_nonmodvars, replace) levels(90) note("Bands represent 90% confidence intervals." "Regressions are of form: {it:y-slope = c + a*rule_tr + b*rule_g + beta*(non-model attribute)}") xscale(range(-0.45 0.4))
	graph export "./output/coef_plots_outcomes/IS${horizon}_nonmodvars_ofinterest.pdf", as(pdf) replace

	glo coefplot_call "coefplot"
	foreach var of varlist $nonmodelvars {
		local x: variable label `var'
		glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(rule_tr rule_g _cons) label(`x'))"
	}
	glo coefplot_call = "${coefplot_call}, legend(on pos(6) rows(2) size(*0.8)) xline(0)"
	$coefplot_call title("Rule Coefficients from Bivariate Regressions of {it:y-slope}" "on Non-model Attribute Variables", size(*0.8)) xsize(*1.1) name(IS${horizon}_nonmodvars_rules, replace) levels(90) note("Bands represent 90% confidence intervals." "Regressions are of form: {it:y-slope = c + a*rule_tr + b*rule_g + beta*(non-model attribute)}")
	estimates drop *
	graph export "./output/coef_plots_outcomes/IS${horizon}_nonmodvars_rules.pdf", as(pdf) replace

	*Modelvars
	foreach var of varlist $modelvars {
		robreg m IScurve${horizon} rule_tr rule_g `var', k(4.685) bis center updatescale
		estimates store `var'
		loc r2_`var' = round(e(${r2measure_outcomes}), 0.01)
	}
	glo coefplot_call "coefplot"
	foreach var of varlist $modelvars {
		glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(`var'))"
	}
	glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
	loc rownum = 1
	glo coefplot_call "${coefplot_call} text("
	foreach var of varlist $modelvars {
		 glo coefplot_call `"${coefplot_call} `rownum' 0.70 "R{superscript:2} = `r2_`var''""'
		 loc rownum = `rownum' + 1
	}
	glo coefplot_call "${coefplot_call} )"
	$coefplot_call title("Bivariate Regressions of {it:y-slope} on Model" "Attribute Variables, Rule Fixed Effects", size(*0.8)) name(IS${horizon}_modvars, replace) levels(90) note("Bands represent 90% confidence intervals." "Regressions are of form: {it:y-slope = c + a*rule_tr + b*rule_g + beta*(model attribute)}") xscale(range(-0.6 0.8))	
	graph export "./output/coef_plots_outcomes/IS${horizon}_modvars_ofinterest.pdf", as(pdf) replace

	glo coefplot_call "coefplot"
	foreach var of varlist $modelvars {
		local x: variable label `var'
		glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(rule_tr rule_g _cons) label(`x'))"
	}
	glo coefplot_call = "${coefplot_call}, legend(on pos(6) rows(2) size(*0.8)) xline(0)"
	$coefplot_call title("Rule Coefficients from Bivariate Regressions of {it:y-slope}" " on Model Attribute Variables", size(*0.8)) xsize(*1.1) name(IS${horizon}_modvars_rules, replace) levels(90) note("Bands represent 90% confidence intervals." "Regressions are of form: {it:y-slope = c + a*rule_tr + b*rule_g + beta*(model attribute)}")	
	estimates drop *
	graph export "./output/coef_plots_outcomes/IS${horizon}_modvars_rules.pdf", as(pdf) replace



	********************************************************************************
	*** sacratio
	********************************************************************************
	*Nonmodelvars
	foreach var of varlist $nonmodelvars {
		robreg m sacratio${horizon} rule_tr rule_g `var', k(4.685) bis center updatescale
		estimates store `var'
		loc r2_`var' = round(e(${r2measure_outcomes}), 0.01)
	}
	glo coefplot_call "coefplot"
	foreach var of varlist $nonmodelvars {
		glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(`var'))"
	}
	glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
	loc rownum = 1
	glo coefplot_call "${coefplot_call} text("
	foreach var of varlist $nonmodelvars {
		 glo coefplot_call `"${coefplot_call} `rownum' 6.0 "R{superscript:2} = `r2_`var''""'
		 loc rownum = `rownum' + 1
	}
	glo coefplot_call "${coefplot_call} )"
	$coefplot_call title("Bivariate Regressions of {it:sacratio} on Non-model" "Attribute Variables, Rule Fixed Effects", size(*0.8)) name(sacrat${horizon}_nonmodvars, replace) levels(90) note("Bands represent 90% confidence intervals." "Regressions are of form: {it:sacratio = c + a*rule_tr + b*rule_g + beta*(non-model attribute)}") xscale(range(-4 6.5))	
	graph export "./output/coef_plots_outcomes/sac${horizon}_nonmodvars_ofinterest.pdf", as(pdf) replace

	glo coefplot_call "coefplot"
	foreach var of varlist $nonmodelvars {
		local x: variable label `var'
		glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(rule_tr rule_g _cons) label(`x'))"
	}
	glo coefplot_call = "${coefplot_call}, legend(on pos(6) rows(2) size(*0.8)) xline(0)"
	$coefplot_call title("Rule Coefficients from Bivariate Regressions of {it:sacratio}" " on Non-model Attribute Variables", size(*0.8)) xsize(*1.1) name(sacrat${horizon}_nonmodvars_rules, replace) levels(90) note("Bands represent 90% confidence intervals." "Regressions are of form: {it:sacratio = c + a*rule_tr + b*rule_g + beta*(non-model attribute)}") 
	estimates drop *
	graph export "./output/coef_plots_outcomes/sac${horizon}_nonmodvars_rules.pdf", as(pdf) replace

	*Modelvars
	foreach var of varlist $modelvars {
		robreg m sacratio${horizon} rule_tr rule_g `var', k(4.685) bis center updatescale
		estimates store `var'
		loc r2_`var' = round(e(${r2measure_outcomes}), 0.01)
	}
	glo coefplot_call "coefplot"
	foreach var of varlist $modelvars {
		glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(`var'))"
	}
	glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
	loc rownum = 1
	glo coefplot_call "${coefplot_call} text("
	foreach var of varlist $modelvars {
		 glo coefplot_call `"${coefplot_call} `rownum' 6.5 "R{superscript:2} = `r2_`var''""'
		 loc rownum = `rownum' + 1
	}
	glo coefplot_call "${coefplot_call} )"
	$coefplot_call title("Bivariate Regressions of {it:sacratio} on Model" "Attribute Variables, Rule Fixed Effects", size(*0.8)) name(sacrat${horizon}_modvars, replace) levels(90) note("Bands represent 90% confidence intervals." "Regressions are of form: {it:sacratio = c + a*rule_tr + b*rule_g + beta*(model attribute)}")	 xscale(range(-4 7.5))
	graph export "./output/coef_plots_outcomes/sac${horizon}_modvars_ofinterest.pdf", as(pdf) replace

	glo coefplot_call "coefplot"
	foreach var of varlist $modelvars {
		local x: variable label `var'
		glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(rule_tr rule_g _cons) label(`x'))"
	}
	glo coefplot_call = "${coefplot_call}, legend(on pos(6) rows(2) size(*0.8)) xline(0)"
	$coefplot_call title("Rule Coefficients from Bivariate Regressions of {it:sacratio}" "on Model Attribute Variables", size(*0.8)) xsize(*1.1) name(sacrat${horizon}_modvars_rules, replace) levels(90) note("Bands represent 90% confidence intervals." "Regressions are of form: {it:sacratio = c + a*rule_tr + b*rule_g + beta*(model attribute)}") 
	estimates drop *
	graph export "./output/coef_plots_outcomes/sac${horizon}_modvars_rules.pdf", as(pdf) replace



	********************************************************************************
	*** Bill's sacratio
	********************************************************************************
	*Nonmodelvars
	foreach var of varlist $nonmodelvars {
		robreg m Billsacrat${horizon} rule_tr rule_g `var', k(4.685) bis center updatescale
		estimates store `var'
		loc r2_`var' = round(e(${r2measure_outcomes}), 0.01)
	}
	glo coefplot_call "coefplot"
	foreach var of varlist $nonmodelvars {
		glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(`var'))"
	}
	glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
	loc rownum = 1
	glo coefplot_call "${coefplot_call} text("
	foreach var of varlist $nonmodelvars {
		 glo coefplot_call `"${coefplot_call} `rownum' 0.45 "R{superscript:2} = `r2_`var''""'
		 loc rownum = `rownum' + 1
	}
	glo coefplot_call "${coefplot_call} )"
	$coefplot_call title("Bivariate Regressions of {it:Billsacrat} on Non-model" "Attribute Variables, Rule Fixed Effects", size(*0.8)) name(Billsac${horizon}_nonmodvars, replace) levels(90) note("Bands represent 90% confidence intervals." "Regressions are of form: {it:Billsacrat = c + a*rule_tr + b*rule_g + beta*(non-model attribute)}") xscale(range(-0.4 0.6))
	graph export "./output/coef_plots_outcomes/Billsac${horizon}_nonmodvars_ofinterest.pdf", as(pdf) replace

	glo coefplot_call "coefplot"
	foreach var of varlist $nonmodelvars {
		local x: variable label `var'
		glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(rule_tr rule_g _cons) label(`x'))"
	}
	glo coefplot_call = "${coefplot_call}, legend(on pos(6) rows(2) size(*0.8)) xline(0)"
	$coefplot_call title("Rule Coefficients from Bivariate Regressions of {it:Billsacrat}" " on Non-model Attribute Variables", size(*0.8)) xsize(*1.1) name(Billsac${horizon}_nonmodvars_rules, replace) levels(90) note("Bands represent 90% confidence intervals." "Regressions are of form: {it:Billsacrat = c + a*rule_tr + b*rule_g + beta*(non-model attribute)}") 	 
	estimates drop *
	graph export "./output/coef_plots_outcomes/Billsac${horizon}_nonmodvars_rules.pdf", as(pdf) replace

	*Modelvars
	foreach var of varlist $modelvars {
		robreg m Billsacrat${horizon} rule_tr rule_g `var', k(4.685) bis center updatescale
		estimates store `var'
		loc r2_`var' = round(e(${r2measure_outcomes}), 0.01)
	}
	glo coefplot_call "coefplot"
	foreach var of varlist $modelvars {
		glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(`var'))"
	}
	glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
	loc rownum = 1
	glo coefplot_call "${coefplot_call} text("
	foreach var of varlist $modelvars {
		 glo coefplot_call `"${coefplot_call} `rownum' 1 "R{superscript:2} = `r2_`var''""'
		 loc rownum = `rownum' + 1
	}
	glo coefplot_call "${coefplot_call} )"
	$coefplot_call title("Bivariate Regressions of {it:Billsacrat} on Model" "Attribute Variables, Rule Fixed Effects", size(*0.8)) name(Billsac${horizon}_modvars, replace) levels(90) note("Bands represent 90% confidence intervals." "Regressions are of form: {it:Billsacrat = c + a*rule_tr + b*rule_g + beta*(model attribute)}") xscale(range(-0.5 1.2))	
	graph export "./output/coef_plots_outcomes/Billsac${horizon}_modvars_ofinterest.pdf", as(pdf) replace

	glo coefplot_call "coefplot"
	foreach var of varlist $modelvars {
		local x: variable label `var'
		glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(rule_tr rule_g _cons) label(`x'))"
	}
	glo coefplot_call = "${coefplot_call}, legend(on pos(6) rows(2) size(*0.8)) xline(0)"
	$coefplot_call title("Rule Coefficients from Bivariate Regressions of {it:Billsacrat}" " on Model Attribute Variables", size(*0.8)) xsize(*1.1) name(Billsac${horizon}_modvars_rules, replace) levels(90) note("Bands represent 90% confidence intervals." "Regressions are of form: {it:Billsacrat = c + a*rule_tr + b*rule_g + beta*(model attribute)}") 	
	estimates drop *
	graph export "./output/coef_plots_outcomes/Billsac${horizon}_modvars_rules.pdf", as(pdf) replace



	********************************************************************************
	*** piq_cum${horizon}/rrate_cum${horizon}
	********************************************************************************
	*Nonmodelvars
	foreach var of varlist $nonmodelvars {
		robreg m infl_per_rr${horizon} rule_tr rule_g `var', k(4.685) bis center updatescale
		estimates store `var'
		loc r2_`var' = round(e(${r2measure_outcomes}), 0.01)
	}
	glo coefplot_call "coefplot"
	foreach var of varlist $nonmodelvars {
		glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(`var'))"
	}
	glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
	loc rownum = 1
	glo coefplot_call "${coefplot_call} text("
	foreach var of varlist $nonmodelvars {
		 glo coefplot_call `"${coefplot_call} `rownum' .25 "R{superscript:2} = `r2_`var''""'
		 loc rownum = `rownum' + 1
	}
	glo coefplot_call "${coefplot_call} )"
	$coefplot_call title("Bivariate Regressions of {it:{&pi}-slope} on Non-model" "Attribute Variables, Rule Fixed Effects", size(*0.8)) name(ipr${horizon}_nonmodvars, replace) levels(90) note("Bands represent 90% confidence intervals." "Regressions are of form: {it:{&pi}-slope = c + a*rule_tr + b*rule_g + beta*(non-model attribute)}") xscale(range(-0.2 0.3))	
	graph export "./output/coef_plots_outcomes/ipr${horizon}_nonmodvars_ofinterest.pdf", as(pdf) replace

	glo coefplot_call "coefplot"
	foreach var of varlist $nonmodelvars {
		local x: variable label `var'
		glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(rule_tr rule_g _cons) label(`x'))"
	}
	glo coefplot_call = "${coefplot_call}, legend(on pos(6) rows(2) size(*0.8)) xline(0)"
	$coefplot_call title("Rule Coefficients from Bivariate Regressions of {it:{&pi}-slope}" " on Non-model Attribute Variables", size(*0.8)) xsize(*1.1) name(ipr${horizon}_nonmodvars_rules, replace) levels(90) note("Bands represent 90% confidence intervals." "Regressions are of form: {it:{&pi}-slope = c + a*rule_tr + b*rule_g + beta*(non-model attribute)}") 	
	estimates drop *
	graph export "./output/coef_plots_outcomes/ipr${horizon}_nonmodvars_rules.pdf", as(pdf) replace

	*Modelvars
	foreach var of varlist $modelvars {
		capture robreg m infl_per_rr${horizon} rule_g rule_itr `var', k(4.685) bis center updatescale
		estimates store `var'
		loc r2_`var' = round(e(${r2measure_outcomes}), 0.01)
	}
	glo coefplot_call "coefplot"
	foreach var of varlist $modelvars {
		glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(`var'))"
	}
	glo coefplot_call = "${coefplot_call}, legend(off) xline(0)"
	loc rownum = 1
	glo coefplot_call "${coefplot_call} text("
	foreach var of varlist $modelvars {
		 glo coefplot_call `"${coefplot_call} `rownum' .25 "R{superscript:2} = `r2_`var''""'
		 loc rownum = `rownum' + 1
	}
	glo coefplot_call "${coefplot_call} )"
	$coefplot_call title("Bivariate Regressions of {it:{&pi}-slope} on Model" "Attribute Variables, Rule Fixed Effects", size(*0.8)) name(ipr${horizon}_modvars, replace) levels(90) note("Bands represent 90% confidence intervals." "Regressions are of form: {it:{&pi}-slope = c + a*rule_tr + b*rule_g + beta*(model attribute)}") xscale(range(-0.3 0.3))
	graph export "./output/coef_plots_outcomes/ipr${horizon}_modvars_ofinterest.pdf", as(pdf) replace

	glo coefplot_call "coefplot"  
	foreach var of varlist $modelvars {
		local x: variable label `var'
		glo coefplot_call "${coefplot_call} (`var', msymbol(D) msize(*0.5) keep(rule_tr rule_g _cons) label(`x'))"
	}
	glo coefplot_call = "${coefplot_call}, legend(on pos(6) rows(2) size(*0.8)) xline(0)"
	$coefplot_call title("Rule Coefficients from Bivariate Regressions of {it:{&pi}-slope}" " on Model Attribute Variables", size(*0.8)) xsize(*1.1) name(ipr${horizon}_modvars_rules, replace) levels(90) note("Bands represent 90% confidence intervals." "Regressions are of form: {it:{&pi}-slope = c + a*rule_tr + b*rule_g + beta*(model attribute)}") 
	estimates drop *
	graph export "./output/coef_plots_outcomes/ipr${horizon}_modvars_rules.pdf", as(pdf) replace
}
set graphics on


	
