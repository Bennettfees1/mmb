#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Sep 16 15:07:29 2022

@author: m1cmb07
"""
import os
from scipy.io import savemat
from scipy.io import loadmat



path = "/msu/scratch4/m1cmb07/Connor_bob/mmb/"
os.chdir(path)

#Load in policy params matrices, initialize for different rules. 
##Doesn't have to be pretty--just has to work!
mat = loadmat('policy_param.mat')
taylor_rule = loadmat('policy_param.mat')
inertial_rule = loadmat('policy_param.mat')
difference_rule = loadmat('policy_param.mat')

#Make lists of rules' coefficients
taylor_interest = [0, 0, 0, 0, 0, 0, 0, 0, 0]
taylor_inflation = [0.375, 0.375, 0.375, 0.375, 0, 0, 0, 0, 0]
taylor_outputGap = [0.5, 0, 0, 0, 0, 0, 0, 0, 0]
taylor_output = [0, 0, 0, 0, 0, 0, 0, 0, 0]

inertial_interest = [0, 0.75, 0, 0, 0, 0, 0, 0, 0]
inertial_inflation = [0.09375, 0.09375, 0.09375, 0.09375, 0, 0, 0, 0, 0]
inertial_outputGap = [0.125, 0, 0, 0, 0, 0, 0, 0, 0]
inertial_output = [0, 0, 0, 0, 0, 0, 0, 0, 0]

difference_interest = [0, 0.75, 0, 0, 0, 0, 0, 0, 0]
difference_inflation = [0.09375, 0.09375, 0.09375, 0.09375, 0, 0, 0, 0, 0]
difference_outputGap = [0.125, 0, 0, 0, -0.125, 0, 0, 0, 0]
difference_output = [0, 0, 0, 0, 0, 0, 0, 0, 0]

#get names of coefficients in a list to loop over
mat_keys = list(dict.keys(mat))
coeff_names = mat_keys[3:34]

#Prefix names of coefficients
prefix_int = ['b1', 'b2', 'b3', 'b4']
prefix_inf = ['0', 'b1', 'b2', 'b3', 'b4', 'f1', 'f2', 'f3', 'f4']
prefix_others = ['', 'b1', 'b2', 'b3', 'b4', 'f1', 'f2', 'f3', 'f4']

#Loop for values of interest. Like monetary interest, like usary
k=0
for i in prefix_int:
    name = 'cofintint{}'.format(i)
    taylor_rule[name][0][0] = taylor_interest[k]
    inertial_rule[name][0][0] =inertial_interest[k]
    difference_rule[name][0][0] = difference_interest[k]
    k+=1

#Loop for values of inflation
k=0
for i in prefix_inf:
    name = 'cofintinf{}'.format(i)
    taylor_rule[name][0][0] = taylor_inflation[k]
    inertial_rule[name][0][0] = inertial_inflation[k]
    difference_rule[name][0][0] = difference_inflation[k]
    k+=1
    
#Loop for values of output gap
k=0
for i in prefix_others:
    name = 'cofintout{}'.format(i)
    taylor_rule[name][0][0] = taylor_outputGap[k]
    inertial_rule[name][0][0] = inertial_outputGap[k]
    difference_rule[name][0][0] = difference_outputGap[k]
    k+=1
    
#Loop for values of output
k=0
for i in prefix_others:
    name = 'cofintoutp{}'.format(i)
    taylor_rule[name][0][0] = taylor_output[k]
    inertial_rule[name][0][0] = inertial_output[k]
    difference_rule[name][0][0] = difference_output[k]
    k+=1
    
#Save our new rules to .mat files to run in Dynare
savemat("user_defined_rules/taylor_policy_param.mat", taylor_rule)
savemat("user_defined_rules/inertial_policy_param.mat", inertial_rule)
savemat("user_defined_rules/difference_policy_param.mat", difference_rule)
savemat("user_defined_rules/taylor_policy_param.mat", taylor_rule)

    
    
    
    
    
