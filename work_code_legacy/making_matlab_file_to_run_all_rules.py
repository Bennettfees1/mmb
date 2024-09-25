#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 19 15:55:38 2022

@author: m1cmb07
"""

import os


path = '/msu/scratch4/m1cmb07/Connor_bob/mmb/'
os.chdir(path)
models = os.listdir('./models-of-interest/')

try:
    os.remove('Run_Dynare_all_models_all_rules.txt')
except:
    pass

try:
    os.remove('Run_Dynare_all_models_all_rules.m')
except:
    pass

with open("Run_Dynare_all_models_all_rules.txt", 'w') as file:
    file.write('addpath("/apps/dynare/4.5.6/lib/dynare/matlab")\n\n')
    
    for x in models:
        #Model rule simulation
        file.write(f'cd \'/msu/scratch4/m1cmb07/Connor_bob/mmb/models-of-interest/{x}/\'\n')
        file.write('clear\n')
        file.write('close all\n')
        file.write(f'dynare {x}.mod\n\n')
        
        #Taylor rule simulation
        file.write(f'cd \'/msu/scratch4/m1cmb07/Connor_bob/mmb/models_taylor_rule/{x}/\'\n')
        file.write('clear\n')
        file.write('close all\n')
        file.write(f'dynare {x}.mod\n\n')
        
        #Inertial Taylor rule simulation
        file.write(f'cd \'/msu/scratch4/m1cmb07/Connor_bob/mmb/models_inertial_rule/{x}/\'\n')
        file.write('clear\n')
        file.write('close all\n')
        file.write(f'dynare {x}.mod\n\n')
        
        #Difference rule simulation
        file.write(f'cd \'/msu/scratch4/m1cmb07/Connor_bob/mmb/models_difference_rule/{x}/\'\n')
        file.write('clear\n')
        file.write('close all\n')
        file.write(f'dynare {x}.mod\n\n')
        
os.rename('Run_Dynare_all_models_all_rules.txt', 'Run_Dynare_all_models_all_rules.m')