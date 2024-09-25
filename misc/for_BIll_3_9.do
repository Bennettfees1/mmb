use .${cleandata}MMB_reg_format.dta, clear
	
	sepscatter y_cum20 rrate_cum20 if y_cum20<20, separate(rule) addplot((lfit y_cum20 rrate_cum20 if rule_g==1 & y_cum20<20, lcolor("midblue") estopts(noconstant)) (lfit y_cum20 rrate_cum20 if rule_itr==1 & y_cum20<20, lcolor("cranberry") estopts(noconstant)) (lfit y_cum20 rrate_cum20 if rule_t==1 & y_cum20<20, lcolor("midgreen") estopts(noconstant))) legend(pos(6) cols(3)) title("IS Curve Slopes Differ by Policy Rules (Noconstant Term)") name(rules_slopes, replace) xtitle("Cumulative Real Rate (20 Periods)") ytitle("Cumulative Output (20 Periods)") note("Excluded NK_NS14 with growth rule as outlier (y_cum=40.2, rrate_cum = 11.15). Regressions ran without constant.")
	
	sepscatter y_cum20 rrate_cum20 if y_cum20<20, separate(rule) addplot((lfit y_cum20 rrate_cum20 if rule_g==1 & y_cum20<20, lcolor("midblue")) (lfit y_cum20 rrate_cum20 if rule_itr==1 & y_cum20<20, lcolor("cranberry")) (lfit y_cum20 rrate_cum20 if rule_t==1 & y_cum20<20, lcolor("midgreen"))) legend(pos(6) cols(3)) title("IS Curve Slopes Differ by Policy Rules (Constant Term)") name(rules_slopes_c, replace) xtitle("Cumulative Real Rate (20 Periods)") ytitle("Cumulative Output (20 Periods)") note("Excluded NK_NS14 with growth rule as outlier (y_cum=40.2, rrate_cum = 11.15). Regressions ran without constant.")
	
	//Bob's way
	encode rule, gen(e_rule)
	robreg m y_cum20 rrate_cum20 c.rrate_cum20#i.rule_t c.rrate_cum20#i.rule_itr c.rrate_cum20#i.rule_g, k(4.685) bis noconstant
	predict v, resid
	
	robreg m v [insert indepvar here], k(4.685) bis

	
	//Bill's way
	robreg m IScurve20 rule_g rule_t rule_itr, k(4.685) bis noconstant
	predict u, resid
	robreg m u [insert indepvar here], k(4.685) bis
