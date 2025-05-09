********************************************************************************
********			MMB Project				********
********Economists: Robert Tetlow (FRB) & William English (Yale)	********
********RAs: Connor Brennan (FRB) & Armin Daneshbodi (Yale)		********
********************************************************************************

********************************************************************************
* To run this file, you must do the following:
*     1. Collect csv files for each model of interest under each of the rules
*		applicable to it, found in "mmb/models_into_mmb.xlsx." The rules
*		can be found in "mmb/user_defined_rules.png"
*     2. Set cd below to current project directory and extensions as appropriate
*     3. Make sure that file of model characteristcs is in project directory
*
*************************SUPER DUPER IMPORTANT*************************
*		AFTER RUNNING THIS SCRIPT RUN MMB_robreg.ipynb manually!!!!
***********************************************************************
********************************************************************************
clear all
macro drop _all

********************************************************************************
// Installs all necessary macros if not already installed
********************************************************************************
ssc install fs, replace
ssc install moremata, replace
ssc install robreg, replace
ssc install texresults, replace
ssc install coefplot, replace
* Add more if I've forgotten any here...



********************************************************************************
//	Filepaths
********************************************************************************
glo dir = "/Users/connorbrennan/OneDrive - The University of Chicago/mmb/"
***Filepath extensions
glo rawdata = "/data/raw/"
glo cleandata = "/data/derived/"
glo code = "/code"

cd "${dir}"



********************************************************************************
//	Macros to set
********************************************************************************
*how many quarters to forgive sign changes for
	glo qforgive = 4
	
*which horizons want over? Write as "horizon1 horizon2 horizon3,..."
	glo horizons  = "20 40 60"
	
*Drop observations made using model rule?
	glo drop_model_rule = 1
	
*piq or pi in sacrifice ratio? 1 for pi, 0 for piq
	glo pi_in_sacratio = 0
	
*How far out to limit time regressions for dependent variable?
	glo time_limit = 60
	
*Specify which variables are model variables and which are nonmodel variables
	glo nonmodelvars = "cb_authors_ext estimated calibrated ln_neq vint_early vint_mid vint_late est_early est_late"
	glo modelvars = "wlth ntwrth bnkcrdit other_channel learning open stky_pr stky_pr_calvo stky_pr_rotemberg stky_pr_other stky_wg wg_ndx pr_ndx"
	
*Which measure of r2 to use in graphs?
	glo r2measure_outcomes = "r2_w"
	glo r2measure_timing = "r2_p"
	
*List of "potential covariates" for stepwise robust regressions	(going to be similar to globals above but with rules and some alterations for estimated variables)
	//glo indepvars_nonmod_All "cb_authors_ext estimated calibrated ln_neq vint_early vint_mid vint_late rule_tr rule_g rule_itr"
	//glo indepvars_nonmod_Est "cb_authors_ext ln_neq vint_early vint_mid vint_late est_early est_late rule_tr rule_g rule_itr"

	//glo indepvars_mod_Oth "open other_channel stky_pr stky_wg pr_ndx wg_ndx rule_tr rule_g rule_itr"
	//glo indepvars_mod_All "open ntwrth bank wlth stky_pr stky_wg pr_ndx wg_ndx rule_tr rule_g rule_itr"
	
	glo indepvars_frics_det = "stky_pr_calvo stky_pr_rotemberg stky_pr_othern stky_wg pr_ndx wg_ndx wg_ndx_prprice wg_ndx_mult wg_ndx_other i.stky_pr_calvo#i.pr_ndx i.stky_pr_rotemberg#i.pr_ndx i.stky_pr_other#i.pr_ndx i.stky_wg#i.wg_ndx i.stky_wg#i.wg_ndx_prprice i.stky_wg#i.wg_ndx_mult i.stky_wg#i.wg_ndx_other bnkcrdit ntwrth wlth open other_channel"
					  
	glo indepvars_frics_sim = "stky_pr_calvo stky_pr_rotemberg stky_pr_othern stky_wg pr_ndx wg_ndx i.stky_pr_calvo#i.pr_ndx i.stky_pr_rotemberg#i.pr_ndx i.stky_pr_other#i.pr_ndx i.stky_wg#i.wg_ndx bnkcrdit ntwrth wlth open other_channel"
					  
	glo indepvars_properties = "estimated est_early est_late vint_mid vint_late cb_authors_ext ln_neq"
	
	glo indepvars_all_det = "${indepvars_frics_det} ${indepvars_properties}"
	
	glo indepvars_all_sim = "${indepvars_frics_sim} ${indepvars_properties}"


*Significances to enter/exit stepwise regression (alpha_enter is p-values below this enter, alpha_exit is p-values above this leave)
	global alpha_enter = 0.1
	global alpha_exit = 0.15

*What do we call outcome/timing vars?
	global outcomevars = "IScurve20 infl_per_rr20 sacratio20"
	global timingvars = "piq_timing_max y_timing_max rrate_timing_min irate_timing_min"
	
	
	

********************************************************************************
//	Data Construction
********************************************************************************
do .${code}/process_raw_mmb_data.do
do .${code}/form_RHSvariables.do
foreach horizon in $horizons {
	glo horizon = `horizon'
	do .${code}/form_LHSvariables.do 
	do .${code}/form_sacratios.do
}
do .${code}/combine.do

order model rule rule_* *value_min *value_max *timing_min *timing_max* *_cum* sacratio* flag_* *_chg_sign *_shock cb_authors cb_authors_ext estimated calibrated neq open ntwrth wlth bnkcrdit gov_spend gov_debt tax fiscal other_channel learning pr_ndx wg_ndx wg_ndx_mult wg_ndx_prprice wg_ndx_other stky_wg stky_pr stky_pr_other stky_pr_rotemberg stky_pr_calvo not_stky_pr stky_pr_ndx stky_wg_ndx vint_early vint_mid vint_late est_early est_late pub_date est_start est_end



********************************************************************************
//	Save Data
********************************************************************************
gsort -rule model 
save .${cleandata}MMB_reg_format.dta, replace
export excel * using .${cleandata}MMB_reg_format.xlsx, firstrow(variables) replace



********************************************************************************
//	Cloud Graphs and Summary Statistics
********************************************************************************
do .${code}/cloud_graphs.do
do .${code}/summary_stats.do



********************************************************************************
//	Bivariate Regression Coefficient Plots
********************************************************************************
do .${code}/regressions_outcomes_bivariate.do
do .${code}/regressions_timing_bivariate.do



********************************************************************************
//	Stepwise Regression to get suitable regressions
********************************************************************************
do .${code}/stepwise_regression.do








