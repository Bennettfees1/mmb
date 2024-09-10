********************************************************************************
********			MMB Project				********
********Economists: Robert Tetlow (FRB) & William English (Yale)	********
********RAs: Connor Brennan (FRB) & Armin Daneshbodi (Yale)		********
********************************************************************************

********************************************************************************
* Code creates summary statistics by rules/type across outcome variables
********************************************************************************
use ./data/derived/MMB_reg_format.dta, clear

capture vl drop outcomevars timingvars
glo numbers = "one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty twentyone twentytwo twentythree twentyfour twentyfive twentysix twentyseven twentyeight twentynine thirty thirtyone thirtytwo thirtythree thirtyfour thirtyfive"
glo conditionals `" "if rule_t" "if rule_itr" "if rule_g" "'
glo timing_titles = `" "Maximum Quarterly Inflation" "Maximum Output" "Minimum Real Interest Rate" "Minimum Nominal Interest Rate" "'



glo resultsfile = "./output/summarystats/texresults_outcomevars_stats_output.txt"
capture ! rm -r "${resultsfile}"


********************************************************************************
* Table 1 -- general summaries
********************************************************************************
loc j = 1
foreach var of global outcomevars{
	glo colnum: word `j' of ${numbers}
	
	sum `var', detail
	loc mean = round(r(mean), 0.001)
	texresults using "${resultsfile}", texmacro("outcomeSumStatToneROWoneCOLUMN${colnum}") result(`mean') append unitzero

	sum `var', detail
	loc med = round(r(p50), 0.001)
	texresults using "${resultsfile}", texmacro("outcomeSumStatToneROWtwoCOLUMN${colnum}") result(`med') append unitzero

	sum `var', detail
	loc sd = round(r(sd), 0.001)
	texresults using "${resultsfile}", texmacro("outcomeSumStatToneROWthreeCOLUMN${colnum}") result(`sd') append unitzero

	sum `var', detail
	loc skew = round(r(skewness), 0.001)
	texresults using "${resultsfile}", texmacro("outcomeSumStatToneROWfourCOLUMN${colnum}") result(`skew') append unitzero

	sum `var', detail
	loc N = round(r(N), 0.001)
	texresults using "${resultsfile}", texmacro("outcomeSumStatToneROWfiveCOLUMN${colnum}") result(`N') append unitzero

	loc j = `j' + 1
}


loc j = 1
foreach var of global outcomevars{
	foreach conditional of global conditionals{
		glo colnum: word `j' of ${numbers}
		
		sum `var' `conditional', detail
		loc mean = round(r(mean), 0.001)
		texresults using "${resultsfile}", texmacro("outcomeSumStatTtwoROWoneCOLUMN${colnum}") result(`mean') append unitzero

		sum `var' `conditional', detail
		loc med = round(r(p50), 0.001)
		texresults using "${resultsfile}", texmacro("outcomeSumStatTtwoROWtwoCOLUMN${colnum}") result(`med') append unitzero

		sum `var' `conditional', detail
		loc sd = round(r(sd), 0.001)
		texresults using "${resultsfile}", texmacro("outcomeSumStatTtwoROWthreeCOLUMN${colnum}") result(`sd') append unitzero

		sum `var' `conditional', detail
		loc skew = round(r(skewness), 0.001)
		texresults using "${resultsfile}", texmacro("outcomeSumStatTtwoROWfourCOLUMN${colnum}") result(`skew') append unitzero

		sum `var' `conditional', detail
		loc N = round(r(N), 0.001)
		texresults using "${resultsfile}", texmacro("outcomeSumStatTtwoROWfiveCOLUMN${colnum}") result(`N') append unitzero

		loc j = `j' + 1
	}
}

/*
loc i = 1
foreach var of global outcomevars {
	glo varnum: word `i' of ${numbers}

	loc j = 1
	foreach conditional of global conditionals {  
		glo rownum: word `j' of ${numbers}
		if "conditional" == ""{
			glo tnum = 1
		}
		else{
			glo tnum = 2
		}
		sum `var' `conditional', detail

		sum `var' `conditional', detail
		loc mean = round(r(mean), 0.001)
		texresults using "${resultsfile}", texmacro("outcomeSumStatT${tnum}VAR${varnum}ROW${rownum}COLUMNone") result(`mean') append unitzero

		sum `var' `conditional', detail
		loc med = round(r(p50), 0.001)
		texresults using "${resultsfile}", texmacro("outcomeSumStatT${tnum}VAR${varnum}ROW${rownum}COLUMNtwo") result(`med') append unitzero

		sum `var' `conditional', detail
		loc sd = round(r(sd), 0.001)
		texresults using "${resultsfile}", texmacro("outcomeSumStatT${tnum}VAR${varnum}ROW${rownum}COLUMNthree") result(`sd') append unitzero

		sum `var' `conditional', detail
		loc skew = round(r(skewness), 0.001)
		texresults using "${resultsfile}", texmacro("outcomeSumStatT${tnum}VAR${varnum}ROW${rownum}COLUMNfour") result(`skew') append unitzero

		sum `var' `conditional', detail
		loc N = round(r(N), 0.001)
		texresults using "${resultsfile}", texmacro("outcomeSumStatT${tnum}VAR${varnum}ROW${rownum}COLUMNfive") result(`N') append unitzero
		
		if "conditional" != ""{
			loc j = `j'+1
		}
	}
	loc i = `i'+1
}



glo resultsfile = "./output/summarystats/texresults_timingvars_stats_output.txt"
capture ! rm -r "${resultsfile}"
loc i = 1
foreach var of global timingvars {
	glo varnum: word `i' of ${numbers}

	loc j = 1
	foreach conditional of global conditionals {  
		glo colnum: word `j' of ${numbers}
		di "`conditional'"
		sum `var' `conditional', detail
		
		sum `var' `conditional', detail
		loc mean = round(r(p10), 0.001)
		texresults using "${resultsfile}", texmacro("timingSumStatVAR${varnum}ROWoneCOLUMN${colnum}") result(`mean') append unitzero

		sum `var' `conditional', detail
		loc p25 = round(r(p25), 0.001)
		texresults using "${resultsfile}", texmacro("timingSumStatVAR${varnum}ROWtwoCOLUMN${colnum}") result(`p25') append unitzero

		sum `var' `conditional', detail
		loc p50 = round(r(p50), 0.001)
		texresults using "${resultsfile}", texmacro("timingSumStatVAR${varnum}ROWthreeCOLUMN${colnum}") result(`p50') append unitzero

		sum `var' `conditional', detail
		loc p75 = round(r(p75), 0.001)
		texresults using "${resultsfile}", texmacro("timingSumStatVAR${varnum}ROWfourCOLUMN${colnum}") result(`p75') append unitzero
		
		sum `var' `conditional', detail
		loc sd = round(r(sd), 0.001)
		texresults using "${resultsfile}", texmacro("timingSumStatVAR${varnum}ROWfiveCOLUMN${colnum}") result(`sd') append unitzero

		loc j = `j'+1
		}
	loc i = `i'+1
}
*/




********************************************************************************
* Make stacked bar chart for timing variables
********************************************************************************
global conditions = `"  "calibrated" "estimated" "'
loc i = 1
foreach var of global timingvars{
	loc x_axis_title: word `i' of $timing_titles
	twoway histogram `var' if `var' < ${time_limit}, freq discrete barw(1) color("30 144 255") lcolor(black) || ///
	histogram `var' if `var' < ${time_limit} & inlist(rule, "Taylor", "Growth"), freq discrete barw(1) color("255 0 255") lcolor(black) || ///
	histogram `var' if `var' < ${time_limit} & rule == "Growth", freq discrete barw(1) color("64 255 208") lcolor(black) ///
	legend(pos(6) rows(1) order(1 "Inertial Taylor Rule" 2 "Taylor Rule" 3 "Growth Rule")) xtitle("Period of `x_axis_title'") name(`var'_r_timing_hist, replace)
	graph export "./output/summarystats/`var'_rules_timing_hist.pdf", as(pdf) replace
	
	twoway histogram `var' if `var' < ${time_limit}, freq discrete barw(1) color(orange) lcolor(black) || ///
	histogram `var' if `var' < ${time_limit} & estimated, freq discrete barw(1) color(green) lcolor(black) ///
	legend(pos(6) rows(1) order(1 "Calibrated" 2 "Estimated" )) xtitle("Period of `x_axis_title'") name(`var'_t_timing_hist, replace)
	graph export "./output/summarystats/`var'_types_timing_hist.pdf", as(pdf) replace
	/*
	foreach condition of global conditions{
		twoway histogram `var' if `var' < ${time_limit} & `condition', freq discrete barw(1) color(midblue%70) lcolor(black) || ///
		histogram `var' if `var' < ${time_limit} & inlist(rule, "Taylor", "Growth") & `condition', freq discrete barw(1) color(magenta%70) lcolor(black) || ///
		histogram `var' if `var' < ${time_limit} & rule == "Growth" & `condition', freq discrete barw(1) color(lime%70) lcolor(black) ///
		legend(pos(6) rows(1) order(1 "Inertial Taylor Rule" 2 "Taylor Rule" 3 "Growth Rule")) xtitle("Period of `x_axis_title'") name(`var'_`condition', replace)
		graph export "./output/summarystats/`var'_`condition'_timing_hist.pdf", as(pdf) replace
	}
	*/
	
	loc i = `i'+1
}



