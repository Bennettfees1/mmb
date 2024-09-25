#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 19 13:16:35 2022

@author: m1cmb07
"""
import os

#set path
path = "/msu/scratch4/m1cmb07/Connor_bob/mmb/"
os.chdir(path)

#get list of the models whose files we need to alter
models = os.listdir('./models-of-interest')
#remove any vestigial code
models = [x for x in models if ".js" not in x]

for x in models:
    original_model = f'./models/{x}/{x}.mod'
    with open(original_model, 'r', encoding = 'cp1252') as file:
        filedata = file.read()
    
    # Replace the target string of policy_param.mat
    taylor = filedata.replace('policy_param.mat', '/msu/scratch4/m1cmb07/Connor_bob/mmb/user_defined_rules/taylor_policy_param.mat')
    inertial = filedata.replace('policy_param.mat', '/msu/scratch4/m1cmb07/Connor_bob/mmb/user_defined_rules/inertial_policy_param.mat')
    difference = filedata.replace('policy_param.mat', '/msu/scratch4/m1cmb07/Connor_bob/mmb/user_defined_rules/difference_policy_param.mat')
    original = filedata
    
    #new homes for our newly written models
    taylor_model = f'./models_taylor_rule/{x}/{x}.mod'
    inertial_model = f'./models_inertial_rule/{x}/{x}.mod'
    difference_model = f'./models_difference_rule/{x}/{x}.mod'
    original_model = f'./models-of-interest/{x}/{x}.mod'

    #save the files
    with open(taylor_model, 'w') as file:
        file.write(taylor)
        file.write('\n stoch_simul(irf=60, nograph);')
    with open(inertial_model, 'w') as file:
        file.write(inertial)
        file.write('\n stoch_simul(irf=60, nograph);')
    with open(difference_model, 'w') as file:
        file.write(difference)
        file.write('\n stoch_simul(irf=60, nograph);')
    with open(original_model, 'w') as file:
        file.write(filedata)
        file.write('\n stoch_simul(irf=60, nograph);')
    
    
    
'''
with open('./models/NK_GK11/NK_GK11.mod', 'r') as file:
    filedata = file.read()
    
# Replace the target string
filedata = filedata.replace('policy_param.mat', './user_defined_rules/taylor_policy_param.mat')

with open('./models_taylor_rule/NK_GK11/NK_G11.mod', 'w') as file:
    file.write(filedata)

with open('file.txt', 'r') as file :
  filedata = file.read()

    # Replace the target string
    filedata = filedata.replace('ram', 'abcd')

# Write the file out again
with open('file.txt', 'w') as file:
  file.write(filedata)
'''