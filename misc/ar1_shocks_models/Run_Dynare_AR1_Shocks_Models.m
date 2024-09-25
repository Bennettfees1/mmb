    addpath("/apps/dynare/4.5.6/lib/dynare/matlab")
    
   % cd '/msu/scratch4/m1cmb07/Connor_bob/mmb/ar1_shocks_models/NK_AFL15/'
   % clear
   % close all
   % dynare NK_AFL15.mod

   % cd '/msu/scratch4/m1cmb07/Connor_bob/mmb/ar1_shocks_models/NK_CFP10/'
   % clear
   % close all
   % dynare NK_CFP10.mod

   % cd '/msu/scratch4/m1cmb07/Connor_bob/mmb/ar1_shocks_models/NK_ET14/'
   % clear
   % close all
   % dynare NK_ET14.mod

    cd '/msu/scratch4/m1cmb07/Connor_bob/mmb/ar1_shocks_models/US_RE09/'
    clear
    close all
    dynare US_RE09.mod

   % cd '/msu/scratch4/m1cmb07/Connor_bob/mmb/ar1_shocks_models/NK_CK08/'
   % clear
   % close all
   % dynare NK_CK08.mod

    %basic idea to write data into .csv's
   % csvwrite('test.csv', m.M)
   % csvwrite('test.csv', m.inflationq_interest_) %do this over all the Modelbase Variables defined in the .mod files.

