#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 19 15:55:38 2022

@author: m1cmb07
"""

import os
import shutil

jake_path = '/msu/scratch4/m1cmb07/Jake_inherited/Bob/IRF_Project/models-of-interest'
os.chdir(jake_path)
models = os.listdir()

for x in models:
    original_path = '/msu/scratch4/m1cmb07/Connor_bob/mmb/models/{}/'.format(x)
    target_path = '/msu/scratch4/m1cmb07/Connor_bob/mmb/models-of-interest/{}/'.format(x)
    try: 
        os.mkdir('/msu/scratch4/m1cmb07/Connor_bob/mmb/models-of-interest/{}/'.format(x))
    except:
        pass
    name_mod = '{}.mod'.format(x)
    name_json ='{}.json'.format(x)
    shutil.copy(original_path + name_mod, target_path + name_mod)
    shutil.copy(original_path + name_json, target_path + name_json)
     