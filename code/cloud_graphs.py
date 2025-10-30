#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Jul 14 16:23:04 2024

@author: m1cmb07
"""

import pandas as pd
import os
import matplotlib.pyplot as plt

#os.chdir('/msu/scratch5/m1bdf00/Bob/mmb/')
os.chdir('/Users/connorbrennan/OneDrive - The University of Chicago/mmb/')

graph_opts = {'SW_col': '--b',
              'VAR_col': '--k',
              'med_col': '--r',
              'cal_col': 'tab:orange',
              'est_col': 'g',
              'transparency_general': 0.27,
              'highlighted_thickness': 5,
              'others_thickness': 1.5,
              'title_size': 30,
              'legend_size': 20,
              'axes_label_size': 20,
              'tick_size': 20,
              'font': 'sans-seif'}

var_vintage = 'VAR, 1963:Q1-2007:Q4'


df = pd.read_stata('./data/derived/MMB_IRF_format_full.dta')

#drop ones with piq nad y timing max of 99
timing = (
    df.groupby(['model', 'rule'])
        .apply(lambda g: pd.Series({
            'y_timing_max':   g.loc[g['y'].idxmax(),   'period'],
            'piq_timing_max': g.loc[g['piq'].idxmax(), 'period']
        }))
        .reset_index()
)
valid_groups = timing.query('y_timing_max != 99 and piq_timing_max != 99')[['model', 'rule']]
df = df.merge(valid_groups, on=['model', 'rule'], how='inner')

#print(df)


variables = ['piq', 'y', 'irate', 'rrate']
titles = ['Quarterly Inflation',
          'Output',
          'Nominal Interest Rate',
          'Real Interest Rate']
rules = ['Inertial_Taylor', 'Taylor', 'Growth']
rules_subtitles = ['Inertial Taylor Rule', 'Taylor Rule', 'Growth Rule']
modtypes = ['estimated', 'calibrated']
modtypes_subtitles = ['Estimated Models', 'Calibrated Models']

bounds = [(1, -0.25),
          (1.75, -0.25),
          (1, -1.1),
          (0.5, -1.5)]



def make_cloud_graph(df, var, graph_opts, title, subtitle):
    df_g = df.groupby(['model', 'rule'])
    fig, ax = plt.subplots(figsize = (14,8.5))
    k=0
    for key, group in df_g:
        if k==0:
            ax.plot(group.period, group['median'],
                    graph_opts['med_col'],
                    linewidth = graph_opts['highlighted_thickness'], 
                    label = "Median",
                    zorder = len(df_g))  
        if group.model.iloc[0] == "US_SW07" and group.rule.iloc[0] == "Inertial_Taylor":
            ax.plot(group.period, group[var], 
                    graph_opts['SW_col'],
                    linewidth = graph_opts['highlighted_thickness'], 
                    label = "Smets & Wouters (2007)\nunder Inertial Taylor Rule",
                    zorder = len(df_g)-2)
        elif group.model.reset_index(drop=True)[0] == var_vintage:
            ax.plot(group.period, group[var],
                    graph_opts['VAR_col'],
                    linewidth = graph_opts['highlighted_thickness'], 
                    label = var_vintage,
                    zorder = len(df_g)-1)
        elif group.calibrated.reset_index(drop=True)[0] == True:
            ax.plot(group.period, group[var], 
                    graph_opts['cal_col'],
                    linewidth = graph_opts['others_thickness'], 
                    alpha = graph_opts['transparency_general'])
        elif group.estimated.reset_index(drop=True)[0] == True:
            ax.plot(group.period, group[var], 
                    graph_opts['est_col'],
                    linewidth = graph_opts['others_thickness'], 
                    alpha = graph_opts['transparency_general'])
        k+=1

    pos = ax.get_position()
    ax.set_position([pos.x0, pos.y0, pos.width, pos.height*0.85])
    ax.legend(loc='lower center', bbox_to_anchor=(0.5, -0.28), 
              fontsize = graph_opts['legend_size'],
              frameon = False,
              ncol = 3)
    subt = f'\n{subtitle}' if subtitle != '' else ''
    ax.set_title(f'{title} after a 100bps Monetary Policy Shock' + subt, 
                 fontsize = graph_opts['title_size'])
    ax.set_xlabel('Quarters', fontsize = graph_opts['axes_label_size'])
    ax.tick_params (axis = 'both', labelsize = graph_opts['tick_size'])
    ax.set_ylim(bound[1], bound[0])
    ax.margins(x=0)
    ax.grid(color = 'grey', linestyle = '--', linewidth = 0.5)
    fig.tight_layout()
    fig.savefig(f'./output/cloud_graphs/{var}_{subtitle}.pdf', bbox_inches = 'tight')
    fig.show()
    return fig
    
    

for var, title, bound in zip(variables, titles, bounds):
    df_for_med = df.loc[df.model != var_vintage]
    df['median'] = df_for_med.groupby('period')[var].transform('median')
    
    variable_graph = make_cloud_graph(df, var, graph_opts, 
                                      title = title, subtitle = '')
    
    for rule, subtitle in zip(rules, rules_subtitles):
        df_rule = df.loc[(df.rule==rule) 
                         | ((df.model=='US_SW07') & (df.rule=='Inertial_Taylor')) 
                         | (df.model==var_vintage)]
        df_for_med = df.loc[(df.rule==rule)]
        df_rule['median'] = df_for_med.groupby('period')[var].transform('median')
        rule_graph = make_cloud_graph(df_rule, var, graph_opts, 
                                          title = title, subtitle = subtitle)
    
    for modtype, subtitle in zip(modtypes, modtypes_subtitles):
        df_rule = df.loc[(df[modtype]==1) 
                         | ((df.model=='US_SW07') & (df.rule=='Inertial_Taylor')) 
                         | (df.model==var_vintage)]
        df_for_med = df.loc[(df[modtype]==1)]
        df_rule['median'] = df_for_med.groupby('period')[var].transform('median')
        modtype_graph = make_cloud_graph(df_rule, var, graph_opts, 
                                          title = title, subtitle = subtitle)
        
    for modtype, subtitle_m in zip(modtypes, modtypes_subtitles):
        for rule, subtitle_r in zip(rules, rules_subtitles):
            df_rule_modtype = df.loc[(df.rule==rule) & (df[modtype]==1) 
                             | ((df.model=='US_SW07') & (df.rule=='Inertial_Taylor')) 
                             | (df.model==var_vintage)]
            df_for_med = df.loc[(df.rule==rule) & (df[modtype]==1)]
            df_rule_modtype['median'] = df_for_med.groupby('period')[var].transform('median')
            dual_subtitle = f'{subtitle_m} under {subtitle_r}'
            modtype_graph = make_cloud_graph(df_rule_modtype, var, graph_opts, 
                                              title = title, subtitle = dual_subtitle)        
        
        
        

        

        
        