graph close
set graphics off
use .${cleandata}MMB_reg_format.dta, clear

global depvars = "IScurve infl_per_rr sacratio Billsacrat"

foreach var of varlist other_channel bnkcrdit ntwrth wlth stky_pr stky_pr_calvo stky_pr_rotemberg stky_pr_other {
	foreach depvar of global depvars{
		log using ./output/interactions_with_rules/`depvar'_`var', replace
		forvalues i=20(20)60{
			di "********************************************************************************"
			di "Interaction effects of `var' and rules on `depvar' at various horizons"
			di "********************************************************************************"
			robreg m `depvar'`i' i.`var'##(i.rule_g i.rule_itr), k(4.685) bis center updatescale
			display _n "{newpage}"
		}
		log close
		translate ./output/interactions_with_rules/`depvar'_`var'.smcl ./output/interactions_with_rules/`depvar'_`var'.pdf, translator(smcl2pdf) fontsize(8)
		! rm ./output/interactions_with_rules/`depvar'_`var'.smcl
	}
}

