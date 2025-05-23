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
M_.fname = 'NK_CK08';
M_.dynare_version = '4.5.6';
oo_.dynare_version = '4.5.6';
options_.dynare_version = '4.5.6';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('NK_CK08.log');
M_.exo_names = 'inno_ebt';
M_.exo_names_tex = 'inno\_ebt';
M_.exo_names_long = 'inno_ebt';
M_.exo_names = char(M_.exo_names, 'inno_zt');
M_.exo_names_tex = char(M_.exo_names_tex, 'inno\_zt');
M_.exo_names_long = char(M_.exo_names_long, 'inno_zt');
M_.exo_names = char(M_.exo_names, 'interest_');
M_.exo_names_tex = char(M_.exo_names_tex, 'interest\_');
M_.exo_names_long = char(M_.exo_names_long, 'interest_');
M_.exo_names = char(M_.exo_names, 'fiscal_');
M_.exo_names_tex = char(M_.exo_names_tex, 'fiscal\_');
M_.exo_names_long = char(M_.exo_names_long, 'fiscal_');
M_.endo_names = 'ct';
M_.endo_names_tex = 'ct';
M_.endo_names_long = 'ct';
M_.endo_names = char(M_.endo_names, 'deltaFt');
M_.endo_names_tex = char(M_.endo_names_tex, 'deltaFt');
M_.endo_names_long = char(M_.endo_names_long, 'deltaFt');
M_.endo_names = char(M_.endo_names, 'deltaWt');
M_.endo_names_tex = char(M_.endo_names_tex, 'deltaWt');
M_.endo_names_long = char(M_.endo_names_long, 'deltaWt');
M_.endo_names = char(M_.endo_names, 'Deltastart');
M_.endo_names_tex = char(M_.endo_names_tex, 'Deltastart');
M_.endo_names_long = char(M_.endo_names_long, 'Deltastart');
M_.endo_names = char(M_.endo_names, 'ht');
M_.endo_names_tex = char(M_.endo_names_tex, 'ht');
M_.endo_names_long = char(M_.endo_names_long, 'ht');
M_.endo_names = char(M_.endo_names, 'Jstart');
M_.endo_names_tex = char(M_.endo_names_tex, 'Jstart');
M_.endo_names_long = char(M_.endo_names_long, 'Jstart');
M_.endo_names = char(M_.endo_names, 'lambdat');
M_.endo_names_tex = char(M_.endo_names_tex, 'lambdat');
M_.endo_names_long = char(M_.endo_names_long, 'lambdat');
M_.endo_names = char(M_.endo_names, 'mct');
M_.endo_names_tex = char(M_.endo_names_tex, 'mct');
M_.endo_names_long = char(M_.endo_names_long, 'mct');
M_.endo_names = char(M_.endo_names, 'mt');
M_.endo_names_tex = char(M_.endo_names_tex, 'mt');
M_.endo_names_long = char(M_.endo_names_long, 'mt');
M_.endo_names = char(M_.endo_names, 'nt');
M_.endo_names_tex = char(M_.endo_names_tex, 'nt');
M_.endo_names_long = char(M_.endo_names_long, 'nt');
M_.endo_names = char(M_.endo_names, 'Pit');
M_.endo_names_tex = char(M_.endo_names_tex, 'Pit');
M_.endo_names_long = char(M_.endo_names_long, 'Pit');
M_.endo_names = char(M_.endo_names, 'Piannt');
M_.endo_names_tex = char(M_.endo_names_tex, 'Piannt');
M_.endo_names_long = char(M_.endo_names_long, 'Piannt');
M_.endo_names = char(M_.endo_names, 'qt');
M_.endo_names_tex = char(M_.endo_names_tex, 'qt');
M_.endo_names_long = char(M_.endo_names_long, 'qt');
M_.endo_names = char(M_.endo_names, 'Rt');
M_.endo_names_tex = char(M_.endo_names_tex, 'Rt');
M_.endo_names_long = char(M_.endo_names_long, 'Rt');
M_.endo_names = char(M_.endo_names, 'st');
M_.endo_names_tex = char(M_.endo_names_tex, 'st');
M_.endo_names_long = char(M_.endo_names_long, 'st');
M_.endo_names = char(M_.endo_names, 'ut');
M_.endo_names_tex = char(M_.endo_names_tex, 'ut');
M_.endo_names_long = char(M_.endo_names_long, 'ut');
M_.endo_names = char(M_.endo_names, 'vt');
M_.endo_names_tex = char(M_.endo_names_tex, 'vt');
M_.endo_names_long = char(M_.endo_names_long, 'vt');
M_.endo_names = char(M_.endo_names, 'wstart');
M_.endo_names_tex = char(M_.endo_names_tex, 'wstart');
M_.endo_names_long = char(M_.endo_names_long, 'wstart');
M_.endo_names = char(M_.endo_names, 'wt');
M_.endo_names_tex = char(M_.endo_names_tex, 'wt');
M_.endo_names_long = char(M_.endo_names_long, 'wt');
M_.endo_names = char(M_.endo_names, 'xLt');
M_.endo_names_tex = char(M_.endo_names_tex, 'xLt');
M_.endo_names_long = char(M_.endo_names_long, 'xLt');
M_.endo_names = char(M_.endo_names, 'yt');
M_.endo_names_tex = char(M_.endo_names_tex, 'yt');
M_.endo_names_long = char(M_.endo_names_long, 'yt');
M_.endo_names = char(M_.endo_names, 'ebt');
M_.endo_names_tex = char(M_.endo_names_tex, 'ebt');
M_.endo_names_long = char(M_.endo_names_long, 'ebt');
M_.endo_names = char(M_.endo_names, 'emoneyt');
M_.endo_names_tex = char(M_.endo_names_tex, 'emoneyt');
M_.endo_names_long = char(M_.endo_names_long, 'emoneyt');
M_.endo_names = char(M_.endo_names, 'gt');
M_.endo_names_tex = char(M_.endo_names_tex, 'gt');
M_.endo_names_long = char(M_.endo_names_long, 'gt');
M_.endo_names = char(M_.endo_names, 'zt');
M_.endo_names_tex = char(M_.endo_names_tex, 'zt');
M_.endo_names_long = char(M_.endo_names_long, 'zt');
M_.endo_names = char(M_.endo_names, 'g_');
M_.endo_names_tex = char(M_.endo_names_tex, 'g\_');
M_.endo_names_long = char(M_.endo_names_long, 'g_');
M_.endo_names = char(M_.endo_names, 'mon_shock');
M_.endo_names_tex = char(M_.endo_names_tex, 'mon\_shock');
M_.endo_names_long = char(M_.endo_names_long, 'mon_shock');
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
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_71');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_71');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_71');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_75');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_75');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_75');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_79');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_79');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_79');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_106');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_106');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_106');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_110');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_110');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_110');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_114');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_114');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_114');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_141');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_141');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_141');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_145');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_145');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_145');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_149');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_149');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_149');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_31_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_31\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_31_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_31_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_31\_2');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_31_2');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_31_3');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_31\_3');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_31_3');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_30_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_30\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_30_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_30_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_30\_2');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_30_2');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_30_3');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_30\_3');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_30_3');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_27_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_27\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_27_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_27_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_27\_2');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_27_2');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_27_3');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_27\_3');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_27_3');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_29_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_29\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_29_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_29_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_29\_2');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_29_2');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_29_3');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_29\_3');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_29_3');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_10_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_10\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_10_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_10_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_10\_2');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_10_2');
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
M_.param_names = char(M_.param_names, 'rho_mon');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_mon');
M_.param_names_long = char(M_.param_names_long, 'rho_mon');
M_.param_names = char(M_.param_names, 'bet');
M_.param_names_tex = char(M_.param_names_tex, 'bet');
M_.param_names_long = char(M_.param_names_long, 'bet');
M_.param_names = char(M_.param_names, 'epsilon');
M_.param_names_tex = char(M_.param_names_tex, 'epsilon');
M_.param_names_long = char(M_.param_names_long, 'epsilon');
M_.param_names = char(M_.param_names, 'habit');
M_.param_names_tex = char(M_.param_names_tex, 'habit');
M_.param_names_long = char(M_.param_names_long, 'habit');
M_.param_names = char(M_.param_names, 'sig');
M_.param_names_tex = char(M_.param_names_tex, 'sig');
M_.param_names_long = char(M_.param_names_long, 'sig');
M_.param_names = char(M_.param_names, 'vphi');
M_.param_names_tex = char(M_.param_names_tex, 'vphi');
M_.param_names_long = char(M_.param_names_long, 'vphi');
M_.param_names = char(M_.param_names, 'omega');
M_.param_names_tex = char(M_.param_names_tex, 'omega');
M_.param_names_long = char(M_.param_names_long, 'omega');
M_.param_names = char(M_.param_names, 'price_index');
M_.param_names_tex = char(M_.param_names_tex, 'price\_index');
M_.param_names_long = char(M_.param_names_long, 'price_index');
M_.param_names = char(M_.param_names, 'xi');
M_.param_names_tex = char(M_.param_names_tex, 'xi');
M_.param_names_long = char(M_.param_names_long, 'xi');
M_.param_names = char(M_.param_names, 'eta');
M_.param_names_tex = char(M_.param_names_tex, 'eta');
M_.param_names_long = char(M_.param_names_long, 'eta');
M_.param_names = char(M_.param_names, 'gamma');
M_.param_names_tex = char(M_.param_names_tex, 'gamma');
M_.param_names_long = char(M_.param_names_long, 'gamma');
M_.param_names = char(M_.param_names, 'wage_index');
M_.param_names_tex = char(M_.param_names_tex, 'wage\_index');
M_.param_names_long = char(M_.param_names_long, 'wage_index');
M_.param_names = char(M_.param_names, 'vtheta');
M_.param_names_tex = char(M_.param_names_tex, 'vtheta');
M_.param_names_long = char(M_.param_names_long, 'vtheta');
M_.param_names = char(M_.param_names, 'alp');
M_.param_names_tex = char(M_.param_names_tex, 'alp');
M_.param_names_long = char(M_.param_names_long, 'alp');
M_.param_names = char(M_.param_names, 'rho_eb');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_eb');
M_.param_names_long = char(M_.param_names_long, 'rho_eb');
M_.param_names = char(M_.param_names, 'rho_emoney');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_emoney');
M_.param_names_long = char(M_.param_names_long, 'rho_emoney');
M_.param_names = char(M_.param_names, 'rho_g');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_g');
M_.param_names_long = char(M_.param_names_long, 'rho_g');
M_.param_names = char(M_.param_names, 'rho_z');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_z');
M_.param_names_long = char(M_.param_names_long, 'rho_z');
M_.param_names = char(M_.param_names, 'gamma_R');
M_.param_names_tex = char(M_.param_names_tex, 'gamma\_R');
M_.param_names_long = char(M_.param_names_long, 'gamma_R');
M_.param_names = char(M_.param_names, 'gamma_Pi');
M_.param_names_tex = char(M_.param_names_tex, 'gamma\_Pi');
M_.param_names_long = char(M_.param_names_long, 'gamma_Pi');
M_.param_names = char(M_.param_names, 'gamma_y');
M_.param_names_tex = char(M_.param_names_tex, 'gamma\_y');
M_.param_names_long = char(M_.param_names_long, 'gamma_y');
M_.param_names = char(M_.param_names, 'sig_innoeb');
M_.param_names_tex = char(M_.param_names_tex, 'sig\_innoeb');
M_.param_names_long = char(M_.param_names_long, 'sig_innoeb');
M_.param_names = char(M_.param_names, 'sig_monpol');
M_.param_names_tex = char(M_.param_names_tex, 'sig\_monpol');
M_.param_names_long = char(M_.param_names_long, 'sig_monpol');
M_.param_names = char(M_.param_names, 'sig_innog');
M_.param_names_tex = char(M_.param_names_tex, 'sig\_innog');
M_.param_names_long = char(M_.param_names_long, 'sig_innog');
M_.param_names = char(M_.param_names, 'sig_innoz');
M_.param_names_tex = char(M_.param_names_tex, 'sig\_innoz');
M_.param_names_long = char(M_.param_names_long, 'sig_innoz');
M_.param_names = char(M_.param_names, 'kappa');
M_.param_names_tex = char(M_.param_names_tex, 'kappa');
M_.param_names_long = char(M_.param_names_long, 'kappa');
M_.param_names = char(M_.param_names, 'Phi');
M_.param_names_tex = char(M_.param_names_tex, 'Phi');
M_.param_names_long = char(M_.param_names_long, 'Phi');
M_.param_names = char(M_.param_names, 'Phi_y');
M_.param_names_tex = char(M_.param_names_tex, 'Phi\_y');
M_.param_names_long = char(M_.param_names_long, 'Phi_y');
M_.param_names = char(M_.param_names, 'Afactor');
M_.param_names_tex = char(M_.param_names_tex, 'Afactor');
M_.param_names_long = char(M_.param_names_long, 'Afactor');
M_.param_names = char(M_.param_names, 'cbar');
M_.param_names_tex = char(M_.param_names_tex, 'cbar');
M_.param_names_long = char(M_.param_names_long, 'cbar');
M_.param_names = char(M_.param_names, 'Deltabar');
M_.param_names_tex = char(M_.param_names_tex, 'Deltabar');
M_.param_names_long = char(M_.param_names_long, 'Deltabar');
M_.param_names = char(M_.param_names, 'deltaWbar');
M_.param_names_tex = char(M_.param_names_tex, 'deltaWbar');
M_.param_names_long = char(M_.param_names_long, 'deltaWbar');
M_.param_names = char(M_.param_names, 'gbar');
M_.param_names_tex = char(M_.param_names_tex, 'gbar');
M_.param_names_long = char(M_.param_names_long, 'gbar');
M_.param_names = char(M_.param_names, 'hbar');
M_.param_names_tex = char(M_.param_names_tex, 'hbar');
M_.param_names_long = char(M_.param_names_long, 'hbar');
M_.param_names = char(M_.param_names, 'Jbar');
M_.param_names_tex = char(M_.param_names_tex, 'Jbar');
M_.param_names_long = char(M_.param_names_long, 'Jbar');
M_.param_names = char(M_.param_names, 'mbar');
M_.param_names_tex = char(M_.param_names_tex, 'mbar');
M_.param_names_long = char(M_.param_names_long, 'mbar');
M_.param_names = char(M_.param_names, 'mcbar');
M_.param_names_tex = char(M_.param_names_tex, 'mcbar');
M_.param_names_long = char(M_.param_names_long, 'mcbar');
M_.param_names = char(M_.param_names, 'mrsbar');
M_.param_names_tex = char(M_.param_names_tex, 'mrsbar');
M_.param_names_long = char(M_.param_names_long, 'mrsbar');
M_.param_names = char(M_.param_names, 'nbar');
M_.param_names_tex = char(M_.param_names_tex, 'nbar');
M_.param_names_long = char(M_.param_names_long, 'nbar');
M_.param_names = char(M_.param_names, 'qbar');
M_.param_names_tex = char(M_.param_names_tex, 'qbar');
M_.param_names_long = char(M_.param_names_long, 'qbar');
M_.param_names = char(M_.param_names, 'sbar');
M_.param_names_tex = char(M_.param_names_tex, 'sbar');
M_.param_names_long = char(M_.param_names_long, 'sbar');
M_.param_names = char(M_.param_names, 'ubar');
M_.param_names_tex = char(M_.param_names_tex, 'ubar');
M_.param_names_long = char(M_.param_names_long, 'ubar');
M_.param_names = char(M_.param_names, 'vbar');
M_.param_names_tex = char(M_.param_names_tex, 'vbar');
M_.param_names_long = char(M_.param_names_long, 'vbar');
M_.param_names = char(M_.param_names, 'wbar');
M_.param_names_tex = char(M_.param_names_tex, 'wbar');
M_.param_names_long = char(M_.param_names_long, 'wbar');
M_.param_names = char(M_.param_names, 'ybar');
M_.param_names_tex = char(M_.param_names_tex, 'ybar');
M_.param_names_long = char(M_.param_names_long, 'ybar');
M_.param_names = char(M_.param_names, 'b_wh');
M_.param_names_tex = char(M_.param_names_tex, 'b\_wh');
M_.param_names_long = char(M_.param_names_long, 'b_wh');
M_.param_names = char(M_.param_names, 'Pibar');
M_.param_names_tex = char(M_.param_names_tex, 'Pibar');
M_.param_names_long = char(M_.param_names_long, 'Pibar');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 4;
M_.endo_nbr = 56;
M_.param_nbr = 81;
M_.orig_endo_nbr = 33;
M_.aux_vars(1).endo_index = 34;
M_.aux_vars(1).type = 0;
M_.aux_vars(2).endo_index = 35;
M_.aux_vars(2).type = 0;
M_.aux_vars(3).endo_index = 36;
M_.aux_vars(3).type = 0;
M_.aux_vars(4).endo_index = 37;
M_.aux_vars(4).type = 0;
M_.aux_vars(5).endo_index = 38;
M_.aux_vars(5).type = 0;
M_.aux_vars(6).endo_index = 39;
M_.aux_vars(6).type = 0;
M_.aux_vars(7).endo_index = 40;
M_.aux_vars(7).type = 0;
M_.aux_vars(8).endo_index = 41;
M_.aux_vars(8).type = 0;
M_.aux_vars(9).endo_index = 42;
M_.aux_vars(9).type = 0;
M_.aux_vars(10).endo_index = 43;
M_.aux_vars(10).type = 1;
M_.aux_vars(10).orig_index = 32;
M_.aux_vars(10).orig_lead_lag = -1;
M_.aux_vars(11).endo_index = 44;
M_.aux_vars(11).type = 1;
M_.aux_vars(11).orig_index = 32;
M_.aux_vars(11).orig_lead_lag = -2;
M_.aux_vars(12).endo_index = 45;
M_.aux_vars(12).type = 1;
M_.aux_vars(12).orig_index = 32;
M_.aux_vars(12).orig_lead_lag = -3;
M_.aux_vars(13).endo_index = 46;
M_.aux_vars(13).type = 1;
M_.aux_vars(13).orig_index = 31;
M_.aux_vars(13).orig_lead_lag = -1;
M_.aux_vars(14).endo_index = 47;
M_.aux_vars(14).type = 1;
M_.aux_vars(14).orig_index = 31;
M_.aux_vars(14).orig_lead_lag = -2;
M_.aux_vars(15).endo_index = 48;
M_.aux_vars(15).type = 1;
M_.aux_vars(15).orig_index = 31;
M_.aux_vars(15).orig_lead_lag = -3;
M_.aux_vars(16).endo_index = 49;
M_.aux_vars(16).type = 1;
M_.aux_vars(16).orig_index = 28;
M_.aux_vars(16).orig_lead_lag = -1;
M_.aux_vars(17).endo_index = 50;
M_.aux_vars(17).type = 1;
M_.aux_vars(17).orig_index = 28;
M_.aux_vars(17).orig_lead_lag = -2;
M_.aux_vars(18).endo_index = 51;
M_.aux_vars(18).type = 1;
M_.aux_vars(18).orig_index = 28;
M_.aux_vars(18).orig_lead_lag = -3;
M_.aux_vars(19).endo_index = 52;
M_.aux_vars(19).type = 1;
M_.aux_vars(19).orig_index = 30;
M_.aux_vars(19).orig_lead_lag = -1;
M_.aux_vars(20).endo_index = 53;
M_.aux_vars(20).type = 1;
M_.aux_vars(20).orig_index = 30;
M_.aux_vars(20).orig_lead_lag = -2;
M_.aux_vars(21).endo_index = 54;
M_.aux_vars(21).type = 1;
M_.aux_vars(21).orig_index = 30;
M_.aux_vars(21).orig_lead_lag = -3;
M_.aux_vars(22).endo_index = 55;
M_.aux_vars(22).type = 1;
M_.aux_vars(22).orig_index = 11;
M_.aux_vars(22).orig_lead_lag = -1;
M_.aux_vars(23).endo_index = 56;
M_.aux_vars(23).type = 1;
M_.aux_vars(23).orig_index = 11;
M_.aux_vars(23).orig_lead_lag = -2;
M_.Sigma_e = zeros(4, 4);
M_.Correlation_matrix = eye(4, 4);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.linear = 1;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('NK_CK08_static');
erase_compiled_function('NK_CK08_dynamic');
M_.orig_eq_nbr = 33;
M_.eq_nbr = 56;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 1 29 0;
 0 30 85;
 0 31 86;
 0 32 87;
 0 33 0;
 0 34 88;
 0 35 89;
 0 36 0;
 2 37 0;
 3 38 0;
 4 39 90;
 0 40 0;
 0 41 0;
 0 42 0;
 0 43 0;
 0 44 0;
 0 45 0;
 0 46 91;
 5 47 0;
 0 48 0;
 0 49 0;
 6 50 0;
 7 51 0;
 8 52 0;
 9 53 0;
 0 54 0;
 10 55 0;
 11 56 0;
 0 57 0;
 12 58 92;
 13 59 93;
 14 60 94;
 0 61 0;
 0 62 95;
 0 63 96;
 0 64 97;
 0 65 98;
 0 66 99;
 0 67 100;
 0 68 101;
 0 69 102;
 0 70 103;
 15 71 0;
 16 72 0;
 17 73 0;
 18 74 0;
 19 75 0;
 20 76 0;
 21 77 0;
 22 78 0;
 23 79 0;
 24 80 0;
 25 81 0;
 26 82 0;
 27 83 0;
 28 84 0;]';
M_.nstatic = 13;
M_.nfwrd   = 15;
M_.npred   = 24;
M_.nboth   = 4;
M_.nsfwrd   = 19;
M_.nspred   = 28;
M_.ndynamic   = 43;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:4];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(56, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(4, 1);
M_.params = NaN(81, 1);
M_.NNZDerivatives = [213; 0; -1];
M_.params( 36 ) = 0.9939;
bet = M_.params( 36 );
M_.params( 37 ) = 11;
epsilon = M_.params( 37 );
M_.params( 38 ) = 0.7;
habit = M_.params( 38 );
M_.params( 39 ) = 1.5;
sig = M_.params( 39 );
M_.params( 40 ) = 2;
vphi = M_.params( 40 );
M_.params( 41 ) = 0.5;
omega = M_.params( 41 );
M_.params( 42 ) = 0;
price_index = M_.params( 42 );
M_.params( 43 ) = 0.5;
xi = M_.params( 43 );
M_.params( 44 ) = 0.5;
eta = M_.params( 44 );
M_.params( 45 ) = 0.5;
gamma = M_.params( 45 );
M_.params( 46 ) = 0;
wage_index = M_.params( 46 );
M_.params( 47 ) = 0.09;
vtheta = M_.params( 47 );
M_.params( 48 ) = 0.99;
alp = M_.params( 48 );
M_.params( 53 ) = 0.85;
gamma_R = M_.params( 53 );
M_.params( 54 ) = 1.5;
gamma_Pi = M_.params( 54 );
M_.params( 55 ) = 0.5;
gamma_y = M_.params( 55 );
M_.params( 49 ) = 0.9;
rho_eb = M_.params( 49 );
M_.params( 50 ) = 0;
rho_emoney = M_.params( 50 );
M_.params( 51 ) = 0.7912;
rho_g = M_.params( 51 );
M_.params( 52 ) = 0.6712;
rho_z = M_.params( 52 );
M_.params( 56 ) = 0.3640;
sig_innoeb = M_.params( 56 );
M_.params( 57 ) = 0.25;
sig_monpol = M_.params( 57 );
M_.params( 58 ) = 0.8716;
sig_innog = M_.params( 58 );
M_.params( 59 ) = 0.6849;
sig_innoz = M_.params( 59 );
M_.params( 79 ) = 1;
ybar = M_.params( 79 );
M_.params( 68 ) = 0.3333333333333333;
hbar = M_.params( 68 );
M_.params( 62 ) = 0.00863;
Phi_y = M_.params( 62 );
M_.params( 76 ) = 0.1;
ubar = M_.params( 76 );
M_.params( 74 ) = 0.7;
qbar = M_.params( 74 );
M_.params( 67 ) = 0.347026648444032;
gbar = M_.params( 67 );
M_.params( 80 ) = 0.4;
b_wh = M_.params( 80 );
M_.params( 81 ) = 1;
Pibar = M_.params( 81 );
M_.params( 73 ) = 1-M_.params(76);
nbar = M_.params( 73 );
M_.params( 70 ) = M_.params(47)*M_.params(73);
mbar = M_.params( 70 );
M_.params( 77 ) = M_.params(70)/M_.params(74);
vbar = M_.params( 77 );
M_.params( 75 ) = M_.params(70)/M_.params(76);
sbar = M_.params( 75 );
sigmam      = mbar*(ubar^xi*vbar^(1-xi))^(-1);
thetabar    = vbar/ubar;
M_.params( 71 ) = (M_.params(37)-1)/M_.params(37);
mcbar = M_.params( 71 );
xLbar       = mcbar;
Rbar        = 1/bet;
zbar        = ybar/(nbar*hbar^(alp));
M_.params( 78 ) = xLbar*zbar*M_.params(48)*M_.params(68)^(M_.params(48)-1);
wbar = M_.params( 78 );
M_.params( 61 ) = M_.params(62)*M_.params(79)/M_.params(73);
Phi = M_.params( 61 );
PsiLbar     = xLbar*zbar*hbar^(alp) - wbar*hbar - Phi;
PsiCbar     = (1-mcbar)*ybar;
M_.params( 69 ) = 1/(1-M_.params(36)*(1-M_.params(47)))*PsiLbar;
Jbar = M_.params( 69 );
deltaFbar   = 1/(1-bet*(1-vtheta)*gamma)*wbar*hbar;
b           = b_wh*wbar*hbar;
M_.params( 72 ) = (M_.params(68)*M_.params(48)*M_.params(69)*M_.params(44)/(1-M_.params(36)*(1-M_.params(47))*M_.params(45))/(M_.params(48)-1)*M_.params(78)-(1-M_.params(44))*deltaFbar/(1-M_.params(36)*(1-M_.params(47)-M_.params(75)))*(M_.params(68)*M_.params(78)-b))/((-(M_.params(44)*M_.params(68)*M_.params(69)/(1-M_.params(36)*(1-M_.params(47))*M_.params(45))))/(1-M_.params(48))-M_.params(68)*(1-M_.params(44))*deltaFbar/(1-M_.params(36)*(1-M_.params(47)-M_.params(75)))/(1+M_.params(40)));
mrsbar = M_.params( 72 );
M_.params( 66 ) = M_.params(68)*1/(1-M_.params(36)*(1-M_.params(47))*M_.params(45))/(1-M_.params(48))*(M_.params(78)*(-M_.params(48))-(-M_.params(72)));
deltaWbar = M_.params( 66 );
M_.params( 65 ) = 1/(1-M_.params(36)*(1-M_.params(47)-M_.params(75)))*(M_.params(68)*M_.params(78)-M_.params(68)*M_.params(72)/(1+M_.params(40))-b);
Deltabar = M_.params( 65 );
M_.params( 60 ) = M_.params(69)*M_.params(74)*M_.params(36);
kappa = M_.params( 60 );
M_.params( 64 ) = M_.params(79)-M_.params(60)*M_.params(77)-M_.params(73)*M_.params(61)-M_.params(67);
cbar = M_.params( 64 );
lambdabar   = (cbar*(1-habit))^(-sig);
kappaL      = mrsbar*lambdabar/hbar^vphi;
M_.params( 63 ) = M_.params(68)*M_.params(78)*(1-M_.params(48))/M_.params(48)/PsiLbar;
Afactor = M_.params( 63 );
M_.params( 35 ) = 0.85;
rho_mon = M_.params( 35 );
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
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = 1;
M_.Sigma_e(2, 2) = 1;
M_.Sigma_e(3, 3) = 1;
M_.Sigma_e(4, 4) = M_.params(58)^2;
options_.irf = 60;
var_list_ = char();
info = stoch_simul(var_list_);
save("NK_CK08.mat")
save('NK_CK08_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('NK_CK08_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('NK_CK08_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('NK_CK08_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('NK_CK08_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('NK_CK08_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('NK_CK08_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
