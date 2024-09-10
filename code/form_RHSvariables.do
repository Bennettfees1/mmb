********************************************************************************
********			MMB Project				********
********Economists: Robert Tetlow (FRB) & William English (Yale)	********
********RAs: Connor Brennan (FRB) & Armin Daneshbodi (Yale)		********
********************************************************************************

********************************************************************************
* Code cleans model characteristic data from excel spreadsheet.
********************************************************************************
********************************************************************************
//	LOAD DATA, correct it when wrong, organize
********************************************************************************
import excel .${rawdata}/Model_Characteristics.xlsx, clear firstrow
rename *, lower


*fix calibrated
replace calibrated = 0 if inlist(model, "US_VMDno", "US_VMDop", "US_FGKR15","US_IAC05")
replace estimated = 1 if inlist(model, "US_IAC05", "US_FGKR15")
replace calibrated = 1 if inlist(model,"US_VMDno")


*Drop scratch space at end of sheet
gen t = _n
drop if t > 92	//for scratch space at end of sheet


*Only keep variables interest in
keep model date_pub cb_authors est_date_range_start est_date_range_end estimated calibrated price_indexation open net_worth_effect_non_households wealth_effect_channel_households bank_credit_channel tax gov_spend gov_debt sticky_price_method sticky_wages wage_indexation wage_index_method final_mmb_count learning



********************************************************************************
//	Publication and Estimation Dates
********************************************************************************
*Make date published into datetime quarterly
gen ndate_pub = qofd(date(date_pub, "MDY"))
format ndate_pub %tq
drop date_pub
ren ndate_pub pub_date


*Make estimate range start and end into datetime quarterly
gen n_est_date_range_start = quarterly(est_date_range_start, "YQ")
gen n_est_date_range_end = quarterly(est_date_range_end, "YQ")
format %tq n_est_date_range_start n_est_date_range_end
drop est_date_range_start est_date_range_end
ren n_est_date_range_start est_start
ren n_est_date_range_end est_end


*Dummies for early, middle, late vintage of publication and dat calibration
gen est_early = (year(dofq(est_start)) < 1980) if est_start!=.
replace est_early = 0 if est_early == . & est_start!=.
gen est_late = (year(dofq(est_start)) >= 1980) if est_start!=.
replace est_late = 0 if est_late == . & est_start!=.
gen vint_early = (year(dofq(pub_date)) < 2000) if pub_date!=.
gen vint_mid = (year(dofq(pub_date)) >= 2000 & year(dofq(pub_date)) <=2007) if pub_date!=.
gen vint_late = (year(dofq(pub_date)) > 2007) if pub_date!=.


*Make pub_date and est_start and est_end back into strings for Excel Sheet
generate pub_date_tmp = string(pub_date, "%tq")
generate est_start_tmp = string(est_start, "%tq")
generate est_end_tmp = string(est_end, "%tq")
drop pub_date est_start est_end
ren pub_date_tmp pub_date
ren est_start_tmp est_start
ren est_end_tmp est_end




********************************************************************************
//	Prices/Wages: Stickiness and indexation
********************************************************************************
*Make sticky price dummies
gen stky_pr_calvo = (inlist(sticky_price_method, "Calvo", "Calvo-like"))
gen stky_pr_rotemberg = (inlist(sticky_price_method, "Rotemberg"))
gen stky_pr_other = ((inlist(sticky_price_method, "Calvo", "Calvo-like", "Rotemberg", "NA"))-1)*(-1)
gen not_stky_pr = (inlist(sticky_price_method, "NA"))
gen stky_pr = (not_stky_pr==0)
drop sticky_price_method


*destring variables
destring price_indexation wage_indexation sticky_wages, replace
ren sticky_wages stky_wg
ren price_indexation pr_ndx
ren wage_indexation wg_ndx


*Wage indexation type dummies
gen wg_ndx_mult = (inlist(wage_index_method, "Multiple"))
gen wg_ndx_prprice = (inlist(wage_index_method, "Prev Price Inflation", "Prev Agg Inflation"))
gen wg_ndx_other = (inlist(wage_index_method, "Other", "Prev Wage Inflation", "Prev Wages", "Steady-State Inflation"))
drop wage_index_method


*Combinations
gen stky_pr_ndx = (stky_pr==1 & pr_ndx==1)
gen stky_pr_nondx = (stky_pr==1 & pr_ndx==0)
gen stky_wg_ndx = (stky_wg==1 & wg_ndx==1)
gen stky_wg_nondx = (stky_wg==1 & wg_ndx==0)
gen stky_all = (stky_pr==1 & stky_wg==1)
gen stky_pr_wg_ndx = (stky_pr==1 & wg_ndx==1)
gen ndx_all = (pr_ndx==1 & wg_ndx==1)


********************************************************************************
//	Misc.
********************************************************************************
*Dummy for monetary shock channel besides interest rates
gen other_channel = (net_worth_effect_non_households == "1" | wealth_effect_channel_households == "1" | bank_credit_channel == "1")
foreach var of varlist  net_worth_effect_non_households wealth_effect_channel_households bank_credit_channel{
	replace `var' = "0" if `var'=="No Mention"
}
destring net_worth_effect_non_households wealth_effect_channel_households bank_credit_channel, replace


*Fiscal sector dummy
gen fiscal = (tax == 1 | gov_debt == 1 | gov_spend == 1)


*Rename for numebr of equations
ren final_mmb_count neq
gen ln_neq = ln(neq)


*Rename channels
ren net_worth_effect_non_households ntwrth
ren wealth_effect_channel_households wlth
ren bank_credit_channel	bnkcrdit


*Whether a central bank author is on a paper
gen cb_authors_ext = (cb_authors!=0)


*Redefine calibrated/estimated given Bill's evaluation
replace estimated = 1 if model == "US_FGKR15" 
replace calibrated = 1 if model == "US_VMDno" 


********************************************************************************
//	Save
********************************************************************************
save .${cleandata}/rhs.dta, replace


