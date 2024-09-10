********************************************************************************
********			MMB Project				********
********Economists: Robert Tetlow (FRB) & William English (Yale)	********
********RAs: Connor Brennan (FRB) & Armin Daneshbodi (Yale)		********
********************************************************************************

********************************************************************************
* Code computes cumulative minimum, and maximum values and timings of the
* minimum and maximum values over each model-rule pairings response variables.
* Also formats the data to be cross-sectional.
********************************************************************************
********************************************************************************
//	LOAD DATA
********************************************************************************
cd "/msu/scratch5/m1bdf00/Bob/mmb"
use "./data/derived/MMB_IRF_format.dta", clear

use "./${cleandata}/MMB_IRF_format.dta", clear



********************************************************************************
//	Changing Signs
********************************************************************************
*Get changed signs
bysort id (period): gen piq_chg_sign = (sign(piq[_n-1]) != sign(piq[_n])) if period > ${qforgive}
bysort id (period): gen y_chg_sign = (sign(y[_n-1]) != sign(y[_n])) if period > ${qforgive}
bysort id (period): gen irate_chg_sign = (sign(irate[_n-1]) != sign(irate[_n])) if period > ${qforgive}
bysort id (period): gen rrate_chg_sign = (sign(rrate[_n-1]) != sign(rrate[_n])) if period > ${qforgive}
bysort id (period): gen pi_chg_sign = (sign(pi[_n-1]) != sign(pi[_n])) if period > ${qforgive}


*How many changed signs, forgiving sign changes within 2 quarters after shock
gen piq_chg_sign_sum = 0
bysort id (period): replace piq_chg_sign_sum = piq_chg_sign_sum[_n-1] + piq_chg_sign[_n] if period >= ${qforgive}+2
gen y_chg_sign_sum = 0
bysort id (period): replace y_chg_sign_sum = y_chg_sign_sum[_n-1] + y_chg_sign[_n] if period >= ${qforgive}+2
gen irate_chg_sign_sum = 0
bysort id (period): replace irate_chg_sign_sum = irate_chg_sign_sum[_n-1] + irate_chg_sign[_n] if period >= ${qforgive}+2
gen rrate_chg_sign_sum = 0
bysort id (period): replace rrate_chg_sign_sum = rrate_chg_sign_sum[_n-1] + rrate_chg_sign[_n] if period >= ${qforgive}+2
gen pi_chg_sign_sum = 0
bysort id (period): replace pi_chg_sign_sum = pi_chg_sign_sum[_n-1] + pi_chg_sign[_n] if period >= ${qforgive}+2


*Flag model-rule pairings whose sums would be terminating for a sign moving 
*negative to positive rather than positive to negative as theory suggests
gen flag_piq_wrongsign = 1 if (piq<0 & period==${qforgive}+1)
gen flag_y_wrongsign = 1 if (y<0 & period==${qforgive}+1)
gen flag_pi_wrongsign = 1 if (pi<0 & period==${qforgive}+1)



********************************************************************************
//	Changing Signs
********************************************************************************
*Integral of response up to first sign change of variable responding
egen piq_cum${horizon} = sum(piq) if period<=$horizon & piq_chg_sign_sum<1, by(id)
egen y_cum${horizon} = sum(y) if period<=$horizon & y_chg_sign_sum<1, by(id)
egen irate_cum${horizon} = sum(irate) if period<=$horizon & irate_chg_sign_sum<1, by(id)
egen rrate_cum${horizon} = sum(irate) if period<=$horizon & rrate_chg_sign_sum<1, by(id)
egen pi_cum${horizon} = sum(pi) if period<=$horizon & pi_chg_sign_sum<1, by(id)



*Integral of response over integral of rrate over that same period
egen rrate_piq_cum = sum(rrate) if period<=${horizon} & piq_chg_sign_sum<1, by(id)
egen rrate_y_cum = sum(rrate) if period<=${horizon} & y_chg_sign_sum<1, by(id)
egen rrate_pi_cum = sum(rrate) if period<=${horizon} & pi_chg_sign_sum<1, by(id)

gen piq_over_rrate_cum${horizon} = piq_cum${horizon} / rrate_piq_cum
gen y_over_rrate_cum${horizon} = y_cum${horizon} / rrate_y_cum
gen pi_over_rrate_cum${horizon} = pi_cum${horizon} / rrate_pi_cum
drop rrate_piq_cum rrate_y_cum rrate_pi_cum



********************************************************************************
//	Initial Shocks
********************************************************************************
by id: gen irate_shock = irate if period==1
by id: gen rrate_shock = rrate if period==1



********************************************************************************
//	Periods and Values of Minimum and Maximum Responses
********************************************************************************
*Minimum and maximum responses of variables
foreach var in piq y irate rrate pi{
	by id: egen `var'_value_min = min(`var')
	by id: gen `var'_timing_min = period if `var' == `var'_value_min
	
	by id: egen `var'_value_max = max(`var')
	by id: gen `var'_timing_max = period if `var' == `var'_value_max
	
	by id: egen `var'_integral = sum(`var')
	
	by id: egen `var'_value_peak_tmp = max(abs(`var'))
	by id: gen `var'_value_peak = `var' if `var' == `var'_value_peak_tmp | `var' == -`var'_value_peak_tmp
	by id: gen `var'_timing_peak = period if abs(`var') == `var'_value_peak_tmp
	drop `var'_value_peak_tmp
}


foreach var in piq y irate rrate pi{
	di "`var'"
}


********************************************************************************
//	Collapse to model-rule cross-sectional
********************************************************************************
collapse (first) model rule (mean) *_value_* *_timing_* *_shock *_cum* *_integral (sum) *_chg_sign flag_*, by(id)



********************************************************************************
//	Three types of "peak" timing
********************************************************************************
//1. "Peak" defined above


//2. Sign restricted "peak"
foreach var in piq y irate rrate pi{
	gen `var'_timing_theorypeak = `var'_timing_max
	gen `var'_value_theorypeak = `var'_value_max
}


//3. Agnostically predicted "peak"
foreach var in piq y irate rrate pi{
	gen `var'_timing_agnpeak = `var'_timing_max if `var'_integral > 0
	replace `var'_timing_agnpeak = `var'_timing_min if `var'_integral < 0
	
	gen `var'_value_agnpeak = `var'_value_max if `var'_integral > 0
	replace `var'_value_agnpeak = `var'_value_min if `var'_integral < 0
	
	drop `var'_integral
}



********************************************************************************
//	Collapse to model-rule cross-sectional
********************************************************************************
gen IScurve${horizon} = y_cum${horizon} / rrate_cum${horizon}
gen infl_per_rr${horizon} = piq_cum${horizon}/rrate_cum${horizon}


********************************************************************************
//	Collapse to model-rule cross-sectional
********************************************************************************
gen Billsacrat${horizon} = piq_cum${horizon}/y_cum${horizon}



********************************************************************************
//	Monetary rule dummies
********************************************************************************
gen rule_tr = (rule=="Taylor")
gen rule_itr = (rule=="Inertial_Taylor")
gen rule_g = (rule=="Growth")
gen rule_m = (rule=="Model")

if ${drop_model_rule} == 1 {
	drop if rule_m == 1
	drop rule_m
}




********************************************************************************
//	Save
********************************************************************************
save ".${cleandata}/lhs_${horizon}.dta", replace
