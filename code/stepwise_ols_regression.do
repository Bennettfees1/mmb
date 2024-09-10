*NOT FOR USE BY ACTUAL PROJECT! JUST CONVINCING BOB THAT MY STEPWISE PROCEDURE 
*GETS THE SAME RESULTS AS HIS EVIEWS PACKAGED ONE

graph close
use .${cleandata}MMB_reg_format.dta, clear

*Label data -- Nonmodel Characteristics
label var estimated "Estimated"
label var calibrated "Calibrated"
label var cb_authors_ext "Central Bank Author"
label var cb_authors "% Central Bank Authors"
label var neq "Num. of Eq."
label var ln_neq "ln(Num. of Eq.)"
label var vint_early "Early Vintage"
label var vint_mid "Mid Vintage"
label var vint_late "Late Vintage"
label var est_early "Early Estimation"
label var est_late "Late Estimation"


*Label data -- Rules
label var rule_itr "Inertial Taylor Rule"
label var rule_g "Growth Rule"
label var rule_tr "Taylor Rule"


*Label data -- Model Characteristics
label var open "Open"
label var ntwrth "Net Worth Effect"
label var wlth "Wealth Effect"
label var bnkcrdit "Bank Credit Effect"
label var other_channel "Other Channel"
label var learning "Learning"
label var gov_spend "Govt. Spending"
label var gov_debt "Govt. Debt"
label var tax "Tax"
label var fiscal "Fiscal"
label var ndx_all "P and W Indexation"
label var pr_ndx "Price Indexation"
label var wg_ndx "Wage Indexation"
label var wg_ndx_mult "Wage Index. Mult. Prices"
label var wg_ndx_prprice "Wage Index. Prev. Price"
label var wg_ndx_other "Wage Index. Other"
label var not_stky_pr "No Sticky Prices"
label var stky_pr "Sticky Prices"
label var stky_pr_other "Sticky Prices Other"
label var stky_pr_ndx "Sticky Prices & Index."
label var stky_wg_ndx "Sticky Wages & Index."
label var stky_pr_calvo "Calvo Pricing"
label var stky_pr_rotemberg "Rotemberg Pricing"


glo indepvars_nonmodchars "cb_authors_ext estimated calibrated ln_neq vint_early vint_mid vint_late est_early est_late rule_tr rule_g rule_itr"

//glo indepvars_modchars "open ntwrth wlth bnkcrdit other_channel learning ndx_all wg_ndx_prprice wg_ndx_other not_stky_pr stky_pr stky_pr_other stky_pr_rotemberg stky_pr_calvo stky_pr_ndx stky_wg_ndx stky_pr_nondx stky_wg_nondx rule_tr rule_g rule_itr"

glo indepvars_modchars "rule_gr rule_tr wlth ntwrth bnkcrdit learning open stky_pr stky_pr_rotemberg stky_pr_other stky_all stky_wg wg_ndx pr_ndx stky_wg"
 
global alpha_enter = 0.5
global alpha_exit = 0.5



********************************************************************************
*** Outcome Dependent Variables
********************************************************************************
capture program drop step_reg
program define step_reg
	args depvar
	
	*Step 1: Variable to enter the regression
	loc best_pval_in_step = 1
	loc entering_var " "
	foreach var of global pot_covariates{
		capture noisily reg `depvar' `var' ${entered_vars}, r noconstant 
		if _rc != 0{
			continue
		}
		loc entrant_pval = r(table)[4,1]
		if `entrant_pval'<$alpha_enter & `entrant_pval'<`best_pval_in_step'{
			loc entering_var "`var'"
		}
	}
	if "`entering_var'" == " "{
		glo keep_stepping = 0
	}
	else{
		glo entered_vars "${entered_vars} `entering_var'"
		glo pot_covariates = subinword("$pot_covariates", "`entering_var'", "", 1)
	}
	
	
	*Step 2: Variables that should drop from regression
	loc num_of_entered_vars = wordcount("$entered_vars")
	loc final_var_to_test: word `num_of_entered_vars' of $entered_vars
	glo still_checking = 1
	while $still_checking {
		foreach var of global entered_vars{
			if "`var'" == "`final_var_to_test'"{
				glo still_checking = 0
			}
			glo entered_except_for = subinword("$entered_vars", "`var'", "", 1)
			capture noisily reg `depvar' `var' ${entered_except_for}, r noconstant 
			if _rc != 0{
				continue
			}
			loc interesting_pval = r(table)[4,1]
			if `interesting_pval'>$alpha_exit | `interesting_pval' == .{
				glo entered_vars = "$entered_except_for"
				glo pot_covariates = "${pot_covariates} `var'"
				glo still_checking = 0 //maybe?
				continue, break
			}
		}
	}

	
	glo reg_call = "reg `depvar' ${entered_vars}, noconstant"
end


glo depvars "IScurve sacratio Billsacrat infl_per_rr"

foreach var of global depvars{
	foreach type in "modchars" {
		forvalues i = 20(20)60{
			glo keep_stepping = 1
			glo entered_vars
			glo pot_covariates "${indepvars_`type'}"
			while $keep_stepping {
				step_reg `var'`i'
			}
			glo reg_`var'`i'_`type' "$reg_call"
		}
	}
}


********************************************************************************
********************************************************************************
cls
foreach depvar of global depvars{
	foreach type in "modchars" "nonmodchars"{
		log using ./output/stepwise_regressions/ols_`depvar'_`type', replace
			di "********************************************************************************"
			di "Outcomes of bi-directional stepwise OLS regressions "
			di "with `depvar' across different horizons with rule fixed effects"
			di "Independent Variable set: `type'"
			di "********************************************************************************"
			display _n "{newpage}"
		forvalues i = 20(20)60{
			di "********************************************************************************"
			di "Dependent Variable: `depvar'`i'"
			di "********************************************************************************", _newline(2)
			${reg_`depvar'`i'_`type'}
			display _n "{newpage}"
		}
		log close
		translate ./output/stepwise_regressions/ols_`depvar'_`type'.smcl ./output/stepwise_regressions/ols_`depvar'_`type'.pdf, translator(smcl2pdf)
		! rm ./output/stepwise_regressions/ols_`depvar'_`type'.smcl
	}
}
	
	

	
	
	

********************************************************************************
*** Timing Dependent Variables
********************************************************************************
glo time_limit = 60
//glo depvars "piq_timing_max y_timing_max rrate_timing_min irate_timing_min"
glo depvars "y_timing_max pi_timing_max rrate_timing_min"
foreach var of global depvars{
	foreach type in "modchars" "nonmodchars"{
		glo keep_stepping = 1
		glo entered_vars
		glo pot_covariates "${indepvars_`type'}"
		while $keep_stepping {
			step_reg `var'
		}
		glo reg_`var'_`type' "$reg_call"
		}
}



********************************************************************************
********************************************************************************
cls
foreach depvar of global depvars{
	foreach type in "modchars" "nonmodchars"{
		log using ./output/stepwise_regressions/ols_`depvar'_`type', replace
		di "********************************************************************************"
		di "Outcomes of bi-directional stepwise regressions with `depvar' with rule fixed effects"
		di "Independent Variable set: `type'"
		di "********************************************************************************"
		${reg_`depvar'_`type'}
		log close
		translate ./output/stepwise_regressions/ols_`depvar'_`type'.smcl ./output/stepwise_regressions/ols_`depvar'_`type'.pdf, translator(smcl2pdf)
		! rm ./output/stepwise_regressions/ols_`depvar'_`type'.smcl
		di "********************************************************************************"
	}
}
