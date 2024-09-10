********************************************************************************
********			MMB Project				********
********Economists: Robert Tetlow (FRB) & William English (Yale)	********
********RAs: Connor Brennan (FRB) & Armin Daneshbodi (Yale)		********
********************************************************************************

********************************************************************************
* Code combines datasets compiles in previous scripts
********************************************************************************
*Initialize with LHS data
loc i = 1
foreach horizon in $horizons {
	if `i'==1{
		use .${cleandata}lhs_`horizon'.dta, clear
		}
	else{
		merge 1:1 model rule using .${cleandata}lhs_`horizon'.dta
		capture drop _merge
	}
	loc i = `i'+1
}


*Merge in sacrifice ratios
foreach horizon in $horizons {
	merge 1:1 model rule using ".${cleandata}sacratios_`horizon'.dta"
	drop if _merge==2	//just models we ruled out
	capture drop _merge
}


*Merge in RHS data
merge m:1 model using ".${cleandata}rhs.dta"
capture drop _merge


*Drop models that Bill considered duplicates
drop if inlist(model, "US_ACELswt", "US_CMR10fa", "US_CMR14noFA", "US_MI07", "US_PM08", "US_VI16bgg", "US_VMDop", "US_YR13", "NK_GK09lin")

*Drop models not using because authors said not to or calibrated for non-US
drop if inlist(model, "NK_CKL09","NK_GM05", "NK_GM16", "NK_GS14","NK_JO15_ht","NK_CGG99","US_IR15", "RBC_DTT11")

drop id




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
label var stky_wg "Sticky Wages"
label var stky_wg_ndx "Sticky Wages & Index."
label var stky_pr_calvo "Calvo Pricing"
label var stky_pr_rotemberg "Rotemberg Pricing"



