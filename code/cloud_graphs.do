********************************************************************************
//	GET BOB's CEE VAR IRFs
********************************************************************************
import delimited .${rawdata}Bob_IRFS_63Q1_07Q4.csv, clear varnames(1)
gen model = "VAR, 1963:Q1-2007:Q4"
gen rule = "NA"
ren pi piq
ren rtb irate
gen period = _n - 1
order period model rule, first
gen rrate = .
replace rrate = irate - piq[_n+1]
foreach var of varlist irate piq y rrate{
	replace `var' = (-1)*`var'
}
tempfile a
save `a', replace



// set graphics off
// import delimited .${rawdata}stationaryvardata.csv, clear varnames(1)
// foreach var of varlist xgap_cbo-pigdp{
// 	replace `var' = "." if `var' == "NA"
// 	destring `var', replace
// }
// gen date_temp = date(_date_, "YMD")
// format date_temp %td
// gen qdate = qofd(date_temp)
// format qdate %tq
// tsset qdate
// gen ln_pcom = ln(pcom)
// gen d_ln_pcom = D.ln_pcom
//
// var xgap_cbo pigdp d_ln_pcom rff if inrange(qdate, quarterly("1965q1", "YQ"), quarterly("2007q4", "YQ")), lags(1/4)
// irf create Bob_order, step(40) set(VAR_results, replace) order(xgap_cbo pigdp d_ln_pcom rff)
// foreach var of varlist xgap_cbo pigdp d_ln_pcom rff{
// 	irf graph oirf, impulse(rff) response(`var') name(`var', replace)
// }
// graph combine xgap_cbo pigdp d_ln_pcom rff, name(VAR_irfs, replace)
// irf table irf, impulse(rff)
// use VAR_results.irf, clear
// keep if impulse == "rff"
// sort response step
// order response, first
// keep response step oirf
// reshape wide oirf, i(step) j(response, string)
// ren oirfrff irate
// ren oirfxgap_cbo y
// ren oirfpigdp piq
// ren step period
// scalar scale_up = 1/irate[1]
// foreach var of varlist irate y piq{
// 	replace `var' = `var' * scale_up
// }
// gen rrate = .
// replace rrate = irate - piq[_n+1]
// foreach var of varlist irate y piq rrate{
// 	replace `var' = (-1)*`var'
// }
// gen model = "VAR, 1965:Q1-2007:Q4"
// gen rule = "NA"
// tempfile a
// save `a', replace
// set graphics on



********************************************************************************
//	BRING DATA TOGETHER
********************************************************************************
graph close
use .${cleandata}MMB_IRF_format.dta, clear
drop if rule == "Model"
drop id
egen id = group(model rule)
order id, first
replace period = period-1
glo variables =  `" "piq" "y" "irate" "'  
xtset id period
loc title_size = "medsmall"
loc extent = 20
merge m:1 model using ".${cleandata}rhs.dta"
gen model_type_n = 1 if calibrated==1
replace model_type_n = 2 if estimated==1
replace model_type_n = 3 if calibrated==1 & estimated==1
gen model_type = "Calibrated" if calibrated
replace model_type = "Estimated" if estimated
replace model_type = "Both" if calibrated & estimated
sort model_type model period
loc calibrated_color 	= "orange%50"
loc estimated_color 	= "midgreen%35"
loc both_color 	= "purple%50"
loc VAR_color = "black"
loc SW_color = "blue"
loc baseline_size = 0.7
loc baseline_pattern = "dash"
loc median_color = "red"
loc ySpace = 0.25
sort model rule period

append using `a'
drop if period > `extent'


preserve
	keep if (model=="US_SW07" & rule == "Inertial_Taylor") | (model=="VAR, 1965:Q1 to 2007:Q4")
	foreach var in $variables {
		gen `var'_SW = `var' if model=="US_SW07"
		gen `var'_VAR = `var' if model=="VAR, 1963:Q1 to 2007:Q4"
	}
	collapse (mean) *_SW *_VAR, by(period)
	tempfile b
	save `b', replace
restore


sort model rule period

save .${cleandata}MMB_IRF_format_full.dta, replace


* Screw trying to get Stata to cooperate. Just use Python
! python3 ./code/cloud_graphs.py



/*
********************************************************************************
//	VERY ANNOYING FUNCTION TO ALLOW LINES TO GO OUT OF CHARTS BOUNDS
********************************************************************************
capture program drop adjust_for_bounds
program define adjust_for_bounds
	args var lb ub
	
	*for debugging this function
	//loc var y
	//loc ub = 1.75
	//loc lb = -0.25
	
	capture drop flag*
	gen flag_ub = (`var'>`ub')
	gen flag_lb = (`var'<`lb')

	gen plot_`var' = `var'
	
	sum id
	loc n_models = r(max)
	
	loc num_obs = _N
	
	forvalues m=1/`n_models' {
		loc next_good_value 
		loc last_good_value
		loc slope
		loc gap
		loc step
		
		sum `var' if id == `m'
		loc worst_case_ub = r(max)
		loc worst_case_lb = r(min)
		
		if `worst_case_ub' > `ub'{
			forvalues i=1/`num_obs' {
				if flag_ub[`i']==1 & id[`i']==`m' {					
					loc offending_value = `var'[`i']
					
					loc period = period[`i']
					
					if `period'==0{
						if `var'[`i'+1] <= `ub' & id[`i']==`m' {
							loc next_good_value = `var'[`i'+1]
						}
						
						
						if !missing(`"`next_good_value'"'){
							loc gap = `offending_value' - `ub'
							loc slope = (`offending_value' - `next_good_value')
							loc step = `gap'/`slope'
							insobs 1
							loc num_obs = `num_obs'+1
							replace period = `period' + `step' if _n==_N
							replace plot_`var' = `ub' if _n==_N
							replace model = model[`i'] if _n==_N
							replace rule = rule[`i'] if _n==_N
							replace model_type = model_type[`i'] if _n==_N
						}
					}
					else{
						
						forvalues k=`i'/`num_obs' {
							if `var'[`k']<`ub'& id[`k']==`m' {
								loc next_good_value = `var'[`k']
								loc next_good_indx = `k'
								continue, break
							}
						}
						
						forvalues k=`i'(-1)1 {
							if `var'[`k']<`ub' & id[`k']==`m' {
								loc last_good_value = `var'[`k']
								loc last_good_indx = `k'
								continue, break
							}
						}
						
						if `var'[`i'-1] < `ub' {
							loc gap = `var'[`last_good_indx'+1] - `ub'
							loc slope = (`var'[`last_good_indx'+1] - `last_good_value')
							loc step = `gap'/`slope'
							insobs 1
							loc i = `i'-1
							loc num_obs = `num_obs'+1
							loc new_period = `period' - `step'
							if `new_period' < `period'{
								replace period = `period' + `step' if _n==_N
								replace plot_`var' = `ub' if _n==_N
								replace model = model[`i'] if _n==_N
								replace rule = rule[`i'] if _n==_N
								replace model_type = model_type[`i'] if _n==_N
							}
							loc i = `i'+1
						}
						
						if `var'[`i'+1] < `ub' {
							loc gap = `var'[`next_good_indx'-1] - `ub'
							loc slope = (`var'[`next_good_indx'-1] - `next_good_value')
							loc step = `gap'/`slope'
							insobs 1
							loc num_obs = `num_obs'+1
							loc new_period = `period' + `step'
							if `new_period' > `period'{
								replace period = `period' + `step' if _n==_N
								replace plot_`var' = `ub' if _n==_N
								replace model = model[`i'] if _n==_N
								replace rule = rule[`i'] if _n==_N 
								replace model_type = model_type[`i'] if _n==_N
							}
						}
						
					}
				}
			}
		}
		
		
		
		if `worst_case_lb' < `lb'{
			forvalues i=1/`num_obs' {
				if flag_lb[`i']==1 & id[`i']==`m' {					
					loc offending_value = `var'[`i']
							
					loc period = period[`i']
					
					if `period'==0{
						if `var'[`i'+1] >= `lb' & id[`i']==`m' {
							loc next_good_value = `var'[`i'+1]
						}
						
						
						if !missing(`"`next_good_value'"'){
							loc gap = `lb' - `offending_value'
							loc slope = (`offending_value' - `next_good_value')
							loc step = `gap'/`slope'
							insobs 1
							loc num_obs = `num_obs'+1
							replace period = `period' - `step' if _n==_N
							replace plot_`var' = `lb' if _n==_N
							replace model = model[`i'] if _n==_N
							replace rule = rule[`i'] if _n==_N
							replace model_type = model_type[`i'] if _n==_N
						}
					}
					else{
						
						forvalues k=`i'/`num_obs' {
							if `var'[`k']>`lb'& id[`k']==`m' {
								loc next_good_value = `var'[`k']
								loc next_good_indx = `k'
								continue, break
							}
						}
						
						forvalues k=`i'(-1)1 {
							if `var'[`k']>`lb' & id[`k']==`m' {
								loc last_good_value = `var'[`k']
								loc last_good_indx = `k'
								continue, break
							}
						}
						
						if `var'[`i'-1] > `lb' {
							loc gap = `lb' - `var'[`last_good_indx'+1]
							loc slope = (`var'[`last_good_indx'+1] - `last_good_value')
							loc step = `gap'/`slope'
							insobs 1
							loc i = `i'-1
							loc num_obs = `num_obs'+1
							loc new_period = `period' + `step'
							if `new_period' < `period'{
								replace period = `period' + `step' if _n==_N
								replace plot_`var' = `lb' if _n==_N
								replace model = model[`i'] if _n==_N
								replace rule = rule[`i'] if _n==_N
								replace model_type = model_type[`i'] if _n==_N
							}
							loc i = `i'+1
						}
						
						if `var'[`i'+1] > `lb' {
							loc gap = `lb' - `var'[`next_good_indx'-1]
							loc slope = (`var'[`next_good_indx'-1] - `next_good_value')
							loc step = `gap'/`slope'
							insobs 1
							loc num_obs = `num_obs'+1
							loc new_period = `period' - `step'
							di `new_period'
							di `period'
							if `new_period' > `period'{
								replace period = `period' - `step' if _n==_N
								replace plot_`var' = `lb' if _n==_N
								replace model = model[`i'] if _n==_N
								replace rule = rule[`i'] if _n==_N 
								replace model_type = model_type[`i'] if _n==_N
							}
						}
						
					}
				}
			}
		}
		
	}
	replace plot_`var'=. if flag_ub==1 | flag_lb==1
	
	sort model rule period
end


sum id
loc max = r(max)
gen rand_sort = .
forvalues k=1/`max'{
	loc new_id = runiform()
	replace rand_sort = `new_id' if id == `k'
}
sort rand_sort period




********************************************************************************
*** Chart All Model-Rule Pairs
********************************************************************************
//set graphics off
foreach var in $variables{
	preserve	
	
	if "`var'" == "piq"{
		loc title = "Quarterly Inflation"
		loc varformal = "quarterly inflation"
		loc yUB = 1
		loc yLB = -0.25
	}
	if "`var'" == "y"{
		loc title = "Output"
		loc varformal = "output"
		loc yUB = 1.75
		loc yLB = -0.25
	}
	if "`var'" == "irate"{
		loc title = "Nominal Interest Rate"
		loc varformal = "the nominal interest rate"
		loc yUB = 1
		loc yLB = -1
	}
	
	adjust_for_bounds `var' `yLB' `yUB'
	
	*make median for whole variable
	tempfile c
	save `c', replace
		bysort period: egen med_`var' = median(`var')
		collapse (mean) med_`var', by(period)
		keep if mod(period,1)==0
		gen model = "Median"
		tempfile d
		save `d', replace
	use `c', clear
	append using `d'
	
	sort model rule period
	
	glo plotopts
	egen groups = group(rule model_type model)
	quietly sum groups
	loc max = r(max)
	loc max_plus_one = `max' + 1
	loc max_plus_two = `max' + 2
	loc max_plus_three = `max' + 3

	forvalues p = 1/`max'{
		quietly sum model_type_n if groups == `p'
		loc type = r(max)
		if `type' == 1{
			loc color = "`calibrated_color'"
		}
		if `type' == 2{
			loc color = "`estimated_color'"
		}
		if `type' == 3{
			loc color = "`both_color'"
		}
		if `p'<`max'{
			glo plotopts = "${plotopts} line plot_`var' period if period<=`extent' & group==`p', cmissing(n) lc(`color') ||" //"`plotopts' plot`p'(lc(`color'%30))"
		}
		else{
			glo plotopts = "${plotopts} line plot_`var' period if period<=`extent' & group==`p', cmissing(n) lc(`color') ||" //"`plotopts' plot`p'(lc(`color'%30))"
		}
	}
	glo plotopts = `" ${plotopts} line plot_`var' period if period<=`extent' & model=="US_SW07" & rule == "Inertial_Taylor", lc(`SW_color') lw(`baseline_size') lp(`baseline_pattern') || line plot_`var' period if period<=`extent' & model=="VAR, 1965:Q1 to 2007:Q4", lc(`VAR_color') lw(`baseline_size') lp(`baseline_pattern') || line med_`var' period if model == "Median", lc(`median_color') lw(`baseline_size') lp(`baseline_pattern') "'  
	
	serset clear
	twoway ${plotopts}, name(`var', replace) xtitle("Period") ytitle("`title'") title("`title' after a 100bps Monetary Shock", size(`title_size')) xlabel(0 4 8 12, nogrid) yscale(range(`yLB' `yUB')) plotregion(margin(zero)) ylabel(`yLB'(`ySpace')`yUB', nogrid) legend(pos(6) order(`max_plus_one' `max_plus_two' `max_plus_three') label(`max_plus_one' "SW07, Inertial Taylor Rule") label(`max_plus_two' "VAR, 1965:Q1 - 2007:Q1") label(`max_plus_three' "Median by Period") rows(1))  note("Each line represents the IRF of `varformal' in a given macro model in the MMB." "Orange lines signify calibrated models and green lines signify estimated models.")
	graph export ./output/cloud_graphs/`var'.png, as(png) replace
	drop groups
	
	
	foreach class in Estimated Calibrated{
		glo plotopts
		egen groups = group(model_type model rule) if model_type == "`class'"
		quietly sum groups
		loc max = r(max)
		loc max_plus_one = `max' + 1
		loc max_plus_two = `max' + 2
		loc max_plus_three = `max' + 3
		
		*make median for conditioned variable
		tempfile c
		save `c', replace
			loc class_shorted = substr("`class'", 1, 3)
			bysort period: egen med_`var'_`class_shorted' = median(`var') if model_type == "`class'"
			collapse (mean) med_`var'_`class_shorted', by(period)
			keep if mod(period,1)==0
			gen model = "Median `class'"
			tempfile d
			save `d', replace
		use `c', clear
		append using `d'

		forvalues p = 1/`max'{
			quietly sum model_type_n if groups == `p'
			loc type = r(max)
			if `type' == 1{
				loc color = "`calibrated_color'"
			}
			if `type' == 2{
				loc color = "`estimated_color'"
			}
			if `type' == 3{
				loc color = "`both_color'"
			}
			if `p'<`max'{
				glo plotopts = "${plotopts} line plot_`var' period if period<=`extent' & group==`p', cmissing(n) lc(`color') ||"
			}
			else{
				glo plotopts = "${plotopts} line plot_`var' period if period<=`extent' & group==`p', cmissing(n) lc(`color') ||"
			}
		}
		glo plotopts = `" ${plotopts} line plot_`var' period if period<=`extent' & model=="US_SW07" & rule == "Inertial_Taylor", cmissing(n)  lc(`SW_color') lw(`baseline_size') lp(`baseline_pattern') || line plot_`var' period if period<=`extent' & model=="VAR, 1965:Q1 to 2007:Q4", lc(`VAR_color') lw(`baseline_size') lp(`baseline_pattern') || line med_`var'_`class_shorted' period if model == "Median `class'", lc(`median_color') lw(`baseline_size') lp(`baseline_pattern') "'  
		serset clear
		twoway ${plotopts}, name(`var'_`class', replace) xtitle("Period") ytitle("`title'") title("`title' after a 100bps Monetary Shock, `class' Models", size(`title_size')) xlabel(0 4 8 12, nogrid) yscale(range(`yLB' `yUB')) plotregion(margin(zero)) ylabel(`yLB'(`ySpace')`yUB', nogrid) legend(pos(6) order(`max_plus_one' `max_plus_two' `max_plus_three') label(`max_plus_one' "SW07, Inertial Taylor Rule") label(`max_plus_two' "VAR, 1965:Q1 - 2007:Q1") label(`max_plus_three' "Median by Period") rows(1)) note("Each line represents the IRF of `varformal' in a given macro model in the MMB." "Orange lines signify calibrated models and green lines signify estimated models.")
		graph export ./output/cloud_graphs/`var'_`class'.png, as(png) replace
		drop groups
	}

	
	foreach rule in Growth Inertial_Taylor Taylor{
		if "`rule'" == "Inertial_Taylor"{
			loc rule_written = "Inertial Taylor"
			loc rule_f = "IT"
		}
		else{
			loc rule_written = "`rule'"
		}
		if "`rule'" == "Taylor"{
			loc rule_f = "T"
		}
		if "`rule'" == "Growth"{
			loc rule_f = "G"
		}
		if "`rule'" == "Model"{
			loc rule_f = "M"
		}
		
		glo plotopts
		egen groups = group(model_type model rule) if rule == "`rule'"
		quietly sum groups
		loc max = r(max)
		loc max_plus_one = `max' + 1
		loc max_plus_two = `max' + 2
		loc max_plus_three = `max' + 3
		
		*make median for conditioned variable
		tempfile c
		save `c', replace
			bysort period: egen med_`var'_`rule' = median(`var') if rule == "`rule'"
			collapse (mean) med_`var'_`rule', by(period)
			keep if mod(period,1)==0
			gen model = "Median `rule'"
			tempfile d
			save `d', replace
		use `c', clear
		append using `d'
		
		forvalues p = 1/`max'{
			quietly sum model_type_n if groups == `p'
			loc type = r(max)
			if `type' == 1{
				loc color = "`calibrated_color'"
			}
			if `type' == 2{
				loc color = "`estimated_color'"
			}
			if `type' == 3{
				loc color = "`both_color'"
			}
			if `p'<`max'{
				glo plotopts = "${plotopts} line plot_`var' period if period<=`extent' & group==`p', cmissing(n) lc(`color') ||"
			}
			else{
				glo plotopts = "${plotopts} line plot_`var' period if period<=`extent' & group==`p', cmissing(n) lc(`color') ||"
			}
		}
		glo plotopts = `" ${plotopts} line plot_`var' period if period<=`extent' & model=="US_SW07" & rule == "`rule'", cmissing(n) lc(`SW_color') lw(`baseline_size') lp(`baseline_pattern') || line plot_`var' period if period<=`extent' & model=="VAR, 1965:Q1 to 2007:Q4", lc(`VAR_color') lw(`baseline_size') lp(`baseline_pattern') || line med_`var'_`rule' period if model == "Median `rule'", lc(`median_color') lw(`baseline_size') lp(`baseline_pattern') "'  
		serset clear
		twoway ${plotopts}, name(`var'_`rule_f', replace) xtitle("Period") ytitle("`title'") title("`title' after a 100bps Monetary Shock, `rule_written' Rule", size(`title_size')) xlabel(0 4 8 12, nogrid) yscale(range(`yLB' `yUB')) plotregion(margin(zero)) ylabel(`yLB'(`ySpace')`yUB', nogrid) legend(pos(6) order(`max_plus_one' `max_plus_two' `max_plus_three') label(`max_plus_one' "SW07, Inertial Taylor Rule") label(`max_plus_two' "VAR, 1965:Q1 - 2007:Q1") label(`max_plus_three' "Median by Period") rows(1))  note("Each line represents the IRF of `varformal' in a given macro model in the MMB." "Orange lines signify calibrated models and green lines signify estimated models.")
		graph export ./output/cloud_graphs/`var'_`rule'.png, as(png) replace
		drop groups
	}	
	
	
	foreach class in Estimated Calibrated{
		foreach rule in Growth Inertial_Taylor Taylor{
			if "`rule'" == "Inertial_Taylor"{
				loc rule_written = "Inertial Taylor"
				loc rule_f = "IT"
			}
			else{
				loc rule_written = "`rule'"
			}
			if "`rule'" == "Taylor"{
				loc rule_f = "T"
			}
			if "`rule'" == "Growth"{
				loc rule_f = "G"
			}
			if "`rule'" == "Model"{
				loc rule_f = "M"
			}
			
			glo plotopts
			egen groups = group(model_type model rule) if model_type == "`class'" & rule == "`rule'"
			quietly sum groups
			loc max = r(max)
			loc max_plus_one = `max' + 1
			loc max_plus_two = `max' + 2
			loc max_plus_three = `max' + 3
		
			*make median for conditioned variable
			tempfile c
			save `c', replace
				loc class_shorted = substr("`class'", 1, 3)
				bysort period: egen med_`var'_`class_shorted'_`rule' = median(`var') if model_type == "`class'" & rule == "`rule'"
				collapse (mean) med_`var'_`class_shorted'_`rule', by(period)
				keep if mod(period,1)==0
				gen model = "Median `class' `rule'"
				tempfile d
				save `d', replace
			use `c', clear
			append using `d'
		
			forvalues p = 1/`max'{
				quietly sum model_type_n if groups == `p'
				loc type = r(max)
				if `type' == 1{
					loc color = "`calibrated_color'"
				}
				if `type' == 2{
					loc color = "`estimated_color'"
				}
				if `type' == 3{
					loc color = "`both_color'"
				}
				if `p'<`max'{
					glo plotopts = "${plotopts} line plot_`var' period if period<=`extent' & group==`p', cmissing(n) lc(`color') ||"
				}
				else{
					glo plotopts = "${plotopts} line plot_`var' period if period<=`extent' & group==`p', cmissing(n) lc(`color') ||"
				}
			}
			glo plotopts = `" ${plotopts} line plot_`var' period if period<=`extent' & model=="US_SW07" & rule == "`rule'", cmissing(n) lc(`SW_color') lw(`baseline_size') lp(`baseline_pattern') || line plot_`var' period if period<=`extent' & model=="VAR, 1965:Q1 to 2007:Q4", lc(`VAR_color') lw(`baseline_size') lp(`baseline_pattern') || line med_`var'_`class_shorted'_`rule' period if model == "Median `class' `rule'", lc(`median_color') lw(`baseline_size') lp(`baseline_pattern') "'  
			serset clear
			twoway ${plotopts}, name(`var'_`class'_`rule_f', replace) xtitle("Period") ytitle("`title'") title("`title' after a 100bps Monetary Shock, `class' Models under `rule_written' Rule", size(`title_size')) xlabel(0 4 8 12, nogrid) yscale(range(`yLB' `yUB')) plotregion(margin(zero)) ylabel(`yLB'(`ySpace')`yUB', nogrid) legend(pos(6) order(`max_plus_one' `max_plus_two' `max_plus_three') label(`max_plus_one' "SW07, Inertial Taylor Rule") label(`max_plus_two' "VAR, 1965:Q1 - 2007:Q1") label(`max_plus_three' "Median by Period") rows(1))  note("Each line represents the IRF of `varformal' in a given macro model in the MMB." "Orange lines signify calibrated models and green lines signify estimated models.")
			graph export ./output/cloud_graphs/`var'_`class'_`rule'.png, as(png) replace
			drop groups
		}
	}
	
	restore
}
set graphics on







********************************************************************************
*** All Medians
********************************************************************************
*Get median of response va riables in each period
foreach var in piq y irate rrate pi {
	bysort period: egen med_`var' = median(`var')
	foreach type in Estimated Calibrated {
		loc type_substr = substr("`type'", 1, 3)
		bysort period: egen med_`var'_`type_substr' = median(`var') if model_type=="`type'"
		
		foreach rule in Growth Inertial_Taylor Taylor{
			if "`rule'" == "Inertial_Taylor"{
				loc rule_f = "IT"
			}
			if "`rule'" == "Taylor"{
				loc rule_f = "T"
			}
			if "`rule'" == "Growth"{
				loc rule_f = "G"
			}
			if "`rule'" == "Model"{
				loc rule_f = "M"
			}
			
			bysort period: egen med_`var'_`type_substr'_`rule_f' = median(`var') if rule=="`rule'" & model_type=="`type'"
		}
	}
	
	foreach rule in Growth Inertial_Taylor Taylor{
		if "`rule'" == "Inertial_Taylor"{
			loc rule_f = "IT"
		}
		if "`rule'" == "Taylor"{
			loc rule_f = "T"
		}
		if "`rule'" == "Growth"{
			loc rule_f = "G"
		}
		if "`rule'" == "Model"{
			loc rule_f = "M"
		}
		
		bysort period: egen med_`var'_`rule_f' = median(`var') if rule=="`rule'"
	}
}
sort id period

collapse (mean) med_*, by(period)

merge 1:1 period using `b'

gen filler = .

foreach var in $variables{	
	loc ySpace = 0.25
	
	
	if "`var'" == "piq"{
		loc title = "Quarterly Inflation "
		loc varformal = "quarterly inflation"
		loc yUB = 0.5
		loc yLB = -0.25
	}
	if "`var'" == "y"{
		loc title = "Output"
		loc varformal = "output"
		loc yUB = 0.5
		loc yLB = 0
	}
	if "`var'" == "irate"{
		loc title = "Nominal Interest Rate"
		loc varformal = "the nominal interest rate"
		loc yUB = 0.25
		loc yLB = -1
	}

	twoway (line med_`var'_Est period, lc(`estimated_color')) (line med_`var'_Cal period, lc(`calibrated_color')) (line med_`var'_T period, lc(blue%50)) (line med_`var'_G period, lc(magenta%50)) (line med_`var'_IT period, lc(gold%50)) (line med_`var' period, lc(red) lw(`baseline_size')) (line `var'_SW period, lc(`SW_color') lp(`baseline_pattern') lw(`baseline_size')) (line `var'_VAR period, lc(`VAR_color') lp(dash) lw(`baseline_size') ), legend(pos(6) rows(3) cols(3) order(6 "Median" 1 "Median, Estimated" 2 "Median, Calibrated" 3 "Median, Taylor Rule" 4 "Median, Growth Rule" 5 "Median, Inertial Taylor Rule" 7 "US_SW07, Inertial Taylor Rule" 9 "" 8 "VAR, 1965:Q1 to 2007:Q1")) name(medians_`var', replace) xtitle("Period") ytitle("`title'") title("`title' after a 100bps Monetary Shock, `rule_written' Rule", size(`title_size')) xlabel(0 4 8 12, nogrid) yscale(range(`yLB' `yUB')) plotregion(margin(zero)) ylabel(`yLB'(`ySpace')`yUB', nogrid) xsize(*1.1)
	graph export ./output/cloud_graphs/medians_`var'.png, as(png) replace
}
