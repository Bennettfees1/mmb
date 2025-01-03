%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

if isoctave || matlab_ver_less_than('8.6')
    clear all
else
    clearvars -global
    clear_persistent_variables(fileparts(which('dynare')), false)
end
tic0 = tic;
% Save empty dates and dseries objects in memory.
dates('initialize');
dseries('initialize');
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'US_VI16gk';
M_.dynare_version = '4.5.6';
oo_.dynare_version = '4.5.6';
options_.dynare_version = '4.5.6';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('US_VI16gk.log');
M_.exo_names = 'e_x';
M_.exo_names_tex = 'e\_x';
M_.exo_names_long = 'e_x';
M_.exo_names = char(M_.exo_names, 'e_k');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_k');
M_.exo_names_long = char(M_.exo_names_long, 'e_k');
M_.exo_names = char(M_.exo_names, 'e_a');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_a');
M_.exo_names_long = char(M_.exo_names_long, 'e_a');
M_.exo_names = char(M_.exo_names, 'e_w');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_w');
M_.exo_names_long = char(M_.exo_names_long, 'e_w');
M_.exo_names = char(M_.exo_names, 'e_p');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_p');
M_.exo_names_long = char(M_.exo_names_long, 'e_p');
M_.exo_names = char(M_.exo_names, 'interest_');
M_.exo_names_tex = char(M_.exo_names_tex, 'interest\_');
M_.exo_names_long = char(M_.exo_names_long, 'interest_');
M_.exo_names = char(M_.exo_names, 'fiscal_');
M_.exo_names_tex = char(M_.exo_names_tex, 'fiscal\_');
M_.exo_names_long = char(M_.exo_names_long, 'fiscal_');
M_.endo_names = 'y';
M_.endo_names_tex = 'y';
M_.endo_names_long = 'y';
M_.endo_names = char(M_.endo_names, 'i');
M_.endo_names_tex = char(M_.endo_names_tex, 'i');
M_.endo_names_long = char(M_.endo_names_long, 'i');
M_.endo_names = char(M_.endo_names, 'ext_pr');
M_.endo_names_tex = char(M_.endo_names_tex, 'ext\_pr');
M_.endo_names_long = char(M_.endo_names_long, 'ext_pr');
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names_long = char(M_.endo_names_long, 'c');
M_.endo_names = char(M_.endo_names, 'lev');
M_.endo_names_tex = char(M_.endo_names_tex, 'lev');
M_.endo_names_long = char(M_.endo_names_long, 'lev');
M_.endo_names = char(M_.endo_names, 'q');
M_.endo_names_tex = char(M_.endo_names_tex, 'q');
M_.endo_names_long = char(M_.endo_names_long, 'q');
M_.endo_names = char(M_.endo_names, 'Lambda');
M_.endo_names_tex = char(M_.endo_names_tex, 'Lambda');
M_.endo_names_long = char(M_.endo_names_long, 'Lambda');
M_.endo_names = char(M_.endo_names, 'l');
M_.endo_names_tex = char(M_.endo_names_tex, 'l');
M_.endo_names_long = char(M_.endo_names_long, 'l');
M_.endo_names = char(M_.endo_names, 'd');
M_.endo_names_tex = char(M_.endo_names_tex, 'd');
M_.endo_names_long = char(M_.endo_names_long, 'd');
M_.endo_names = char(M_.endo_names, 'v');
M_.endo_names_tex = char(M_.endo_names_tex, 'v');
M_.endo_names_long = char(M_.endo_names_long, 'v');
M_.endo_names = char(M_.endo_names, 'rk');
M_.endo_names_tex = char(M_.endo_names_tex, 'rk');
M_.endo_names_long = char(M_.endo_names_long, 'rk');
M_.endo_names = char(M_.endo_names, 'x');
M_.endo_names_tex = char(M_.endo_names_tex, 'x');
M_.endo_names_long = char(M_.endo_names_long, 'x');
M_.endo_names = char(M_.endo_names, 'z');
M_.endo_names_tex = char(M_.endo_names_tex, 'z');
M_.endo_names_long = char(M_.endo_names_long, 'z');
M_.endo_names = char(M_.endo_names, 'nn');
M_.endo_names_tex = char(M_.endo_names_tex, 'nn');
M_.endo_names_long = char(M_.endo_names_long, 'nn');
M_.endo_names = char(M_.endo_names, 'mu');
M_.endo_names_tex = char(M_.endo_names_tex, 'mu');
M_.endo_names_long = char(M_.endo_names_long, 'mu');
M_.endo_names = char(M_.endo_names, 'n');
M_.endo_names_tex = char(M_.endo_names_tex, 'n');
M_.endo_names_long = char(M_.endo_names_long, 'n');
M_.endo_names = char(M_.endo_names, 'ne');
M_.endo_names_tex = char(M_.endo_names_tex, 'ne');
M_.endo_names_long = char(M_.endo_names_long, 'ne');
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.endo_names_long = char(M_.endo_names_long, 'k');
M_.endo_names = char(M_.endo_names, 'u');
M_.endo_names_tex = char(M_.endo_names_tex, 'u');
M_.endo_names_long = char(M_.endo_names_long, 'u');
M_.endo_names = char(M_.endo_names, 'w');
M_.endo_names_tex = char(M_.endo_names_tex, 'w');
M_.endo_names_long = char(M_.endo_names_long, 'w');
M_.endo_names = char(M_.endo_names, 'r');
M_.endo_names_tex = char(M_.endo_names_tex, 'r');
M_.endo_names_long = char(M_.endo_names_long, 'r');
M_.endo_names = char(M_.endo_names, 'zk');
M_.endo_names_tex = char(M_.endo_names_tex, 'zk');
M_.endo_names_long = char(M_.endo_names_long, 'zk');
M_.endo_names = char(M_.endo_names, 'rn');
M_.endo_names_tex = char(M_.endo_names_tex, 'rn');
M_.endo_names_long = char(M_.endo_names_long, 'rn');
M_.endo_names = char(M_.endo_names, 'pi');
M_.endo_names_tex = char(M_.endo_names_tex, 'pi');
M_.endo_names_long = char(M_.endo_names_long, 'pi');
M_.endo_names = char(M_.endo_names, 'yf');
M_.endo_names_tex = char(M_.endo_names_tex, 'yf');
M_.endo_names_long = char(M_.endo_names_long, 'yf');
M_.endo_names = char(M_.endo_names, 'i_f');
M_.endo_names_tex = char(M_.endo_names_tex, 'i\_f');
M_.endo_names_long = char(M_.endo_names_long, 'i_f');
M_.endo_names = char(M_.endo_names, 'ext_prf');
M_.endo_names_tex = char(M_.endo_names_tex, 'ext\_prf');
M_.endo_names_long = char(M_.endo_names_long, 'ext_prf');
M_.endo_names = char(M_.endo_names, 'cf');
M_.endo_names_tex = char(M_.endo_names_tex, 'cf');
M_.endo_names_long = char(M_.endo_names_long, 'cf');
M_.endo_names = char(M_.endo_names, 'levf');
M_.endo_names_tex = char(M_.endo_names_tex, 'levf');
M_.endo_names_long = char(M_.endo_names_long, 'levf');
M_.endo_names = char(M_.endo_names, 'qf');
M_.endo_names_tex = char(M_.endo_names_tex, 'qf');
M_.endo_names_long = char(M_.endo_names_long, 'qf');
M_.endo_names = char(M_.endo_names, 'Lambdaf');
M_.endo_names_tex = char(M_.endo_names_tex, 'Lambdaf');
M_.endo_names_long = char(M_.endo_names_long, 'Lambdaf');
M_.endo_names = char(M_.endo_names, 'lf');
M_.endo_names_tex = char(M_.endo_names_tex, 'lf');
M_.endo_names_long = char(M_.endo_names_long, 'lf');
M_.endo_names = char(M_.endo_names, 'df');
M_.endo_names_tex = char(M_.endo_names_tex, 'df');
M_.endo_names_long = char(M_.endo_names_long, 'df');
M_.endo_names = char(M_.endo_names, 'vf');
M_.endo_names_tex = char(M_.endo_names_tex, 'vf');
M_.endo_names_long = char(M_.endo_names_long, 'vf');
M_.endo_names = char(M_.endo_names, 'rkf');
M_.endo_names_tex = char(M_.endo_names_tex, 'rkf');
M_.endo_names_long = char(M_.endo_names_long, 'rkf');
M_.endo_names = char(M_.endo_names, 'xf');
M_.endo_names_tex = char(M_.endo_names_tex, 'xf');
M_.endo_names_long = char(M_.endo_names_long, 'xf');
M_.endo_names = char(M_.endo_names, 'zf');
M_.endo_names_tex = char(M_.endo_names_tex, 'zf');
M_.endo_names_long = char(M_.endo_names_long, 'zf');
M_.endo_names = char(M_.endo_names, 'nnf');
M_.endo_names_tex = char(M_.endo_names_tex, 'nnf');
M_.endo_names_long = char(M_.endo_names_long, 'nnf');
M_.endo_names = char(M_.endo_names, 'muf');
M_.endo_names_tex = char(M_.endo_names_tex, 'muf');
M_.endo_names_long = char(M_.endo_names_long, 'muf');
M_.endo_names = char(M_.endo_names, 'nf');
M_.endo_names_tex = char(M_.endo_names_tex, 'nf');
M_.endo_names_long = char(M_.endo_names_long, 'nf');
M_.endo_names = char(M_.endo_names, 'nef');
M_.endo_names_tex = char(M_.endo_names_tex, 'nef');
M_.endo_names_long = char(M_.endo_names_long, 'nef');
M_.endo_names = char(M_.endo_names, 'kf');
M_.endo_names_tex = char(M_.endo_names_tex, 'kf');
M_.endo_names_long = char(M_.endo_names_long, 'kf');
M_.endo_names = char(M_.endo_names, 'uf');
M_.endo_names_tex = char(M_.endo_names_tex, 'uf');
M_.endo_names_long = char(M_.endo_names_long, 'uf');
M_.endo_names = char(M_.endo_names, 'wf');
M_.endo_names_tex = char(M_.endo_names_tex, 'wf');
M_.endo_names_long = char(M_.endo_names_long, 'wf');
M_.endo_names = char(M_.endo_names, 'rf');
M_.endo_names_tex = char(M_.endo_names_tex, 'rf');
M_.endo_names_long = char(M_.endo_names_long, 'rf');
M_.endo_names = char(M_.endo_names, 'zkf');
M_.endo_names_tex = char(M_.endo_names_tex, 'zkf');
M_.endo_names_long = char(M_.endo_names_long, 'zkf');
M_.endo_names = char(M_.endo_names, 'a');
M_.endo_names_tex = char(M_.endo_names_tex, 'a');
M_.endo_names_long = char(M_.endo_names_long, 'a');
M_.endo_names = char(M_.endo_names, 'g');
M_.endo_names_tex = char(M_.endo_names_tex, 'g');
M_.endo_names_long = char(M_.endo_names_long, 'g');
M_.endo_names = char(M_.endo_names, 'eps_p');
M_.endo_names_tex = char(M_.endo_names_tex, 'eps\_p');
M_.endo_names_long = char(M_.endo_names_long, 'eps_p');
M_.endo_names = char(M_.endo_names, 'eps_w');
M_.endo_names_tex = char(M_.endo_names_tex, 'eps\_w');
M_.endo_names_long = char(M_.endo_names_long, 'eps_w');
M_.endo_names = char(M_.endo_names, 'eps_k');
M_.endo_names_tex = char(M_.endo_names_tex, 'eps\_k');
M_.endo_names_long = char(M_.endo_names_long, 'eps_k');
M_.endo_names = char(M_.endo_names, 'eps_r');
M_.endo_names_tex = char(M_.endo_names_tex, 'eps\_r');
M_.endo_names_long = char(M_.endo_names_long, 'eps_r');
M_.endo_names = char(M_.endo_names, 'eps_x');
M_.endo_names_tex = char(M_.endo_names_tex, 'eps\_x');
M_.endo_names_long = char(M_.endo_names_long, 'eps_x');
M_.endo_names = char(M_.endo_names, 'hobsgm');
M_.endo_names_tex = char(M_.endo_names_tex, 'hobsgm');
M_.endo_names_long = char(M_.endo_names_long, 'hobsgm');
M_.endo_names = char(M_.endo_names, 'robs');
M_.endo_names_tex = char(M_.endo_names_tex, 'robs');
M_.endo_names_long = char(M_.endo_names_long, 'robs');
M_.endo_names = char(M_.endo_names, 'piobs');
M_.endo_names_tex = char(M_.endo_names_tex, 'piobs');
M_.endo_names_long = char(M_.endo_names_long, 'piobs');
M_.endo_names = char(M_.endo_names, 'dy');
M_.endo_names_tex = char(M_.endo_names_tex, 'dy');
M_.endo_names_long = char(M_.endo_names_long, 'dy');
M_.endo_names = char(M_.endo_names, 'dc');
M_.endo_names_tex = char(M_.endo_names_tex, 'dc');
M_.endo_names_long = char(M_.endo_names_long, 'dc');
M_.endo_names = char(M_.endo_names, 'dfi');
M_.endo_names_tex = char(M_.endo_names_tex, 'dfi');
M_.endo_names_long = char(M_.endo_names_long, 'dfi');
M_.endo_names = char(M_.endo_names, 'dw');
M_.endo_names_tex = char(M_.endo_names_tex, 'dw');
M_.endo_names_long = char(M_.endo_names_long, 'dw');
M_.endo_names = char(M_.endo_names, 'e_g');
M_.endo_names_tex = char(M_.endo_names_tex, 'e\_g');
M_.endo_names_long = char(M_.endo_names_long, 'e_g');
M_.endo_names = char(M_.endo_names, 'interest');
M_.endo_names_tex = char(M_.endo_names_tex, 'interest');
M_.endo_names_long = char(M_.endo_names_long, 'interest');
M_.endo_names = char(M_.endo_names, 'inflation');
M_.endo_names_tex = char(M_.endo_names_tex, 'inflation');
M_.endo_names_long = char(M_.endo_names_long, 'inflation');
M_.endo_names = char(M_.endo_names, 'inflationq');
M_.endo_names_tex = char(M_.endo_names_tex, 'inflationq');
M_.endo_names_long = char(M_.endo_names_long, 'inflationq');
M_.endo_names = char(M_.endo_names, 'outputgap');
M_.endo_names_tex = char(M_.endo_names_tex, 'outputgap');
M_.endo_names_long = char(M_.endo_names_long, 'outputgap');
M_.endo_names = char(M_.endo_names, 'output');
M_.endo_names_tex = char(M_.endo_names_tex, 'output');
M_.endo_names_long = char(M_.endo_names_long, 'output');
M_.endo_names = char(M_.endo_names, 'fispol');
M_.endo_names_tex = char(M_.endo_names_tex, 'fispol');
M_.endo_names_long = char(M_.endo_names_long, 'fispol');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_77');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_77');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_77');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_81');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_81');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_81');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_85');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_85');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_85');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_112');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_112');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_112');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_116');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_116');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_116');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_120');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_120');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_120');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_147');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_147');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_147');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_151');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_151');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_151');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_155');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_155');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_155');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_63_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_63\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_63_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_63_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_63\_2');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_63_2');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_65_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_65\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_65_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_65_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_65\_2');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_65_2');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_65_3');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_65\_3');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_65_3');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_64_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_64\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_64_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_64_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_64\_2');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_64_2');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_64_3');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_64\_3');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_64_3');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_61_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_61\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_61_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_61_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_61\_2');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_61_2');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_61_3');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_61\_3');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_61_3');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_63_3');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_63\_3');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_63_3');
M_.endo_partitions = struct();
M_.param_names = 'cofintintb1';
M_.param_names_tex = 'cofintintb1';
M_.param_names_long = 'cofintintb1';
M_.param_names = char(M_.param_names, 'cofintintb2');
M_.param_names_tex = char(M_.param_names_tex, 'cofintintb2');
M_.param_names_long = char(M_.param_names_long, 'cofintintb2');
M_.param_names = char(M_.param_names, 'cofintintb3');
M_.param_names_tex = char(M_.param_names_tex, 'cofintintb3');
M_.param_names_long = char(M_.param_names_long, 'cofintintb3');
M_.param_names = char(M_.param_names, 'cofintintb4');
M_.param_names_tex = char(M_.param_names_tex, 'cofintintb4');
M_.param_names_long = char(M_.param_names_long, 'cofintintb4');
M_.param_names = char(M_.param_names, 'cofintinf0');
M_.param_names_tex = char(M_.param_names_tex, 'cofintinf0');
M_.param_names_long = char(M_.param_names_long, 'cofintinf0');
M_.param_names = char(M_.param_names, 'cofintinfb1');
M_.param_names_tex = char(M_.param_names_tex, 'cofintinfb1');
M_.param_names_long = char(M_.param_names_long, 'cofintinfb1');
M_.param_names = char(M_.param_names, 'cofintinfb2');
M_.param_names_tex = char(M_.param_names_tex, 'cofintinfb2');
M_.param_names_long = char(M_.param_names_long, 'cofintinfb2');
M_.param_names = char(M_.param_names, 'cofintinfb3');
M_.param_names_tex = char(M_.param_names_tex, 'cofintinfb3');
M_.param_names_long = char(M_.param_names_long, 'cofintinfb3');
M_.param_names = char(M_.param_names, 'cofintinfb4');
M_.param_names_tex = char(M_.param_names_tex, 'cofintinfb4');
M_.param_names_long = char(M_.param_names_long, 'cofintinfb4');
M_.param_names = char(M_.param_names, 'cofintinff1');
M_.param_names_tex = char(M_.param_names_tex, 'cofintinff1');
M_.param_names_long = char(M_.param_names_long, 'cofintinff1');
M_.param_names = char(M_.param_names, 'cofintinff2');
M_.param_names_tex = char(M_.param_names_tex, 'cofintinff2');
M_.param_names_long = char(M_.param_names_long, 'cofintinff2');
M_.param_names = char(M_.param_names, 'cofintinff3');
M_.param_names_tex = char(M_.param_names_tex, 'cofintinff3');
M_.param_names_long = char(M_.param_names_long, 'cofintinff3');
M_.param_names = char(M_.param_names, 'cofintinff4');
M_.param_names_tex = char(M_.param_names_tex, 'cofintinff4');
M_.param_names_long = char(M_.param_names_long, 'cofintinff4');
M_.param_names = char(M_.param_names, 'cofintout');
M_.param_names_tex = char(M_.param_names_tex, 'cofintout');
M_.param_names_long = char(M_.param_names_long, 'cofintout');
M_.param_names = char(M_.param_names, 'cofintoutb1');
M_.param_names_tex = char(M_.param_names_tex, 'cofintoutb1');
M_.param_names_long = char(M_.param_names_long, 'cofintoutb1');
M_.param_names = char(M_.param_names, 'cofintoutb2');
M_.param_names_tex = char(M_.param_names_tex, 'cofintoutb2');
M_.param_names_long = char(M_.param_names_long, 'cofintoutb2');
M_.param_names = char(M_.param_names, 'cofintoutb3');
M_.param_names_tex = char(M_.param_names_tex, 'cofintoutb3');
M_.param_names_long = char(M_.param_names_long, 'cofintoutb3');
M_.param_names = char(M_.param_names, 'cofintoutb4');
M_.param_names_tex = char(M_.param_names_tex, 'cofintoutb4');
M_.param_names_long = char(M_.param_names_long, 'cofintoutb4');
M_.param_names = char(M_.param_names, 'cofintoutf1');
M_.param_names_tex = char(M_.param_names_tex, 'cofintoutf1');
M_.param_names_long = char(M_.param_names_long, 'cofintoutf1');
M_.param_names = char(M_.param_names, 'cofintoutf2');
M_.param_names_tex = char(M_.param_names_tex, 'cofintoutf2');
M_.param_names_long = char(M_.param_names_long, 'cofintoutf2');
M_.param_names = char(M_.param_names, 'cofintoutf3');
M_.param_names_tex = char(M_.param_names_tex, 'cofintoutf3');
M_.param_names_long = char(M_.param_names_long, 'cofintoutf3');
M_.param_names = char(M_.param_names, 'cofintoutf4');
M_.param_names_tex = char(M_.param_names_tex, 'cofintoutf4');
M_.param_names_long = char(M_.param_names_long, 'cofintoutf4');
M_.param_names = char(M_.param_names, 'cofintoutp');
M_.param_names_tex = char(M_.param_names_tex, 'cofintoutp');
M_.param_names_long = char(M_.param_names_long, 'cofintoutp');
M_.param_names = char(M_.param_names, 'cofintoutpb1');
M_.param_names_tex = char(M_.param_names_tex, 'cofintoutpb1');
M_.param_names_long = char(M_.param_names_long, 'cofintoutpb1');
M_.param_names = char(M_.param_names, 'cofintoutpb2');
M_.param_names_tex = char(M_.param_names_tex, 'cofintoutpb2');
M_.param_names_long = char(M_.param_names_long, 'cofintoutpb2');
M_.param_names = char(M_.param_names, 'cofintoutpb3');
M_.param_names_tex = char(M_.param_names_tex, 'cofintoutpb3');
M_.param_names_long = char(M_.param_names_long, 'cofintoutpb3');
M_.param_names = char(M_.param_names, 'cofintoutpb4');
M_.param_names_tex = char(M_.param_names_tex, 'cofintoutpb4');
M_.param_names_long = char(M_.param_names_long, 'cofintoutpb4');
M_.param_names = char(M_.param_names, 'cofintoutpf1');
M_.param_names_tex = char(M_.param_names_tex, 'cofintoutpf1');
M_.param_names_long = char(M_.param_names_long, 'cofintoutpf1');
M_.param_names = char(M_.param_names, 'cofintoutpf2');
M_.param_names_tex = char(M_.param_names_tex, 'cofintoutpf2');
M_.param_names_long = char(M_.param_names_long, 'cofintoutpf2');
M_.param_names = char(M_.param_names, 'cofintoutpf3');
M_.param_names_tex = char(M_.param_names_tex, 'cofintoutpf3');
M_.param_names_long = char(M_.param_names_long, 'cofintoutpf3');
M_.param_names = char(M_.param_names, 'cofintoutpf4');
M_.param_names_tex = char(M_.param_names_tex, 'cofintoutpf4');
M_.param_names_long = char(M_.param_names_long, 'cofintoutpf4');
M_.param_names = char(M_.param_names, 'std_r_');
M_.param_names_tex = char(M_.param_names_tex, 'std\_r\_');
M_.param_names_long = char(M_.param_names_long, 'std_r_');
M_.param_names = char(M_.param_names, 'std_r_quart');
M_.param_names_tex = char(M_.param_names_tex, 'std\_r\_quart');
M_.param_names_long = char(M_.param_names_long, 'std_r_quart');
M_.param_names = char(M_.param_names, 'coffispol');
M_.param_names_tex = char(M_.param_names_tex, 'coffispol');
M_.param_names_long = char(M_.param_names_long, 'coffispol');
M_.param_names = char(M_.param_names, 'beta');
M_.param_names_tex = char(M_.param_names_tex, 'beta');
M_.param_names_long = char(M_.param_names_long, 'beta');
M_.param_names = char(M_.param_names, 'phi');
M_.param_names_tex = char(M_.param_names_tex, 'phi');
M_.param_names_long = char(M_.param_names_long, 'phi');
M_.param_names = char(M_.param_names, 'chi');
M_.param_names_tex = char(M_.param_names_tex, 'chi');
M_.param_names_long = char(M_.param_names_long, 'chi');
M_.param_names = char(M_.param_names, 'alpha');
M_.param_names_tex = char(M_.param_names_tex, 'alpha');
M_.param_names_long = char(M_.param_names_long, 'alpha');
M_.param_names = char(M_.param_names, 'delta');
M_.param_names_tex = char(M_.param_names_tex, 'delta');
M_.param_names_long = char(M_.param_names_long, 'delta');
M_.param_names = char(M_.param_names, 'epsilon');
M_.param_names_tex = char(M_.param_names_tex, 'epsilon');
M_.param_names_long = char(M_.param_names_long, 'epsilon');
M_.param_names = char(M_.param_names, 'epsilon_w');
M_.param_names_tex = char(M_.param_names_tex, 'epsilon\_w');
M_.param_names_long = char(M_.param_names_long, 'epsilon_w');
M_.param_names = char(M_.param_names, 'G_Y');
M_.param_names_tex = char(M_.param_names_tex, 'G\_Y');
M_.param_names_long = char(M_.param_names_long, 'G_Y');
M_.param_names = char(M_.param_names, 'h');
M_.param_names_tex = char(M_.param_names_tex, 'h');
M_.param_names_long = char(M_.param_names_long, 'h');
M_.param_names = char(M_.param_names, 'lambda');
M_.param_names_tex = char(M_.param_names_tex, 'lambda');
M_.param_names_long = char(M_.param_names_long, 'lambda');
M_.param_names = char(M_.param_names, 'theta');
M_.param_names_tex = char(M_.param_names_tex, 'theta');
M_.param_names_long = char(M_.param_names_long, 'theta');
M_.param_names = char(M_.param_names, 'zeta');
M_.param_names_tex = char(M_.param_names_tex, 'zeta');
M_.param_names_long = char(M_.param_names_long, 'zeta');
M_.param_names = char(M_.param_names, 'ksi');
M_.param_names_tex = char(M_.param_names_tex, 'ksi');
M_.param_names_long = char(M_.param_names_long, 'ksi');
M_.param_names = char(M_.param_names, 'sig_p');
M_.param_names_tex = char(M_.param_names_tex, 'sig\_p');
M_.param_names_long = char(M_.param_names_long, 'sig_p');
M_.param_names = char(M_.param_names, 'sig_pi');
M_.param_names_tex = char(M_.param_names_tex, 'sig\_pi');
M_.param_names_long = char(M_.param_names_long, 'sig_pi');
M_.param_names = char(M_.param_names, 'sig_w');
M_.param_names_tex = char(M_.param_names_tex, 'sig\_w');
M_.param_names_long = char(M_.param_names_long, 'sig_w');
M_.param_names = char(M_.param_names, 'sig_wi');
M_.param_names_tex = char(M_.param_names_tex, 'sig\_wi');
M_.param_names_long = char(M_.param_names_long, 'sig_wi');
M_.param_names = char(M_.param_names, 'sig_E');
M_.param_names_tex = char(M_.param_names_tex, 'sig\_E');
M_.param_names_long = char(M_.param_names_long, 'sig_E');
M_.param_names = char(M_.param_names, 'M');
M_.param_names_tex = char(M_.param_names_tex, 'M');
M_.param_names_long = char(M_.param_names_long, 'M');
M_.param_names = char(M_.param_names, 'rho_r');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_r');
M_.param_names_long = char(M_.param_names_long, 'rho_r');
M_.param_names = char(M_.param_names, 'rho_ri');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_ri');
M_.param_names_long = char(M_.param_names_long, 'rho_ri');
M_.param_names = char(M_.param_names, 'rho_PI');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_PI');
M_.param_names_long = char(M_.param_names_long, 'rho_PI');
M_.param_names = char(M_.param_names, 'rho_Y');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_Y');
M_.param_names_long = char(M_.param_names_long, 'rho_Y');
M_.param_names = char(M_.param_names, 'rho_A');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_A');
M_.param_names_long = char(M_.param_names_long, 'rho_A');
M_.param_names = char(M_.param_names, 'rho_G');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_G');
M_.param_names_long = char(M_.param_names_long, 'rho_G');
M_.param_names = char(M_.param_names, 'rho_X');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_X');
M_.param_names_long = char(M_.param_names_long, 'rho_X');
M_.param_names = char(M_.param_names, 'rho_k');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_k');
M_.param_names_long = char(M_.param_names_long, 'rho_k');
M_.param_names = char(M_.param_names, 'rho_W');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_W');
M_.param_names_long = char(M_.param_names_long, 'rho_W');
M_.param_names = char(M_.param_names, 'rho_P');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_P');
M_.param_names_long = char(M_.param_names_long, 'rho_P');
M_.param_names = char(M_.param_names, 'THETA');
M_.param_names_tex = char(M_.param_names_tex, 'THETA');
M_.param_names_long = char(M_.param_names_long, 'THETA');
M_.param_names = char(M_.param_names, 'rho_DY');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_DY');
M_.param_names_long = char(M_.param_names_long, 'rho_DY');
M_.param_names = char(M_.param_names, 'RK');
M_.param_names_tex = char(M_.param_names_tex, 'RK');
M_.param_names_long = char(M_.param_names_long, 'RK');
M_.param_names = char(M_.param_names, 'constelab');
M_.param_names_tex = char(M_.param_names_tex, 'constelab');
M_.param_names_long = char(M_.param_names_long, 'constelab');
M_.param_names = char(M_.param_names, 'picbar');
M_.param_names_tex = char(M_.param_names_tex, 'picbar');
M_.param_names_long = char(M_.param_names_long, 'picbar');
M_.param_names = char(M_.param_names, 'trend');
M_.param_names_tex = char(M_.param_names_tex, 'trend');
M_.param_names_long = char(M_.param_names_long, 'trend');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 7;
M_.endo_nbr = 88;
M_.param_nbr = 69;
M_.orig_endo_nbr = 67;
M_.aux_vars(1).endo_index = 68;
M_.aux_vars(1).type = 0;
M_.aux_vars(2).endo_index = 69;
M_.aux_vars(2).type = 0;
M_.aux_vars(3).endo_index = 70;
M_.aux_vars(3).type = 0;
M_.aux_vars(4).endo_index = 71;
M_.aux_vars(4).type = 0;
M_.aux_vars(5).endo_index = 72;
M_.aux_vars(5).type = 0;
M_.aux_vars(6).endo_index = 73;
M_.aux_vars(6).type = 0;
M_.aux_vars(7).endo_index = 74;
M_.aux_vars(7).type = 0;
M_.aux_vars(8).endo_index = 75;
M_.aux_vars(8).type = 0;
M_.aux_vars(9).endo_index = 76;
M_.aux_vars(9).type = 0;
M_.aux_vars(10).endo_index = 77;
M_.aux_vars(10).type = 1;
M_.aux_vars(10).orig_index = 64;
M_.aux_vars(10).orig_lead_lag = -1;
M_.aux_vars(11).endo_index = 78;
M_.aux_vars(11).type = 1;
M_.aux_vars(11).orig_index = 64;
M_.aux_vars(11).orig_lead_lag = -2;
M_.aux_vars(12).endo_index = 79;
M_.aux_vars(12).type = 1;
M_.aux_vars(12).orig_index = 66;
M_.aux_vars(12).orig_lead_lag = -1;
M_.aux_vars(13).endo_index = 80;
M_.aux_vars(13).type = 1;
M_.aux_vars(13).orig_index = 66;
M_.aux_vars(13).orig_lead_lag = -2;
M_.aux_vars(14).endo_index = 81;
M_.aux_vars(14).type = 1;
M_.aux_vars(14).orig_index = 66;
M_.aux_vars(14).orig_lead_lag = -3;
M_.aux_vars(15).endo_index = 82;
M_.aux_vars(15).type = 1;
M_.aux_vars(15).orig_index = 65;
M_.aux_vars(15).orig_lead_lag = -1;
M_.aux_vars(16).endo_index = 83;
M_.aux_vars(16).type = 1;
M_.aux_vars(16).orig_index = 65;
M_.aux_vars(16).orig_lead_lag = -2;
M_.aux_vars(17).endo_index = 84;
M_.aux_vars(17).type = 1;
M_.aux_vars(17).orig_index = 65;
M_.aux_vars(17).orig_lead_lag = -3;
M_.aux_vars(18).endo_index = 85;
M_.aux_vars(18).type = 1;
M_.aux_vars(18).orig_index = 62;
M_.aux_vars(18).orig_lead_lag = -1;
M_.aux_vars(19).endo_index = 86;
M_.aux_vars(19).type = 1;
M_.aux_vars(19).orig_index = 62;
M_.aux_vars(19).orig_lead_lag = -2;
M_.aux_vars(20).endo_index = 87;
M_.aux_vars(20).type = 1;
M_.aux_vars(20).orig_index = 62;
M_.aux_vars(20).orig_lead_lag = -3;
M_.aux_vars(21).endo_index = 88;
M_.aux_vars(21).type = 1;
M_.aux_vars(21).orig_index = 64;
M_.aux_vars(21).orig_lead_lag = -3;
options_.varobs = cell(1);
options_.varobs(1)  = {'dy'};
options_.varobs(2)  = {'dc'};
options_.varobs(3)  = {'dfi'};
options_.varobs(4)  = {'hobsgm'};
options_.varobs(5)  = {'piobs'};
options_.varobs(6)  = {'dw'};
options_.varobs(7)  = {'robs'};
options_.varobs_id = [ 57 58 59 54 56 60 55  ];
M_.Sigma_e = zeros(7, 7);
M_.Correlation_matrix = eye(7, 7);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.linear = 1;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('US_VI16gk_static');
erase_compiled_function('US_VI16gk_dynamic');
M_.orig_eq_nbr = 67;
M_.eq_nbr = 88;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 1 44 0;
 2 45 132;
 0 46 0;
 3 47 0;
 4 48 133;
 5 49 0;
 0 50 134;
 0 51 0;
 0 52 135;
 0 53 136;
 0 54 137;
 0 55 0;
 0 56 0;
 0 57 0;
 6 58 0;
 7 59 0;
 0 60 0;
 8 61 0;
 0 62 0;
 9 63 138;
 10 64 0;
 0 65 0;
 11 66 0;
 12 67 139;
 0 68 0;
 13 69 140;
 0 70 0;
 14 71 0;
 15 72 141;
 16 73 0;
 0 74 142;
 0 75 0;
 0 76 143;
 0 77 144;
 0 78 145;
 0 79 0;
 0 80 0;
 0 81 0;
 17 82 0;
 18 83 0;
 0 84 0;
 19 85 0;
 0 86 0;
 0 87 0;
 20 88 0;
 0 89 0;
 21 90 0;
 22 91 0;
 23 92 0;
 24 93 0;
 25 94 0;
 26 95 0;
 27 96 0;
 0 97 0;
 0 98 0;
 0 99 0;
 0 100 0;
 0 101 0;
 0 102 0;
 0 103 0;
 0 104 0;
 28 105 0;
 0 106 0;
 29 107 146;
 30 108 147;
 31 109 148;
 0 110 0;
 0 111 149;
 0 112 150;
 0 113 151;
 0 114 152;
 0 115 153;
 0 116 154;
 0 117 155;
 0 118 156;
 0 119 157;
 32 120 0;
 33 121 0;
 34 122 0;
 35 123 0;
 36 124 0;
 37 125 0;
 38 126 0;
 39 127 0;
 40 128 0;
 41 129 0;
 42 130 0;
 43 131 0;]';
M_.nstatic = 28;
M_.nfwrd   = 17;
M_.npred   = 34;
M_.nboth   = 9;
M_.nsfwrd   = 26;
M_.nspred   = 43;
M_.ndynamic   = 60;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:7];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(88, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(7, 1);
M_.params = NaN(69, 1);
M_.NNZDerivatives = [316; 0; -1];
thispath = pwd;                                                           
cd('..');                                                                
load policy_param.mat;                                                   
for i=1:33                                                               
deep_parameter_name = M_.param_names(i,:);                           
eval(['M_.params(i)  = ' deep_parameter_name ' ;'])                  
end                                                                      
cd(thispath);                                                            
M_.params( 34 ) = 1;
coffispol = M_.params( 34 );
M_.params( 38 ) = 0.33;
alpha = M_.params( 38 );
M_.params( 35 ) = 0.99;
beta = M_.params( 35 );
M_.params( 39 ) = 0.025;
delta = M_.params( 39 );
M_.params( 40 ) = 6;
epsilon = M_.params( 40 );
M_.params( 41 ) = 6;
epsilon_w = M_.params( 41 );
M_.params( 53 ) = M_.params(40)/(M_.params(40)-1);
M = M_.params( 53 );
M_.params( 42 ) = 0.20;
G_Y = M_.params( 42 );
M_.params( 36 ) = 1.81;
phi = M_.params( 36 );
M_.params( 43 ) = 0.44;
h = M_.params( 43 );
M_.params( 44 ) = 0.5152;
lambda = M_.params( 44 );
M_.params( 45 ) = 0.9715;
theta = M_.params( 45 );
M_.params( 37 ) = 0.001;
chi = M_.params( 37 );
M_.params( 64 ) = 1.34;
THETA = M_.params( 64 );
M_.params( 48 ) = 0.89;
sig_p = M_.params( 48 );
M_.params( 49 ) = 0.36;
sig_pi = M_.params( 49 );
M_.params( 50 ) = 0.84;
sig_w = M_.params( 50 );
M_.params( 51 ) = 0.34;
sig_wi = M_.params( 51 );
M_.params( 52 ) = 0.8;
sig_E = M_.params( 52 );
M_.params( 46 ) = 0.82;
zeta = M_.params( 46 );
M_.params( 47 ) = 4.27;
ksi = M_.params( 47 );
M_.params( 56 ) = 1.73;
rho_PI = M_.params( 56 );
M_.params( 57 ) = 0.09;
rho_Y = M_.params( 57 );
M_.params( 65 ) = 0.08;
rho_DY = M_.params( 65 );
M_.params( 54 ) = 0.89;
rho_r = M_.params( 54 );
M_.params( 58 ) = 0.94;
rho_A = M_.params( 58 );
M_.params( 60 ) = 0.99;
rho_X = M_.params( 60 );
M_.params( 59 ) = 0.96;
rho_G = M_.params( 59 );
M_.params( 62 ) = 0.20;
rho_W = M_.params( 62 );
M_.params( 63 ) = 0.31;
rho_P = M_.params( 63 );
M_.params( 61 ) = 0.99;
rho_k = M_.params( 61 );
M_.params( 55 ) = 0.23;
rho_ri = M_.params( 55 );
M_.params( 66 ) = 1.013860066271978;
RK = M_.params( 66 );
M_.params( 67 ) = 0;
constelab = M_.params( 67 );
M_.params( 68 ) = 0.63;
picbar = M_.params( 68 );
M_.params( 69 ) = 0.3;
trend = M_.params( 69 );
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (2.11)^2;
M_.Sigma_e(2, 2) = (0.17)^2;
M_.Sigma_e(3, 3) = (0.96)^2;
M_.Sigma_e(4, 4) = (0.12)^2;
M_.Sigma_e(5, 5) = (0.09)^2;
M_.Sigma_e(6, 6) = (0.11)^2;
M_.Sigma_e(7, 7) = (1.47)^2;
estim_params_.var_exo = [];
estim_params_.var_endo = [];
estim_params_.corrx = [];
estim_params_.corrn = [];
estim_params_.param_vals = [];
estim_params_.var_exo = [estim_params_.var_exo; 3, 0.3974, 0.01, 25, 4, 0.1, 2, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 1, 1.0534, 0.01, 50, 4, 0.1, 2, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 6, 0.1224, 0.01, 25, 4, 0.1, 2, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 2, 0.1705, 0.025, 25, 4, 0.1, 2, NaN, NaN, NaN ];
estim_params_.var_endo = [estim_params_.var_endo; 61, 2.2030, 0.01, 50, 4, 0.1, 2, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 5, 0.1288, 0.01, 25, 4, 0.1, 2, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 4, 0.2806, 0.01, 25, 4, 0.1, 2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 58, 0.9493, .01, .99999, 1, 0.5, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 61, 0.9802, .01, .99999, 1, 0.5, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 59, 0.9624, .01, .9999999, 1, 0.5, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 60, 0.9914, .01, .9999999, 1, 0.5, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 55, 0.2154, (-0.02), .9999, 1, 0.5, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 63, 0.2101, .01, .99999, 1, 0.5, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 62, 0.1907, .001, .9999, 1, 0.5, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 47, 3.8293, 0.0001, 15, 3, 4, 1.5, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 43, 0.4279, 0.1, 0.99, 1, 0.7, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 50, 0.8453, 0.25, 0.99, 1, 0.75, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 48, 0.8953, 0.5, 0.97, 1, 0.75, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 64, 1.3488, 1.0, 3, 3, 1.45, 0.125, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 36, 1.6665, 0.1, 3.5, 2, 0.33, 0.25, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 51, 0.3078, 0.01, 0.99, 1, 0.5, 0.15, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 49, 0.4257, 0.01, 0.99, 1, 0.5, 0.15, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 46, 0.8554, 0.0001, 1, 1, 0.25, 0.15, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 56, 1.8855, 1.0, 3, 3, 1.7, 0.15, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 54, 0.8495, 0.35, 0.975, 1, 0.75, 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 57, 0.0743, (-0.065), 0.5, 2, .125, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 65, 0.2004, (-0.1), 0.5, 3, 0.0625, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 68, 0.6473, 0.1, 2.0, 2, 0.625, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 69, 0.3029, 0.001, 0.8, 3, 0.4, 0.10, NaN, NaN, NaN ];
options_.plot_priors=0;
options_.irf = 60;
options_.nograph = 1;
var_list_ = char();
info = stoch_simul(var_list_);
save('US_VI16gk_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('US_VI16gk_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('US_VI16gk_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('US_VI16gk_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('US_VI16gk_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('US_VI16gk_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('US_VI16gk_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
