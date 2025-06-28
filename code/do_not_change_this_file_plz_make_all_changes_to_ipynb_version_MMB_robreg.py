#!/usr/bin/env python
# coding: utf-8

# In[1]:


import os
import pandas as pd
import numpy as np
import statsmodels.formula.api as smf
import pyreadstat
import statsmodels.api as sm
from patsy import dmatrices
import nbformat
from nbconvert import PythonExporter


os.chdir('/Users/connorbrennan/OneDrive - The University of Chicago/mmb/data')


# In[2]:


df, meta = pyreadstat.read_dta('derived/MMB_reg_format.dta')
df_labels = pd.DataFrame({
    "Variable": meta.column_names,
    "Description": meta.column_labels
})
print(df_labels)
#df = df.loc[df['sacratio20'] < df['sacratio20'].quantile(0.98)]
df_estimated = df.loc[df['estimated']==1]
df_calibrated = df.loc[df['calibrated']==1]


# In[3]:


# Stepwise regression parameters
alphas = {
    'enter': 0.075,
    'exit': 0.125
}

#alpha_enter, alpha_exit = 0.15, 0.15
depvars = ['IScurve', 'infl_per_rr', 'sacratio']

# Independent variables

'''
frictions_detailed = ['stky_pr_calvo', 'stky_pr_rotemberg', 'stky_pr_other', 'stky_wg', 
                      'pr_ndx', 'wg_ndx', 'wg_ndx_prprice', 'wg_ndx_mult', 'wg_ndx_other',
                      'stky_pr_calvo:pr_ndx', 'stky_pr_rotemberg:pr_ndx', 'stky_pr_other:pr_ndx',
                      'stky_wg:wg_ndx', 'stky_wg:wg_ndx_prprice', 'stky_wg:wg_ndx_mult', 'stky_wg:wg_ndx_other']  

frictions_simple = ['stky_pr_calvo', 'stky_pr_rotemberg', 'stky_pr_other', 'stky_wg', 
                    'pr_ndx', 'wg_ndx',
                    'stky_pr_calvo:pr_ndx', 'stky_pr_rotemberg:pr_ndx', 'stky_pr_other:pr_ndx',
                    'stky_wg:wg_ndx'] 

properties = ['estimated', 'est_early', 'est_late', 'vint_mid', 'bnkcrdit', 'ntwrth', 'wlth',
              'open', 'other_channel', 'cb_authors_ext', 'ln_neq']
'''


frictions_detailed = ['stky_pr_calvo', 'stky_pr_rotemberg', 'stky_pr_other', 'stky_wg', 
                      'pr_ndx', 'wg_ndx', 'wg_ndx_prprice', 'wg_ndx_mult', 'wg_ndx_other',
                      'stky_pr_calvo:pr_ndx', 'stky_pr_rotemberg:pr_ndx', 'stky_pr_other:pr_ndx',
                      'stky_wg:wg_ndx', 'stky_wg:wg_ndx_prprice', 'stky_wg:wg_ndx_mult', 'stky_wg:wg_ndx_other',
                      'bnkcrdit', 'ntwrth', 'wlth', 'open', 'other_channel']  

frictions_simple = ['stky_pr_calvo', 'stky_pr_rotemberg', 'stky_pr_other', 'stky_wg', 
                    'pr_ndx', 'wg_ndx',
                    'stky_pr_calvo:pr_ndx', 'stky_pr_rotemberg:pr_ndx', 'stky_pr_other:pr_ndx',
                    'stky_wg:wg_ndx',
                    'bnkcrdit', 'ntwrth', 'wlth', 'open', 'other_channel'] 

properties = ['estimated', 'est_early', 'est_late', 'vint_late', 'vint_mid', 'vint_early', 'cb_authors_ext', 'ln_neq']


indepvars_detailed = frictions_detailed + properties
indepvars_simple = frictions_simple + properties


# In[4]:


def stepwise_reg(depvar, covariates, data, alphas):
    potential_covariates = list(covariates)
    entered_vars = []
    keep_stepping = True

    while keep_stepping:
        keep_stepping = False # Loop continues only if we add or remove a covariate
        best_pval_in_step = 1
        entering_var = None

        # Go through all potential covariates, noting best one
        for var in potential_covariates:
            entered_vars.append(var)
            formula = f'{depvar} ~ {"+".join(entered_vars)} + rule_g + rule_itr'
            y,X = dmatrices(formula, data = data, return_type='dataframe')
            rank_X, cond_num = np.linalg.matrix_rank(X), np.linalg.cond(X)
            if (rank_X < X.shape[1]) or (cond_num > 1000):
                '''
                Adding would make collinear so we are passing over that variable. Statsmodels
                package uses pseudo-inverses which piss me off because it won't actually tell
                you if your regressions are really collinear.
                '''
                pass
            else: #not going to introduce collinearity so let the good times roll
                robreg = smf.rlm(f'{depvar} ~ {"+".join(entered_vars)} + rule_g + rule_itr', 
                            M = sm.robust.norms.TukeyBiweight(),
                            data = data).fit(
                                scale_est = 'mad',
                                cov = 'H1',
                                update_scale = True,
                                conv = 'coefs'
                            )
                candidate_pval = robreg.pvalues.get(var, np.nan)    # If collinear pass it
                if (candidate_pval < best_pval_in_step) and (candidate_pval < alphas['enter']):
                    entering_var = var
                    best_pval_in_step = candidate_pval.copy()
            entered_vars.remove(var)


        if entering_var != None:
            # Add the best covariate to the regression
            entered_vars.append(entering_var)
            potential_covariates.remove(entering_var)
            keep_stepping = True    # Added a covariate so need to keep running


        # Remove variables that have gone insignificant due to the inclusion of new covariate
        # Loop through all variables. If one removed, rerun reg and loop through all variables
        # again, removing if p-value > alphas['exit']
        while True:
            robreg = smf.rlm(f'{depvar} ~ {"+".join(entered_vars)} + rule_g + rule_itr', 
                            M = sm.robust.norms.TukeyBiweight(),
                            data = data).fit(
                                scale_est = 'mad',
                                cov = 'H1',
                                update_scale = True,
                                conv = 'coefs'
                            )
            removal_idxs = ~robreg.pvalues.index.isin(['rule_g', 'rule_itr', 'Intercept'])
            removal_candidates = robreg.pvalues[removal_idxs]
            if removal_candidates[removal_candidates.idxmax()] > alphas['exit']:
                entered_vars.remove(removal_candidates.idxmax())
                potential_covariates.append(removal_candidates.idxmax())
            else:
                break                

    final_reg = smf.rlm(f'{depvar} ~ {"+".join(entered_vars)} + rule_g + rule_itr', 
                            M = sm.robust.norms.TukeyBiweight(),
                            data = data).fit(
                                scale_est = 'mad',
                                cov = 'H1',
                                update_scale = True,
                                conv = 'coefs'
                            )
    
    return final_reg



def get_r2(orig_reg, depvar, data):
    formula_str = (f'{depvar} ~ {"+".join([v for v in orig_reg.params.index[1:]])} + rule_g + rule_itr')
    y, X = dmatrices(formula_str, data=data, return_type='dataframe') 

    valid_index = X.index
    weights_series = orig_reg.weights
    weights_series = weights_series.loc[valid_index]
    df_sub = df.loc[valid_index]  # the same subset

    wls_reg = smf.wls(
        formula_str,
        data = df_sub,
        weights = weights_series
    ).fit(cov='H1')
    return wls_reg.rsquared_adj


# In[5]:


var_labels = {
    'Intercept': "Constant",
    'rule_g': "Rule: Growth",
    'rule_itr': "Rule: Inert. Taylor",
    'stky_pr_calvo': "Sticky Prices (Calvo)",
    'stky_pr_rotemberg': "Sticky Prices (Rotemberg)", 
    'stky_pr_other': "Sticky Prices (Other)", 
    'stky_wg': "Sticky Wages", 
    'pr_ndx': "Price Idx", 
    'wg_ndx': "Wage Idx.", 
    'wg_ndx_prprice': "Wage Idx. (Prev. Price)", 
    'wg_ndx_mult': "Wage Idx. (Mult. Price)", 
    'wg_ndx_other': "Wage Idx. (Other)",
    'stky_pr_calvo:pr_ndx': "Sticky Price (Calvo) $\\times$ Price Idx.", 
    'stky_pr_rotemberg:pr_ndx': "Sticky Price (Rotemberg) $\\times$ Price Idx.", 
    'stky_pr_other:pr_ndx': "Sticky Price (Other) $\\times$ Price Idx.",
    'stky_wg:wg_ndx': "Sticky Wages $\\times$ Wage Idx.", 
    'stky_wg:wg_ndx_prprice': "Sticky Wages $\\times$ Wage Idx. (Prev. Price)", 
    'stky_wg:wg_ndx_mult': "Sticky Wages $\\times$ Wage Idx. (Mult. Price)", 
    'stky_wg:wg_ndx_other': "Sticky Wages $\\times$ Wage Idx. (Other)",
    'estimated': "Estimated", 
    'est_early': "Early Data ", 
    'est_late': "Late Data", 
    'vint_early': "Early Vintage", 
    'vint_mid': "Mid Vintage", 
    'vint_late': "Late Vintage", 
    'bnkcrdit': "Bank Credit Channel", 
    'ntwrth': "Net Worth Channel", 
    'wlth': "Wealth Channel",
    'open': "Open Economy", 
    'other_channel': "Other Channel", 
    'cb_authors_ext': "Central Bank Author", 
    'ln_neq': "$\\log($Num. of Eqs.$)$"
}

'''
properties = ['estimated', 'est_early', 'est_late', 'vint_mid', 'bnkcrdit', 'ntwrth', 'wlth',
              'open', 'other_channel', 'cb_authors_ext', 'ln_neq']
'''


depvar_labels = {'IScurve': 'IS Curve',
                 'infl_per_rr': 'Pi Curve',
                 'sacratio': 'Sacrifice Ratio'}


def significance_stars(pval):
    if pval < 0.01:
        return "***"
    elif pval < 0.05:
        return "**"
    elif pval < 0.10:
        return "*"
    else:
        return ""


def format_coef(param, pval):
    """
    Formats the coefficient with 3 decimal places plus significance stars.
    """
    return f"{param:.3f}{significance_stars(pval)}"


def format_se(std_err):
    """
    Formats the standard error in parentheses, with 3 decimal places.
    """
    return f"({std_err:.3f})"


def generate_latex_tables(stepwise_regs, r2_values, depvars, horizons, var_labels, depvar_labels, outfile=None):
    """
    Given a dictionary of stepwise regression results (stepwise_regs), a list of
    dependent variables (depvars), and a list of horizons, generate nicely
    formatted LaTeX tables with multirow rows for each variable, variable labels,
    and lines at the bottom for R^2 or nobs.

    We double backslash LaTeX commands to avoid Python interpreting escape chars.
    """
    latex_pieces = []
    for depvar in depvars:
        # 2A) Identify which models belong to this dependent variable
        these_models = {}
        for h in horizons:
            key = f"{depvar}{h}"
            if key in stepwise_regs:
                these_models[h] = stepwise_regs[key]

        # If no models found for this depvar, skip
        if not these_models:
            continue

        # 2B) Collect the union of all variable names across these models
        varset = set()
        for h, model in these_models.items():
            varset = varset.union(model.params.index)
        # Sort them in a consistent order, but keep 'Intercept' on top if you prefer
        varlist = sorted(varset, key=lambda v: (v != 'Intercept', v))

        # 2C) Start building the LaTeX string
        latex_str = []
        latex_str.append("\\begin{table}[h!]")
        latex_str.append("\\centering")
        latex_str.append("\\resizebox{0.9\\textwidth}{!}{%")  # Optional scaling
        latex_str.append("\\begin{tabular}{l" + "c"*len(horizons) + "}")
        latex_str.append("\\hline")

        # 2D) First row: label the dependent variable, spanning all columns
        latex_str.append(
            f"\\multicolumn{{{len(horizons)+1}}}{{l}}{{\\textbf{{Dependent Variable: {depvar_labels[depvar]}}}}} \\\\"
        )
        latex_str.append("\\hline")

        # 2E) Print horizon labels, e.g. & (20) & (40) & (60)
        horizon_header = "\\textbf{{Horizon}} & " + " & ".join([f"{h}" for h in horizons]) + " \\\\"
        latex_str.append(horizon_header)
        latex_str.append("\\hline")

        # 2F) For each variable, produce two rows:
        #     (1) multirow w/ var name + coefficients
        #     (2) blank first cell + std errors
        for var in varlist:
            # Build dict for param/std_err across horizons
            coeffs = []
            std_errs = []
            for h in horizons:
                model = these_models.get(h, None)
                if model is not None and var in model.params.index:
                    param = model.params[var]
                    pval  = model.pvalues[var]
                    stderr= model.bse[var]

                    coeffs.append(format_coef(param, pval))
                    std_errs.append(format_se(stderr))
                else:
                    coeffs.append("")
                    std_errs.append("")

            # 2G) Resolve variable label if available, otherwise default
            if var in var_labels:
                varname_latex = var_labels[var]
            else:
                varname_latex = var
            # Escape underscores for LaTeX
            varname_latex = varname_latex.replace("_", "\\_")

            # Multirow lines
            line1 = f"\\multirow{{2}}{{*}}{{{varname_latex}}} & " + " & ".join(coeffs) + " \\\\"
            line2 = " & " + " & ".join(std_errs) + " \\\\"

            latex_str.append(line1)
            latex_str.append(line2)

        # 2H) Now we add lines for number of observations, and (optionally) R^2
        #     We'll build them across the horizons, e.g.: Observations & n1 & n2 & n3
        #     For RLM, there's no built-in R^2, but we can just show placeholders
        latex_str.append("\\hline")

        # Observations line
        nobs_list = []
        for h in horizons:
            model = these_models.get(h, None)
            if model is not None:
                nobs_list.append(str(int(model.nobs)))
            else:
                nobs_list.append("")
        latex_str.append("Observations & " + " & ".join(nobs_list) + " \\\\")

        # R-squared (placeholder or a custom statistic)
        # For RLM there's no rsquared by default, so we just show an example row:
        # If you compute your own pseudo-R^2, replace "... " with that value
        r2_list = []
        for h in horizons:
            r2 = r2_values.get(f'{depvar}{h}', None)
            if r2 is not None:
                # placeholder; replace with something like "f'{model_custom_r2:.3f}'"
                r2_list.append(str(round(r2,3)))
            else:
                r2_list.append("")
        latex_str.append("$R^2$ from Final Weights& " + f'{" & ".join(r2_list)}' + " \\\\")

        # 2I) Wrap up
        latex_str.append("\\hline")
        latex_str.append("\\end{tabular}")
        latex_str.append("}")  # Closes \\resizebox
        latex_str.append(f"\\caption{{Stepwise RLM results for {depvar_labels[depvar]}}}")
        latex_str.append("\\end{table}")
        latex_str.append("\\newpage")

        # Print the LaTeX code for this table
        table_code = "\n".join(latex_str)
        latex_pieces.append(table_code)
        #print(table_code)
        #print("\n\n")  # some space after each table
    
    all_tables = "\n\n".join(latex_pieces)
    if outfile is not None:
        with open(outfile, "w") as f:
            f.write(all_tables)
        print(f"Saved all tables to {outfile}")
    else:
        print(all_tables)
        print("\n\n")


depvars = ['IScurve', 'infl_per_rr', 'sacratio']
horizons = [20, 40, 60]


# In[6]:


stepwise_regs_smp = {}
r2_values_smp = {}
for depvar in depvars:
    for horizon in [20, 40, 60]:
        stepwise_regs_smp[f'{depvar}{horizon}'] = stepwise_reg(f'{depvar}{horizon}', indepvars_simple, df, alphas)
        r2_values_smp[f'{depvar}{horizon}'] = get_r2(stepwise_regs_smp[f'{depvar}{horizon}'], f'{depvar}{horizon}', df)
        print(f'Completed simple stepwise regressions for {depvar}{horizon}!')


stepwise_regs_dtd = {}
r2_values_dtd = {}
for depvar in depvars:
    for horizon in [20, 40, 60]:
        stepwise_regs_dtd[f'{depvar}{horizon}'] = stepwise_reg(f'{depvar}{horizon}', indepvars_detailed, df, alphas)
        r2_values_dtd[f'{depvar}{horizon}'] = get_r2(stepwise_regs_dtd[f'{depvar}{horizon}'], f'{depvar}{horizon}', df)
        print(f'Completed detailed stepwise regressions for {depvar}{horizon}!')


# In[7]:


generate_latex_tables(stepwise_regs_dtd, r2_values_dtd, depvars, horizons, var_labels, depvar_labels, '../output/stepwise_regressions/stepwise_together_detailed.txt')


# In[8]:


generate_latex_tables(stepwise_regs_smp, r2_values_smp, depvars, horizons, var_labels, depvar_labels, '../output/stepwise_regressions/stepwise_together_simple.txt')


# In[9]:


stepwise_regs_frics_smp = {}
r2_values_frics_smp = {}
for depvar in depvars:
    for horizon in [20, 40, 60]:
        stepwise_regs_frics_smp[f'{depvar}{horizon}'] = stepwise_reg(f'{depvar}{horizon}', frictions_simple, df, alphas)
        r2_values_frics_smp[f'{depvar}{horizon}'] = get_r2(stepwise_regs_frics_smp[f'{depvar}{horizon}'], f'{depvar}{horizon}', df)
        print(f'Completed frictions simple stepwise regressions for {depvar}{horizon}!')

generate_latex_tables(stepwise_regs_frics_smp, r2_values_frics_smp, depvars, horizons, var_labels, depvar_labels, '../output/stepwise_regressions/stepwise_frictions_simple.txt')


stepwise_regs_frics_dtd = {}
r2_values_frics_dtd = {}
for depvar in depvars:
    for horizon in [20, 40, 60]:
        stepwise_regs_frics_dtd[f'{depvar}{horizon}'] = stepwise_reg(f'{depvar}{horizon}', frictions_detailed, df, alphas)
        r2_values_frics_dtd[f'{depvar}{horizon}'] = get_r2(stepwise_regs_frics_dtd[f'{depvar}{horizon}'], f'{depvar}{horizon}', df)
        print(f'Completed frictions detailed stepwise regressions for {depvar}{horizon}!')

generate_latex_tables(stepwise_regs_frics_dtd, r2_values_frics_dtd, depvars, horizons, var_labels, depvar_labels, '../output/stepwise_regressions/stepwise_frictions_detailed.txt')


# In[10]:


stepwise_regs_props_smp = {}
r2_values_props_smp = {}
for depvar in depvars:
    for horizon in [20, 40, 60]:
        stepwise_regs_props_smp[f'{depvar}{horizon}'] = stepwise_reg(f'{depvar}{horizon}', properties, df, alphas)
        r2_values_props_smp[f'{depvar}{horizon}'] = get_r2(stepwise_regs_props_smp[f'{depvar}{horizon}'], f'{depvar}{horizon}', df)
        print(f'Completed properties stepwise regressions for {depvar}{horizon}!')

generate_latex_tables(stepwise_regs_props_smp, r2_values_props_smp, depvars, horizons, var_labels, depvar_labels, '../output/stepwise_regressions/stepwise_properties.txt')


# In[11]:


import nbformat
from nbconvert import PythonExporter

notebook_path = "../code/MMB_robreg.ipynb"  # replace with your actual filename

# Load the notebook
with open(notebook_path, 'r', encoding='utf-8') as f:
    nb_node = nbformat.read(f, as_version=4)

# Convert to Python script
exporter = PythonExporter()
source, _ = exporter.from_notebook_node(nb_node)

# Save as .py file
py_path = notebook_path.replace(".ipynb", ".py")
py_path = py_path.replace("MMB_robreg", "do_not_change_this_file_plz_make_all_changes_to_ipynb_version_MMB_robreg")
with open(py_path, 'w', encoding='utf-8') as f:
    f.write(source)

print(f"Notebook exported as {py_path}")

