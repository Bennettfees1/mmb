********************************************************************************
********			MMB Project				********
********Economists: Robert Tetlow (FRB) & William English (Yale)	********
********RAs: Connor Brennan (FRB) & Armin Daneshbodi (Yale)		********
********************************************************************************

********************************************************************************
* This file loads in the CSVs gathered from using the MMB app and reformats the
* data as a panel dataset where periods are t and panels are model-rule pairings
* File also notes model "types" (Calibrated, Estimated, Other) and median and
* mean responses in each period of y, piq, iirate, and rrate for all models and
* for each model "type"
********************************************************************************
********************************************************************************
//	LOAD DATA
********************************************************************************
***Load data from the IRF csv's, bring files from csv's to dta's
fs ".${rawdata}responses/*.csv"
foreach f in `r(files)'{
	import delimited .${rawdata}responses/`f', clear varnames(1)
	loc i = 1
	foreach var of varlist v6-v105{
		rename `var' y`i'
		loc i = `i' + 1
	}
	loc change_name = rule[1]
	if "`change name'" == "User"{
		loc rule_name = subinstr(substr("`f'", strpos("`f'", "inertial"), strlen("`f'")), ".csv", "", 1)
		replace rule = `rule_name'
		replace rule = "Inertial Taylor" if rule == "inertial"
		replace rule = "Taylor" if rule == "taylor"
		replace rule = "Growth" if rule == "growth"
	}
	loc dta_name = subinstr("`f'", ".csv", ".dta", 1)
	save .${rawdata}responses/`dta_name', replace
}


***Append the files into one big file
fs ".${rawdata}responses/*.dta"
loc i = 1
foreach f in `r(files)' {
	if `i'==1{
		use .${rawdata}responses/`f', clear
		loc i = 2
	}
	else{
		append using .${rawdata}responses/`f'
	}
}


***reshape to long to can treat as panel time series data
reshape long y, i(model variable rule) j(period)
ren y response
egen id = group(model rule variable)
xtset id period


***organizing
gen model_type = substr(model, 1,2)
replace model_type = "NK" if model_type=="RB"	//RBC model is calibrated
replace model_type = "Other" if inlist(model_type, "G2", "G3", "G7")
replace model_type="Calibrated" if model_type=="NK"
replace model_type="Estimated" if model_type=="US"

replace variable = "Output_Gap" if variable=="Output Gap"	//for looping

replace rule = "Inertial_Taylor" if rule=="Inertial Taylor"

order model_type rule model variable period

drop shock resulttype

*Drop models that Bill considered duplicates
drop if inlist(model, "US_ACELswt", "US_CMR10fa", "US_CMR14noFA", "US_MI07", "US_PM08", "US_VI16bgg", "US_VMDop", "US_YR13", "NK_GK09lin")

*Drop models not using because authors said not to or calibrated for non-US
drop if inlist(model, "NK_CKL09","NK_GM05", "NK_GM16", "NK_GS14","NK_JO15_ht","NK_CGG99","US_IR15", "RBC_DTT11")

*flip signs on repsonses so that we are looking at responses to a negative monetary shock instead
replace response = (-1)*response

*make shock happen in period 1, not period 2. Drop period 0 where all is 0.
replace period = period -1
drop if period==0



********************************************************************************
//	Separate variables of responses
********************************************************************************
sort id period


*inflation, output gap, nominal interest at each period
bysort id (period): gen piq = response if variable=="inflationq"
bysort id (period): gen y = response if variable=="Output_Gap"
bysort id (period): gen irate = response if variable=="Interest"
bysort id (period): gen pi = response if variable=="Inflation"


*collapse to models with their responses by variable
collapse (mean) piq y irate pi (first) model_type, by(model rule period)
egen id = group(model rule), label
order id, first
sort id period


*Make Fischerian real rate variable
gen rrate = .
bysort id (period): replace rrate = irate - piq[_n+1]


drop if rule == "Model"


*Collapse
collapse (first) model rule (sum) piq y irate rrate pi, by(id period)
_strip_labels *


*Save IRF formatted data
save "./${cleandata}/MMB_IRF_format.dta", replace
outsheet using "./${cleandata}/MMB_IRF_format.csv", comma nolabel replace
