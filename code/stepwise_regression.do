glo numbers = "one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty twentyone twentytwo twentythree twentyfour twentyfive twentysix twentyseven twentyeight twentynine thirty thirtyone thirtytwo thirtythree thirtyfour thirtyfive"




graph close
use .${cleandata}MMB_reg_format.dta, clear


//Migrated this portion over to Python
//! python3 .${code}/do_not_change_this_file_plz_make_all_changes_to_ipynb_version_MMB_robreg.py

/* 
********************************************************************************
*** Outcome Dependent Variables
********************************************************************************
capture program drop step_reg
program define step_reg
	args depvar condition
	
	*Step 1: Variable to enter the regression
	loc best_pval_in_step = 1
	loc entering_var " "
	foreach var of global pot_covariates{
		capture noisily robreg m `depvar' `var' ${entered_vars} `condition', k(4.685) bis center updatescale
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
			capture noisily robreg m `depvar' `var' ${entered_except_for} `condition', k(4.685) bis center updatescale
			if _rc != 0{
				continue
			}
			loc interesting_pval = r(table)[4,1]
			if `interesting_pval'>$alpha_exit | `interesting_pval' == .{
				glo entered_vars = "$entered_except_for"
				glo pot_covariates = "${pot_covariates} `var'"
				continue, break
			}
		}
	}

	
	glo reg_call = "robreg m `depvar' ${entered_vars} `condition', k(4.685) bis center updatescale"
end


glo depvars "IScurve infl_per_rr sacratio"

foreach var of global depvars{
	foreach type in "mod_Oth" "mod_All" "nonmod_All" "nonmod_Est"{
		if "`type'" == "nonmod_Est"{
			loc condition "if estimated"
		}
		else{
			loc condition " "
		}
		forvalues i = 20(20)60{
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
foreach depvar of global depvars{
	foreach type in "mod_Oth" "mod_All" "nonmod_All" "nonmod_Est"{
		log using ./output/stepwise_regressions/`depvar'_`type', replace
			di "********************************************************************************"
			di "Outcomes of bi-directional stepwise regressions "
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
		translate ./output/stepwise_regressions/`depvar'_`type'.smcl ./output/stepwise_regressions/`depvar'_`type'.pdf, translator(smcl2pdf)
		! rm ./output/stepwise_regressions/`depvar'_`type'.smcl
	}
}


*Now put those results ready for Latex!
glo resultsfile = "./output/stepwise_regressions/texresults_outcomevars_stepwise_output.txt"
capture ! rm -r "${resultsfile}"

loc j = 1

foreach depvar of global depvars{
	glo colnum: word `j' of ${numbers}
	
	loc h = 1

	foreach type in "mod_All" "nonmod_All"{
		glo tabnum: word `h' of ${numbers}
				
		${reg_`depvar'20_`type'}
		loc k = 1
		
			//loop through potential covariates
			foreach var of global indepvars_`type'{
				glo rownum: word `k' of ${numbers}
				
				//reseting these globals to avoid mistakes
				global vnum 
				global se
				global beta
				global record_or_not
				
				//did that covariate get included? (set a switch for yes or no)
				if strpos(e(cmdline), "`var'")!=0{
					local indepvars = e(indepvars)
					glo vnum: list posof "`var'" in indepvars
					loc beta = round(r(table)[1, ${vnum}], 0.001)
					
					if `beta'==.{
						glo record_or_not = 0
					}
					else{
						glo record_or_not = 1
					}
				}
				else{
					glo record_or_not = 0
				}
				
				
				
				if $record_or_not == 1 {
					loc se = round(r(table)[2, ${vnum}], 0.001)
					if `se' < 1 {
						loc se = "0`se'" //put a 0 in front of the SE if less than 1
					}
					
					texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}beta") result(`beta') append unitzero
					texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}se") string("(`se')") append unitzero
					
					//if the variable significant?
					if r(table)[4, ${vnum}] < 0.01{
						texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string(^{***}) append 
					}
					else if r(table)[4, ${vnum}] < 0.05 {
						texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string(^{**}) append 
					}
					else if r(table)[4, ${vnum}] < 0.1 {
						texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string(^{*}) append 
					}
					else{
						texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string() append 
					}
					
				}
				
				//variable not included? Bummer, but let's add blanks for it
				else{
					texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}beta") result("") append unitzero
					texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}se") result("") append unitzero
					texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") result("") append unitzero
				}
				
				loc k = `k'+1
			}
			
			//constant
			glo rownum: word `k' of ${numbers}
			loc cons_pos = wordcount(e(indepvars)) + 1 //+1 for constant :)
			loc beta = round(r(table)[1, `cons_pos'], 0.001)
			loc se = round(r(table)[2, `cons_pos'], 0.001)
			if `se' < 1 {
				loc se = "0`se'" //put a 0 in front of the SE if less than 1
			}
			texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}beta") result(`beta') append unitzero
			texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}se") string("(`se')") append unitzero
			
			//is the constant significant?
			if r(table)[4, `cons_pos'] < 0.01{
				texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string(^{***}) append 
			}
			else if r(table)[4, `cons_pos'] < 0.05 {
				texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string(^{**}) append 
			}
			else if r(table)[4, `cons_pos'] < 0.1 {
				texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string(^{*}) append 
			}
			else{
				texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string() append 
			}
			
			texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}COLUMN${colnum}N") result(e(N)) append unitzero
			texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}COLUMN${colnum}rsq") result(e(r2_w)) append unitzero

		loc h = `h'+1
	}
	
	loc j = `j'+1
}
*/


	
	
	

********************************************************************************
*** Timing Dependent Variables
********************************************************************************

glo resultsfile = "./output/stepwise_regressions/texresults_timingvars_stepwise_output.txt"
capture ! rm -r "${resultsfile}"

capture program drop step_reg_nb
program define step_reg_nb
	args depvar condition
	
	*Step 1: Variable to enter the regression
	loc best_pval_in_step = 1
	loc entering_var " "
	foreach var of global pot_covariates{
		capture noisily nbreg `depvar' `var' ${entered_vars}  if `depvar'<$time_limit `condition', vce(r)
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
			capture noisily nbreg `depvar' `var' ${entered_except_for}  if `depvar'<$time_limit `condition', vce(r)
			if _rc != 0{
				continue
			}
			loc interesting_pval = r(table)[4,1]
			if `interesting_pval'>$alpha_exit | `interesting_pval' == .{
				glo entered_vars = "$entered_except_for"
				glo pot_covariates = "${pot_covariates} `var'"
				continue, break
			}
		}
	}

	glo reg_call = "nbreg `depvar' `var' ${entered_vars}  if `depvar'<${time_limit} `condition', vce(r)"
end


/*
glo time_limit = 60
//glo depvars "piq_timing_max y_timing_max rrate_timing_min irate_timing_min"
glo depvars "y_timing_max piq_timing_max"
foreach var of global depvars{
	foreach type in "mod_Oth" "mod_All" "nonmod_All" "nonmod_Est"{
		if "`type'" == "nonmod_Est"{
			loc condition "& estimated"
		}
		else{
			loc condition " "
		}
		glo keep_stepping = 1
		glo entered_vars
		glo pot_covariates "${indepvars_`type'}"
		while $keep_stepping {
			step_reg_nb `var'
		}
		glo reg_`var'_`type' "$reg_call"
		}
}
*/

glo time_limit = 60
//glo depvars "piq_timing_max y_timing_max rrate_timing_min irate_timing_min"
glo depvars "y_timing_max piq_timing_max"
foreach var of global depvars{
	foreach type in "all_sim" "all_det" "frics_det" "frics_sim" "properties" {
		loc condition " "
		glo keep_stepping = 1
		glo entered_vars
		glo pot_covariates "${indepvars_`type'}"
		while $keep_stepping {
			step_reg_nb `var'
		}
		glo reg_`var'_`type' "$reg_call"
		}
}



********************************************************************************
********************************************************************************
cls
foreach depvar of global depvars{
	//foreach type in "mod_Oth" "mod_All" "nonmod_All" "nonmod_Est"{
	foreach type in "all_sim" "all_det" "frics_det" "frics_sim" "properties" {
		log using ./output/stepwise_regressions/`depvar'_`type', replace
		capture ! rm ./output/stepwise_regressions/`depvar'_`type'.pdf
		di "********************************************************************************"
		di "Outcomes of bi-directional stepwise regressions with `depvar' with rule fixed effects"
		di "Independent Variable set: `type'"
		di "********************************************************************************"
		${reg_`depvar'_`type'}
		log close
		translate ./output/stepwise_regressions/`depvar'_`type'.smcl ./output/stepwise_regressions/`depvar'_`type'.pdf, translator(smcl2pdf)
		! rm ./output/stepwise_regressions/`depvar'_`type'.smcl
		di "********************************************************************************"
	}
}



*Now put those results ready for Latex!
//appending to the results file; no need to restart local j either because these are just new columns in the same tables
foreach depvar of global depvars{
	loc j = 1 
	glo colnum: word `j' of ${numbers}
	
	loc h = 1

	//foreach type in "mod_All" "nonmod_All"{
	foreach type in "all_sim" "all_det" "frics_det" "frics_sim" "properties" {
		glo tabnum: word `h' of ${numbers}
				
		${reg_`depvar'_`type'}
		loc k = 1
		
			//loop through potential covariates
			foreach var of global indepvars_`type'{				
				glo rownum: word `k' of ${numbers}
				
				//reseting these globals to avoid mistakes
				global vnum 
				global se
				global beta
				global record_or_not
				
				//did that covariate get included? (set a switch for yes or no)	
				
				if strpos(e(cmdline), "`var'")!=0{
					local indepvars = e(cmdline)
					glo vnum: list posof "`var'" in indepvars
					glo vnum = $vnum - 2
					loc se = round(r(table)[2, ${vnum}], 0.001)	//gives beta as 0 but se as . so have to adapt
					
					if `se'==.{
						glo record_or_not = 0
					}
					else{
						glo record_or_not = 1
					}
				}
				else{
					glo record_or_not = 0
				}	
				
				if $record_or_not == 1 {
					loc beta = round(r(table)[1, ${vnum}], 0.001)
					if `se' < 1 {
						loc se = "0`se'" //put a 0 in front of the SE if less than 1
					}
					loc beta = string(`beta')
					
					texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}beta") string(`beta') append unitzero
					texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}se") string("(`se')") append unitzero
					
					//is the variable significant?
					if r(table)[4, ${vnum}] < 0.01{
						texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string(^{***}) append 
					}
					else if r(table)[4, ${vnum}] < 0.05 {
						texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string(^{**}) append 
					}
					else if r(table)[4, ${vnum}] < 0.1 {
						texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string(^{*}) append 
					}
					else{
						texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string() append 
					}
					
				}
				
				//variable not included? Bummer, but let's add blanks for it
				else{
					texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}beta") result("") append unitzero
					texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}se") result("") append unitzero
					texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") result("") append unitzero
				}				
				
				loc k = `k'+1
			}
			
			//constant
			glo rownum: word `k' of ${numbers}
			loc cons_pos = wordcount(e(cmdline)) - 2 - 3 //-2 for "nbreg yvar", -3 for end
			loc beta = round(r(table)[1, `cons_pos'], 0.001)
			loc se = round(r(table)[2, `cons_pos'], 0.001)
			if `se' < 1 {
				loc se = "0`se'" //put a 0 in front of the SE if less than 1
			}
			loc beta = string(`beta')
			texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}beta") string(`beta') append unitzero
			texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}se") string("(`se')") append unitzero
			
			//is the constant significant?
			if r(table)[4, `cons_pos'] < 0.01{
				texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string(^{***}) append 
			}
			else if r(table)[4, `cons_pos'] < 0.05 {
				texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string(^{**}) append 
			}
			else if r(table)[4, `cons_pos'] < 0.1 {
				texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string(^{*}) append 
			}
			else{
				texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}ROW${rownum}COLUMN${colnum}star") string() append 
			}
			
			loc N = string(e(N))
			loc r2 = string(e(r2_p), "%9.3f")

			texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}COLUMN${colnum}N") string(`N') append unitzero
			texresults using "${resultsfile}", texmacro("stepwiseT${tabnum}COLUMN${colnum}rsq") string(`r2')  append unitzero

		loc h = `h'+1
	}
	
	loc j = `j'+1
}
