*! 1.1 Alvaro Carril 04apr2017
program define texresults
version 9
syntax [using], ///
	TEXmacro(string) ///
	[ ///
		replace Append ///
		ROund(real 0.01) UNITzero ///
		Result(string) ///
		coef(varname) ///
		se(varname) ///
		tstat(varname) ///
		pvalue(varname) ///
		string(string) ///
	]


* Initial checks and processing
*------------------------------------------------------------------------------
// Parse file action
if !missing("`replace'") & !missing("`append'") {
	di as error "{bf:replace} and {bf:append} may not be specified simultaneously"
	exit 198
}
local action `replace' `append'

// Add backslash to macroname and issue warning if doesn't contain only alph
local isalph = regexm("`texmacro'","^[a-zA-Z ]*$")
local texmacro = "\" + "`texmacro'"
if `isalph' == 0 di as text `""`texmacro'" may not be a valid LaTeX macro name"'


* Process and store [rounded] result
*------------------------------------------------------------------------------
if missing("`round'") {
	local round=0
}

// general result (scalar, local, etc.)
if !missing("`result'") {
	*local result =round(`result', `round')

	local result: di %9.`round'fc `result'
	local result `result'
}
// coefficient
if !missing("`coef'") {
	//local result = round(_b[`coef'], `round')
	local result: di %9.`round'fc _b[`coef']
	local result `result'
}
// standard error
if !missing("`se'") {
	//local result = round(_se[`se'], `round')
	local result: di %5.`round'fc _se[`se']
	local result `result'
}
// t-stat
if !missing("`tstat'") {
	//local result = round(_b[`tstat']/_se[`tstat'], `round')
	local result: di %5.`round'fc _b[`tstat']/_se[`tstat']
	local result `result'
}
// p-value
if !missing("`pvalue'") {
	//local result = round(2 * ttail(e(df_r), abs(_b[`pvalue']/_se[`pvalue'])), `round')
	local result: di %5.`round'fc 2 * ttail(e(df_r), abs(_b[`pvalue']/_se[`pvalue']))
	local result `result'
}
capture confirm number `result'


if _rc!=7 {
// Add unit zero if option is specified and result qualifies
if (!missing("`unitzero'")  & abs(`result') < 1) {
	if (`result' > 0) local result 0`result'
	else local result = "-0"+"`=abs(`result')'"
}
}

// general string 
if !missing("`string'") {
	local result "`string'"
}


* Create or modify macros file
*------------------------------------------------------------------------------
file open texresultsfile `using', write `action'
file write texresultsfile "\newcommand{`texmacro'}{$`result'$}" _n
file close texresultsfile
*di as text `" Open {browse results.txt}"'

end
