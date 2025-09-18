glo numbers = "one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty twentyone twentytwo twentythree twentyfour twentyfive twentysix twentyseven twentyeight twentynine thirty thirtyone thirtytwo thirtythree thirtyfour thirtyfive"




graph close
use .${cleandata}MMB_reg_format.dta, clear

drop if y_timing_max >= 99
drop if piq_timing_max >= 99

gen not_wg_ndx = 1 - wg_ndx
gen not_pr_ndx = 1 - pr_ndx
	
	

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
		//capture noisily nbreg `depvar' `var' ${entered_vars}  if `depvar'<$time_limit `condition', vce(r)
		capture noisily poisson `depvar' rule_g rule_itr estimated `var' ${entered_vars} ///
            if `depvar' < $time_limit `condition', vce(robust)
		if _rc != 0{
			continue
		}
		capture quietly testparm `var'
		local entrant_pval = cond(_rc, ., r(p))
		if (`entrant_pval' < $alpha_enter) & (`entrant_pval' < `best_pval_in_step') {
			local best_pval_in_step `entrant_pval'
			local entering_var "`var'"
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
	if (`num_of_entered_vars' > 0) {
		loc final_var_to_test: word `num_of_entered_vars' of $entered_vars
		glo still_checking = 1
		while $still_checking {
			foreach var of global entered_vars{
				if "`var'" == "`final_var_to_test'"{
					glo still_checking = 0
				}
				glo entered_except_for = subinword("$entered_vars", "`var'", "", 1)
				capture noisily poisson `depvar' rule_g rule_itr estimated `var' ${entered_except_for} ///
								if `depvar' < $time_limit `condition', vce(robust)			
				if _rc != 0{
					continue
				}
				capture quietly testparm `var'
				local interesting_pval = cond(_rc, ., r(p))
				if (`interesting_pval'>$alpha_exit) | (`interesting_pval' == .){
					glo entered_vars = "$entered_except_for"
					glo pot_covariates = "${pot_covariates} `var'"
					continue, break
				}
			}
		}
	}
	
	*Step 3: Wooldridge (1997) auxiliary regression for overdispersion
    quietly poisson `depvar' rule_g rule_itr estimated ${entered_vars} if `depvar' < $time_limit `condition', vce(robust)
	capture drop __mu __aux __mu2 __lin
	predict double __lin, xb
	gen double __mu = exp(__lin)
	// ((y - mu)^2 - y) = alpha * mu^2 + error
    gen double __aux = ((`depvar' - __mu)^2 - `depvar')
    gen double __mu2 = __mu^2
	// No-constant regression with robust SEs
    quietly regress __aux __mu2 if `depvar' < $time_limit `condition', nocons vce(robust)
    // Test H0: alpha = 0
    test __mu2
    local p_over = r(p)
    local alpha_hat = _b[__mu2]
	
	*Step 4: Decide final reporting model and store call
	if (`p_over' < 0.05) {
        // Overdispersion: QMLE NegBin with GLM robust SEs (NB2 variance: mu + alpha*mu^2)
        // We *estimate* alpha via GLM; robust SEs make it QMLE-robust to variance misspecification.
        global reg_call = "glm `depvar' rule_g rule_itr estimated ${entered_vars} if `depvar' < ${time_limit} `condition', family(nbinomial) link(log) vce(robust) nolog"
    }
    else {
        // No overdispersion: stick with robust Poisson
        global reg_call = "poisson `depvar' rule_g rule_itr estimated ${entered_vars} if `depvar' < ${time_limit} `condition', vce(robust) nolog"
    }
end


glo time_limit = 99
//glo depvars "piq_timing_max y_timing_max rrate_timing_min irate_timing_min"
glo depvars "y_timing_max piq_timing_max"
foreach var of global depvars{
	foreach type in "nomrig" "realrig" "nonmod" "all" "nomrig_all" "realrig_all" "nonmod_all" "all_all" {
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
foreach depvar of global depvars {
	foreach type in "nomrig" "realrig" "nonmod" "all" "nomrig_all" "realrig_all" "nonmod_all" "all_all" {
		log using ./output/stepwise_regressions/`depvar'_`type', replace
		capture ! rm ./output/stepwise_regressions/`depvar'_`type'.pdf
		di "********************************************************************************"
		di "Outcomes of bi-directional stepwise regressions with `depvar' (type = `type')"
		di "********************************************************************************"
		${reg_`depvar'_`type'}
		log close
		capture noisily translate ./output/stepwise_regressions/`depvar'_`type'.smcl ///
			./output/stepwise_regressions/`depvar'_`type'.pdf, translator(smcl2pdf)
		capture noisily ! rm ./output/stepwise_regressions/`depvar'_`type'.smcl
		di "********************************************************************************"
	}
}



********************************************************************************
* LaTeX export: one file per TYPE; columns = the two DVs
********************************************************************************

* Name your two dependent variables (exactly the two in $depvars, in your desired column order)
local dep1 y_timing_max
local dep2 piq_timing_max

* Column titles
local mtitles `" "Output timing (max)" "Inflation timing (max)" "'

* If you want to restrict what appears (use wildcards):
* - This does NOT force blank cells; it shows only estimated coefs.
* - If you want forced rows with blanks, say so and I'll swap in an order() list with explicit factor levels.
local keep_list "stky_* pr_ndx wg_ndx *#* bnkcrdit ntwrth wlth open learning cb_authors_ext ln_neq vint_* est_* _cons"

* Optional pretty labels (extend as needed)
local coflbl ///
    /* intercept & rules */ ///
    _cons                       "Constant" ///
    rule_g                      "Rule: Growth" ///
    rule_itr                    "Rule: Inert. Taylor" ///
    /* legacy sticky-price flavors (if present) */ ///
    stky_pr_calvo               "Sticky Prices (Calvo)" ///
    stky_pr_rotemberg           "Sticky Prices (Rotemberg)" ///
    stky_pr_other               "Sticky Prices (Other)" ///
    /* nominal rigids (main effects) */ ///
    stky_pr                     "Sticky Prices" ///
    stky_wg                     "Sticky Wages" ///
    pr_ndx                      "Price Idx" ///
    wg_ndx                      "Wage Idx." ///
    wg_ndx_prprice              "Wage Idx. (Prev. Price)" ///
    wg_ndx_mult                 "Wage Idx. (Mult. Price)" ///
    wg_ndx_other                "Wage Idx. (Other)" ///
    /* nomrig interactions: generic (your current i.var#i.var usage) */ ///
    1.stky_pr#1.pr_ndx          "Sticky Prices $\\times$ Price Idx." ///
    1.stky_wg#1.wg_ndx          "Sticky Wages $\\times$ Wage Idx." ///
    1.stky_pr#1.not_pr_ndx      "Sticky Prices $\\times$ Not Price Idx." ///
    1.stky_wg#1.not_wg_ndx      "Sticky Wages $\\times$ Not Wage Idx." ///
    1.stky_pr#1.wg_ndx          "Sticky Prices $\\times$ Wage Idx." ///
    1.stky_wg#1.pr_ndx          "Sticky Wages $\\times$ Price Idx." ///
    1.stky_pr#1.not_wg_ndx      "Sticky Prices $\\times$ Not Wage Idx." ///
    1.stky_wg#1.not_pr_ndx      "Sticky Wages $\\times$ Not Price Idx." ///
    /* nomrig interactions: legacy flavors (if you ever include these) */ ///
    1.stky_pr_calvo#1.pr_ndx        "Sticky Price (Calvo) $\\times$ Price Idx." ///
    1.stky_pr_rotemberg#1.pr_ndx    "Sticky Price (Rotemberg) $\\times$ Price Idx." ///
    1.stky_pr_other#1.pr_ndx        "Sticky Price (Other) $\\times$ Price Idx." ///
    1.stky_wg#1.wg_ndx_prprice      "Sticky Wages $\\times$ Wage Idx. (Prev. Price)" ///
    1.stky_wg#1.wg_ndx_mult         "Sticky Wages $\\times$ Wage Idx. (Mult. Price)" ///
    1.stky_wg#1.wg_ndx_other        "Sticky Wages $\\times$ Wage Idx. (Other)" ///
    /* real rigidities (main effects) */ ///
    wlth                        "Wealth Channel" ///
    ntwrth                      "Net Worth Channel" ///
    bnkcrdit                    "Bank Credit Channel" ///
    open                        "Open Economy" ///
    learning                    "Learning Channel" ///
    /* real rigidities interactions (as dummies; if continuous, switch to c.var#c.var) */ ///
    1.wlth#1.ntwrth             "Wealth $\\times$ Net Worth" ///
    1.wlth#1.bnkcrdit           "Wealth $\\times$ Bank Credit" ///
    1.wlth#1.open               "Wealth $\\times$ Open Economy" ///
    1.wlth#1.learning           "Wealth $\\times$ Learning" ///
    1.ntwrth#1.bnkcrdit         "Net Worth $\\times$ Bank Credit" ///
    1.ntwrth#1.open             "Net Worth $\\times$ Open Economy" ///
    1.ntwrth#1.learning         "Net Worth $\\times$ Learning" ///
    1.bnkcrdit#1.open           "Bank Credit $\\times$ Open Economy" ///
    1.bnkcrdit#1.learning       "Bank Credit $\\times$ Learning" ///
    1.open#1.learning           "Open Economy $\\times$ Learning" ///
    /* non-modeling vars (main effects) */ ///
    estimated                   "Estimated" ///
    est_early                   "Early Data" ///
    est_late                    "Late Data" ///
    vint_early                  "Early Vintage" ///
    vint_mid                    "Mid Vintage" ///
    vint_late                   "Late Vintage" ///
    cb_authors_ext              "Central Bank Author" ///
    ln_neq                      "$\\log(\\text{Num. of Eqs.})$" ///
    /* nonmod interactions (as dummies) */ ///
    1.cb_authors_ext#1.estimated        "Central Bank Author $\\times$ Estimated" ///
    1.cb_authors_ext#1.ln_neq           "Central Bank Author $\\times$ $\\log(\\text{Num. of Eqs.})$" ///
    1.cb_authors_ext#1.vint_early       "Central Bank Author $\\times$ Early Vintage" ///
    1.cb_authors_ext#1.vint_mid         "Central Bank Author $\\times$ Mid Vintage" ///
    1.cb_authors_ext#1.vint_late        "Central Bank Author $\\times$ Late Vintage" ///
    1.cb_authors_ext#1.est_early        "Central Bank Author $\\times$ Early Data" ///
    1.cb_authors_ext#1.est_late         "Central Bank Author $\\times$ Late Data" ///
    1.estimated#1.ln_neq                "Estimated $\\times$ $\\log(\\text{Num. of Eqs.})$" ///
    1.estimated#1.vint_early            "Estimated $\\times$ Early Vintage" ///
    1.estimated#1.vint_mid              "Estimated $\\times$ Mid Vintage" ///
    1.estimated#1.vint_late             "Estimated $\\times$ Late Vintage" ///
    1.estimated#1.est_early             "Estimated $\\times$ Early Data" ///
    1.estimated#1.est_late              "Estimated $\\times$ Late Data" ///
    1.ln_neq#1.vint_early               "$\\log(\\text{Num. of Eqs.})$ $\\times$ Early Vintage" ///
    1.ln_neq#1.vint_mid                 "$\\log(\\text{Num. of Eqs.})$ $\\times$ Mid Vintage" ///
    1.ln_neq#1.vint_late                "$\\log(\\text{Num. of Eqs.})$ $\\times$ Late Vintage" ///
    1.ln_neq#1.est_early                "$\\log(\\text{Num. of Eqs.})$ $\\times$ Early Data" ///
    1.ln_neq#1.est_late                 "$\\log(\\text{Num. of Eqs.})$ $\\times$ Late Data" ///
    1.vint_early#1.est_early            "Early Vintage $\\times$ Early Data" ///
    1.vint_early#1.est_late             "Early Vintage $\\times$ Late Data" ///
    1.vint_mid#1.est_early              "Mid Vintage $\\times$ Early Data" ///
    1.vint_mid#1.est_late               "Mid Vintage $\\times$ Late Data" ///
    1.vint_late#1.est_early             "Late Vintage $\\times$ Early Data" ///
    1.vint_late#1.est_late              "Late Vintage $\\times$ Late Data"
* -------- end replacement block --------

* Emit one LaTeX fragment per TYPE
local dep1 : word 1 of $depvars
local dep2 : word 2 of $depvars

local mtitles `" "`dep1'" "`dep2'" "'


foreach type in "nomrig" "realrig" "nonmod" "all" "nomrig_all" "realrig_all" "nonmod_all" "all_all" {
    eststo clear

    * run the already-stored final calls as columns
    ${reg_`dep1'_`type'}
    eststo `dep1'
    estadd scalar N = e(N), replace
    capture noisily estadd scalar r2 = e(r2_p), replace

    ${reg_`dep2'_`type'}
    eststo `dep2'
    estadd scalar N = e(N), replace
    capture noisily estadd scalar r2 = e(r2_p), replace
	
	esttab `dep1' `dep2' ///
		using "./output/stepwise_regressions/`type'_timing.txt", replace fragment booktabs ///
		b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
		mtitles(`mtitles') label nonotes alignment(c) ///
		coeflabels(`coflbl') ///
		stats(N r2, labels("Observations" "Pseudo \$R^2\$")) ///
		gaps ///
		interaction(" $\times$ ") ///
		refcat(, nolabel) ///
		nobaselevels noomitted nonotes
}
