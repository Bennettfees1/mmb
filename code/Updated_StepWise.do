glo numbers = "one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty twentyone twentytwo twentythree twentyfour twentyfive twentysix twentyseven twentyeight twentynine thirty thirtyone thirtytwo thirtythree thirtyfour thirtyfive"

graph close
use .${cleandata}MMB_reg_format.dta, clear

********************************************************************************
*** Outcome Dependent Variables
********************************************************************************
capture program drop step_reg
program define step_reg
    args depvar condition
    
    *Step 1: Variable to enter the regression
    loc best_pval_in_step = 1
    loc entering_var " "
    foreach var of global pot_covariates {
        * Run robust regression using `robreg`, with rule dummies added (edit a)
        * Removed sticky prices variable (edit b) and added stickiness types: Calvo, Rotenberg, Other (edit c)
        capture noisily robreg m `depvar' `var' ${entered_vars} rule_itr rule_g stky_pr_calvo stky_pr_rotemberg stky_pr_other `condition', k(4.685) bis center updatescale
        if _rc != 0 {
            continue
        }
        loc entrant_pval = r(table)[4,1]
        if `entrant_pval' < $alpha_enter & `entrant_pval' < `best_pval_in_step' {
            loc entering_var "`var'"
        }
    }
    if "`entering_var'" == " " {
        glo keep_stepping = 0
    } else {
        glo entered_vars "${entered_vars} `entering_var'"
        glo pot_covariates = subinword("$pot_covariates", "`entering_var'", "", 1)
    }
    
    * Step 2: Variables that should drop from regression
    loc num_of_entered_vars = wordcount("$entered_vars")
    loc final_var_to_test: word `num_of_entered_vars' of $entered_vars
    glo still_checking = 1
    while $still_checking {
        foreach var of global entered_vars {
            if "`var'" == "`final_var_to_test'" {
                glo still_checking = 0
            }
            glo entered_except_for = subinword("$entered_vars", "`var'", "", 1)
            * Robust regression with updated covariates in the drop check (edits a, b, c)
            capture noisily robreg m `depvar' `var' ${entered_except_for} rule_itr rule_g stky_pr_calvo stky_pr_rotemberg stky_pr_other `condition', k(4.685) bis center updatescale
            if _rc != 0 {
                continue
            }
            loc interesting_pval = r(table)[4,1]
            if `interesting_pval' > $alpha_exit | `interesting_pval' == . {
                glo entered_vars = "$entered_except_for"
                glo pot_covariates = "${pot_covariates} `var'"
                continue, break
            }
        }
    }

    glo reg_call = "robreg m `depvar' ${entered_vars} rule_itr rule_g stky_pr_calvo stky_pr_rotemberg stky_pr_other `condition', k(4.685) bis center updatescale"
end

glo depvars "
infl_per_rr sacratio"

foreach var of global depvars {
    foreach type in "mod_Oth" "mod_All" "nonmod_All" "nonmod_Est" {
        if "`type'" == "nonmod_Est" {
            loc condition "if estimated"
        } else {
            loc condition " "
        }
        forvalues i = 20(20)60 {
            glo keep_stepping = 1
            glo entered_vars
            glo pot_covariates "${indepvars_`type'}"
            while $keep_stepping {
                step_reg `var'`i' "`condition'"
            }
            glo reg_`var'`i'_`type' "$reg_call"
        }
    }
}

********************************************************************************
********************************************************************************
cls
foreach depvar of global depvars {
    foreach type in "mod_Oth" "mod_All" "nonmod_All" "nonmod_Est" {
        log using ./output/stepwise_regressions/`depvar'_`type', replace
            di "********************************************************************************"
            di "Outcomes of bi-directional stepwise regressions "
            di "with `depvar' across different horizons with rule fixed effects"
            di "Independent Variable set: `type'"
            di "********************************************************************************"
            display _n "{newpage}"
        forvalues i = 20(20)60 {
            di "********************************************************************************"
            di "Dependent Variable: `depvar'`i'"
            di "********************************************************************************", _newline(2)
            ${reg_`depvar'`i'_`type'}
            display _n "{newpage}"
        }
        log close
        translate ./output/stepwise_regressions/`depvar'_`type'.smcl ./output/stepwise_regressions/`depvar'_`type'.pdf, translator(smcl2pdf)
        ! rm ./output/stepwise_regressions/`depvar'_`type'.smcl
    }
}


********************************************************************************
*** Prepare Results for LaTeX
********************************************************************************

* Define file for storing LaTeX output
glo resultsfile = "./output/stepwise_regressions/texresults_outcomevars_stepwise_output.txt"
capture ! rm -r "${resultsfile}"

loc j = 1

* Loop over each dependent variable and type
foreach depvar of global depvars {
	glo colnum: word `j' of ${numbers}
	
	loc h = 1

	foreach type in "mod_All" "nonmod_All" {
		glo tabnum: word `h' of ${numbers}
				
		${reg_`depvar'20_`type'}
		loc k = 1
		
		// Loop through potential covariates, including specific price stickiness types
		foreach var of global indepvars_`type' {
			glo rownum: word `k' of ${numbers}
			
			// Reset globals for tracking coefficients and significance
			global vnum 
			global se
			global beta
			global record_or_not
			
			// Check if the covariate was included in the model
			if strpos(e(cmdline), "`var'") != 0 {
				local indepvars = e(cmdline)
				glo vnum: list posof "`var'" in indepvars
				glo vnum = $vnum - 2
				
				// Capture standard error and handle cases with missing SE
				loc se = round(r(table)[2, ${vnum}], 0.001)
				if `se' == . {
					glo record_or_not = 0
				}
				else {
					glo record_or_not = 1
				}
			}
			else {
				glo record_or_not = 0
			}	
			
			if $record_or_not == 1 {
				// Capture beta coefficient, format SE, and save to LaTeX output
				loc beta = round(r(table)[1, ${vnum}], 0.001)
				if `se' < 1 {
					loc se = "0`se'" // add leading 0 if SE < 1
				}
				
				texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}beta") result(`beta') append unitzero
				texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}se") string("(`se')") append unitzero
				
				// Assess significance and append stars for p-values
				if r(table)[4, ${vnum}] < 0.01 {
					texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string(^{***}) append 
				}
				else if r(table)[4, ${vnum}] < 0.05 {
					texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string(^{**}) append 
				}
				else if r(table)[4, ${vnum}] < 0.1 {
					texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string(^{*}) append 
				}
				else {
					texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string() append 
				}
				
			}
			else {
				// If variable not included, leave blanks for LaTeX table
				texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}beta") result("") append unitzero
				texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}se") result("") append unitzero
				texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") result("") append unitzero
			}				
			
			loc k = `k' + 1
		}
		
		// Constant term processing
		glo rownum: word `k' of ${numbers}
		loc cons_pos = wordcount(e(cmdline)) - 2 - 3 // Adjusted position for constant term
		loc beta = round(r(table)[1, `cons_pos'], 0.001)
		loc se = round(r(table)[2, `cons_pos'], 0.001)
		if `se' < 1 {
			loc se = "0`se'" // add leading 0 if SE < 1
		}
		texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}beta") result(`beta') append unitzero
		texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}se") string("(`se')") append unitzero
		
		// Significance for the constant term
		if r(table)[4, `cons_pos'] < 0.01 {
			texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string(^{***}) append 
		}
		else if r(table)[4, `cons_pos'] < 0.05 {
			texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string(^{**}) append 
		}
		else if r(table)[4, `cons_pos'] < 0.1 {
			texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string(^{*}) append 
		}
		else {
			texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string() append 
		}
		
		// Add sample size and R-squared for each regression model
		texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}COLUMN${colnum}N") result(e(N)) append unitzero
		texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}COLUMN${colnum}rsq") result(e(r2_p)) append unitzero

		loc h = `h' + 1
	}
	
	loc j = `j' + 1
}

		
		
		
********************************************************************************
*** Timing Dependent Variables
********************************************************************************

capture program drop step_reg_nb
program define step_reg_nb
	args depvar condition
	
	* Step 1: Variable to enter the regression
	loc best_pval_in_step = 1
	loc entering_var " "
	foreach var of global pot_covariates {
		* Modify regression call to include rule dummies (Inertial Taylor Rule and Growth Rule)
		* Exclude the Taylor Rule (serving as the baseline)
		capture noisily nbreg `depvar' `var' ${entered_vars} rule_itr rule_g `condition' if `depvar' < $time_limit, vce(r)
		if _rc != 0 {
			continue
		}
		loc entrant_pval = r(table)[4,1]
		if `entrant_pval' < $alpha_enter & `entrant_pval' < `best_pval_in_step' {
			loc entering_var "`var'"
		}
	}
	if "`entering_var'" == " " {
		glo keep_stepping = 0
	}
	else {
		glo entered_vars "${entered_vars} `entering_var'"
		glo pot_covariates = subinword("$pot_covariates", "`entering_var'", "", 1)
	}

	* Step 2: Variables that should drop from regression
	loc num_of_entered_vars = wordcount("$entered_vars")
	loc final_var_to_test: word `num_of_entered_vars' of $entered_vars
	glo still_checking = 1
	while $still_checking {
		foreach var of global entered_vars {
			if "`var'" == "`final_var_to_test'" {
				glo still_checking = 0
			}
			glo entered_except_for = subinword("$entered_vars", "`var'", "", 1)
			* Update to include rule dummies and additional price stickiness types (Calvo, Rotemberg, Other)
			capture noisily nbreg `depvar' `var' ${entered_except_for} rule_itr rule_g `condition' if `depvar' < $time_limit, vce(r)
			if _rc != 0 {
				continue
			}
			loc interesting_pval = r(table)[4,1]
			if `interesting_pval' > $alpha_exit | `interesting_pval' == . {
				glo entered_vars = "$entered_except_for"
				glo pot_covariates = "${pot_covariates} `var'"
				continue, break
			}
		}
	}

	* Define the final regression call with all edits
	glo reg_call = "nbreg `depvar' ${entered_vars} rule_itr rule_g `condition' if `depvar' < ${time_limit}, vce(r)"
end

* Set time limit for timing-dependent variable regressions
glo time_limit = 60
glo depvars "y_timing_max piq_timing_max"

* Run stepwise regression for timing-dependent variables with different types
foreach var of global depvars {
	foreach type in "mod_Oth" "mod_All" "nonmod_All" "nonmod_Est" {
		if "`type'" == "nonmod_Est" {
			loc condition "& estimated"
		}
		else {
			loc condition " "
		}
		glo keep_stepping = 1
		glo entered_vars
		* Update pot_covariates to include only relevant price stickiness types
		glo pot_covariates "${indepvars_`type'} stky_pr_calvo stky_pr_rotemberg stky_pr_other"
		while $keep_stepping {
			step_reg_nb `var'
		}
		glo reg_`var'_`type' "$reg_call"
	}
}
********************************************************************************

		
		
		
		
		
		
		