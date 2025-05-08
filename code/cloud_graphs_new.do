********************************************************************************
//	GET BOB's CEE VAR IRFs
********************************************************************************
cd "\msu\scratch5\m1bdf00\Bob\mmb"

// Load the data file and clear any previous data
set graphics off
use data/mmbvar.dta, clear

// Generate date variables (if time identifiers are needed)
gen qdate = qofd(dateid01)    // Adjust this based on your actual date variable
format qdate %tq
tsset qdate
foreach var of varlist picxfe xgap_cbo log_fpx log_pcfr log_pcer rg10 spread rff{
	destring `var', replace
}

// Specify the variables and lag length
var picxfe xgap_cbo log_fpx log_pcfr log_pcer rg10 spread rff if inrange(qdate, quarterly("1965q1", "YQ"), quarterly("2007q4", "YQ")), lags(1/6)
// Generate IRFs using Cholesky identification
irf create Bob_order, step(40) set(VAR_results, replace) order(picxfe xgap_cbo log_fpx log_pcfr log_pcer rg10 spread rff)
// Generate individual IRFs and store them as separate graphs
foreach var of varlist picxfe xgap_cbo log_fpx log_pcfr log_pcer rg10 spread rff{
	irf graph oirf, impulse(rff) response(`var') name(`var', replace)
}

// Combine all stored graphs by their names
graph combine picxfe xgap_cbo log_fpx log_pcfr log_pcer rg10 spread rff, name(VAR_irfs, replace)

graph export "VAR_combined_irfs.png", as(png) replace

// Save and process the IRF results
irf table irf, impulse(rff)
use VAR_results.irf, clear
keep if impulse == "rff"
sort response step
order response, first
keep response step oirf
reshape wide oirf, i(step) j(response, string)

// Rename variables for clarity
ren oirfrff irate
ren oirfxgap_cbo y
ren oirfpicxfe piq
ren oirflog_fpx log_fpx
ren oirflog_pcfr log_pcfr
ren oirflog_pcer log_pcer
ren oirfrg10 rg10
ren oirfspread spread
ren step period

// Normalize and adjust IRF results
scalar scale_up = 1/irate[1]
foreach var of varlist irate y piq log_fpx log_pcfr log_pcer rg10 spread {
    replace `var' = `var' * scale_up
}

// Calculate and invert key IRF results
gen rrate = .
replace rrate = irate - piq[_n+1]  // Assuming the logic for rrate remains as it was before
foreach var of varlist irate y piq log_fpx log_pcfr log_pcer rg10 spread rrate {
    replace `var' = (-1) * `var'
    }

gen model = "VAR, 1965:Q1-2007:Q4"
gen rule = "NA"
tempfile a
save `a', replace
set graphics on


********************************************************************************
//	BRING DATA TOGETHER
********************************************************************************

graph close
use .${cleandata}MMB_IRF_format.dta, clear

// Drop unnecessary rows and create identifiers
drop if rule == "Model"
drop id
egen id = group(model rule)
order id, first

// Adjust period values
replace period = period - 1

// Update the variables list to reflect the new VAR model
glo variables = `" "piq" "y" "irate" "log_fpx" "log_pcfr" "log_pcer" "rg10" "spread" "'  

// Set the dataset for panel data analysis
xtset id period

// Local settings for graph attributes
loc title_size = "medsmall"
loc extent = 12

// Merge with additional data (assumes matching key structure)
merge m:1 model using ".${cleandata}rhs.dta"

// Generate model type indicators
gen model_type_n = 1 if calibrated == 1
replace model_type_n = 2 if estimated == 1
replace model_type_n = 3 if calibrated == 1 & estimated == 1

gen model_type = "Calibrated" if calibrated
replace model_type = "Estimated" if estimated
replace model_type = "Both" if calibrated & estimated

// Sort the data
sort model_type model period

// Define custom colors and sizes for visualization
loc calibrated_color = "orange%50"
loc estimated_color = "midgreen%35"
loc both_color = "purple%50"
loc VAR_color = "black"
loc SW_color = "blue"
loc baseline_size = 0.7
loc baseline_pattern = "dash"
loc median_color = "red"
loc ySpace = 0.25

// Final sorting
sort model rule period

// Append IRF data from the previous process
append using `a'

// Drop observations beyond the defined extent
drop if period > `extent'

// Preserve a version for further processing
preserve
    keep if (model == "US_SW07" & rule == "Inertial_Taylor") | (model == "VAR, 1965:Q1 to 2007:Q4")
    
    // Generate variables for both models
    foreach var in $variables {
        gen `var'_SW = `var' if model == "US_SW07"
        gen `var'_VAR = `var' if model == "VAR, 1965:Q1 to 2007:Q4"
    }

    // Collapse the data by period to get mean values
    collapse (mean) *_SW *_VAR, by(period)

    // Save the collapsed data to a temporary file
    tempfile b
    save `b', replace
restore

// Final sorting and saving
sort model rule period
save .${cleandata}MMB_IRF_format_full.dta, replace

// Call Python script for further visualization
! python3 ./code/cloud_graphs.py


use .${cleandata}MMB_IRF_format_full.dta, clear
br

variables = ['piq', 'y', 'irate', 'rrate']
titles = ['Quarterly Inflation',
          'Output',
          'Nominal Interest Rate',
          'Real Interest Rate']


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
glo variables =  `" "piq" "y" "irate" "log_fpx" "log_pcfr" "log_pcer" "rg10" "spread" "'  
xtset id period
loc title_size = "medsmall"
loc extent = 12
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
		gen `var'_VAR = `var' if model=="VAR, 1965:Q1 to 2007:Q4"
	}
	collapse (mean) *_SW *_VAR, by(period)
	tempfile b
	save `b', replace
restore


sort model rule period

save .${cleandata}MMB_IRF_format_full.dta, replace


* Screw trying to get Stata to cooperate. Just use Python
! python3 ./code/cloud_graphs.py





