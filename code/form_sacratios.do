********************************************************************************
********			MMB Project				********
********Economists: Robert Tetlow (FRB) & William English (Yale)	********
********RAs: Connor Brennan (FRB) & Armin Daneshbodi (Yale)		********
********************************************************************************

********************************************************************************
* Code computes each model's sacrifice ratio. Switches for whether to use pi or
* piq in the numerator are found in master.do
********************************************************************************
********************************************************************************
//	LOAD DATA FROM THE IRF CSV'S FOR THE MODELS WITH AN INFLATION SHOCK
********************************************************************************
*Bring files from csv's to dta's
fs ".${rawdata}sacratios/csv/"
foreach f in `r(files)'{
	//loc f = "G_inertial.csv"	//for debugging
	import delimited .${rawdata}sacratios/csv/`f', clear varnames(1)
	loc i = 1
	glo interim = ${horizon} + 6
	glo extent = "v${interim}"
	foreach var of varlist v6-$extent {
		rename `var' h`i'
		loc i = `i' + 1
	}
	ren variable _variable
	drop v*
	ren _variable variable
	loc change_name = rule[1]
	loc dta_name = subinstr("`f'", ".csv", ".dta", 1)
	save .${rawdata}sacratios/dta/`dta_name', replace
}


*Append the files into one big file
fs ".${rawdata}sacratios/dta/"
loc i = 1
foreach f in `r(files)' {
	if `i'==1{
		use .${rawdata}sacratios/dta/`f', clear
		loc i = 2
	}
	else{
		append using .${rawdata}sacratios/dta//`f'
	}
}


*Drop models we agreed to drop
drop if inlist(model, "NK_CKL09","NK_GM05","NK_GS14","NK_JO15_ht","NK_CGG99","US_IR15")


*Label monetary rules
replace rule = "Inertial_Taylor" if rule == "inertial"
replace rule = "Taylor" if rule == "taylor"
replace rule = "Growth" if rule == "growth"
replace rule = "Model" if rule == "model"
if ${drop_model_rule} == 1 {
	drop if rule == "Model"
}


*Reshape to long so can treat as panel time series data
reshape long h, i(model variable rule) j(period)
ren h response
egen id = group(model rule variable)
xtset id period


*Make shock occur in period 1, drop all 0's first period
replace period = period-1
drop if period==0


*Organizing
gen model_type = substr(model, 1,2)
replace model_type = "NK" if model_type=="RB"	//RBC model is calibrated
replace model_type = "Other" if inlist(model_type, "G2", "G3", "G7")
replace model_type="Calibrated" if model_type=="NK"
replace model_type="Estimated" if model_type=="US"
		
replace variable = "ygap" if variable=="Output Gap"
replace variable = "pi" if variable=="Inflation"
replace variable = "piq" if variable=="inflationq"


sort id period
gen pi = response if variable=="pi"
gen piq = response if variable=="piq"
by id: gen y_cum = sum(response) if variable=="ygap"


if ${drop_model_rule} == 1 {
	drop if rule=="Model" == 1
}



********************************************************************************
//	Make data into panels, only keep period interested in (horizon)
********************************************************************************
collapse (sum) y_cum pi piq, by(model rule period)

keep if period == ${horizon}


********************************************************************************
//	Make sacrifice ratios, collapse to cross-sectional
********************************************************************************
if ${pi_in_sacratio}==1{
	gen sacratio${horizon} = y_cum / (pi + .00000000001)
}
else{
	gen sacratio${horizon} = y_cum / (piq + .00000000001)
}
replace model = substr(model, 1, strlen(model)-6)
keep model rule sacratio${horizon}



********************************************************************************
//	Save
********************************************************************************
save ".${cleandata}/sacratios_${horizon}.dta", replace
