log using ./output/interaction_effects/yslope, replace
	robreg m IScurve20  cb_authors_ext##(rule_itr rule_g rule_tr ntwrth stky_wg wlth stky_pr)  , k(4.685) bis center updatescale
				display _n "{newpage}"
	robreg m IScurve20  calibrated##(rule_itr rule_g rule_tr ntwrth stky_wg wlth stky_pr)  , k(4.685) bis center updatescale
				display _n "{newpage}"
	robreg m IScurve20  vint_early##(rule_itr rule_g rule_tr ntwrth stky_wg wlth stky_pr) vint_mid##(rule_itr rule_g rule_tr ntwrth stky_wg wlth stky_pr)  , k(4.685) bis center updatescale
				display _n "{newpage}"
log close
translate ./output/interaction_effects/yslope.smcl ./output/interaction_effects/yslope.pdf, translator(smcl2pdf)
! rm ./output/interaction_effects/yslope.smcl



log using ./output/interaction_effects/pislope, replace
	capture robreg m infl_per_rr20  cb_authors_ext##(rule_itr rule_g rule_tr ntwrth stky_wg wlth stky_pr)  , k(4.685) bis center updatescale
				display _n "{newpage}"
	robreg m infl_per_rr20  calibrated##(rule_itr rule_g rule_tr ntwrth stky_wg wlth stky_pr)  , k(4.685) bis center updatescale
				display _n "{newpage}"
	robreg m infl_per_rr20  vint_early##(rule_itr rule_g rule_tr ntwrth stky_wg wlth stky_pr) vint_mid##(rule_itr rule_g rule_tr ntwrth stky_wg wlth stky_pr)  , k(4.685) bis center updatescale
				display _n "{newpage}"
log close
translate ./output/interaction_effects/pislope.smcl ./output/interaction_effects/pislope.pdf, translator(smcl2pdf)
! rm ./output/interaction_effects/pislope.smcl

				

log using ./output/interaction_effects/sacratio, replace
	robreg m sacratio20  cb_authors_ext##(rule_itr rule_g rule_tr ntwrth stky_wg wlth stky_pr)  , k(4.685) bis center updatescale
				display _n "{newpage}"
	robreg m sacratio20  calibrated##(rule_itr rule_g rule_tr ntwrth stky_wg wlth stky_pr)  , k(4.685) bis center updatescale
				display _n "{newpage}"
	robreg m sacratio20  vint_early##(rule_itr rule_g rule_tr ntwrth stky_wg wlth stky_pr) vint_mid##(rule_itr rule_g rule_tr ntwrth stky_wg wlth stky_pr)  , k(4.685) bis center updatescale
				display _n "{newpage}"
log close
translate ./output/interaction_effects/sacratio.smcl ./output/interaction_effects/sacratio.pdf, translator(smcl2pdf)
! rm ./output/interaction_effects/sacratio.smcl

				

log using ./output/interaction_effects/ytiming, replace
	nbreg y_timing_max   cb_authors_ext##(rule_g rule_itr rule_tr wg_ndx stky_pr learning wlth)  if y_timing_max<60 , vce(r)
				display _n "{newpage}"
	nbreg y_timing_max   calibrated##(rule_g rule_itr rule_tr wg_ndx stky_pr learning wlth)  if y_timing_max<60 , vce(r)
				display _n "{newpage}"
	nbreg y_timing_max   vint_early##(rule_g rule_itr rule_tr wg_ndx stky_pr learning wlth) vint_mid##(rule_g rule_itr rule_tr wg_ndx stky_pr learning wlth)  if y_timing_max<60 , vce(r)
				display _n "{newpage}"
log close
translate ./output/interaction_effects/ytiming.smcl ./output/interaction_effects/ytiming.pdf, translator(smcl2pdf)
! rm ./output/interaction_effects/ytiming.smcl


				
log using ./output/interaction_effects/piqtiming, replace	
	nbreg piq_timing_max   cb_authors_ext##(rule_g rule_itr rule_tr wg_ndx stky_pr learning wlth)  if y_timing_max<60 , vce(r)
				display _n "{newpage}"
	nbreg piq_timing_max   calibrated##(rule_g rule_itr rule_tr wg_ndx stky_pr learning wlth)  if y_timing_max<60 , vce(r)
				display _n "{newpage}"
	nbreg piq_timing_max   vint_early##(rule_g rule_itr rule_tr wg_ndx stky_pr learning wlth) vint_mid##(rule_g rule_itr rule_tr wg_ndx stky_pr learning wlth)  if y_timing_max<60 , vce(r)
				display _n "{newpage}"
log close
translate ./output/interaction_effects/piqtiming.smcl ./output/interaction_effects/piqtiming.pdf, translator(smcl2pdf)
! rm ./output/interaction_effects/piqtiming.smcl
