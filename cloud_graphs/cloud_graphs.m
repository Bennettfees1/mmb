cd /msu/scratch4/m1cmb07/Connor_bob/mmb/
data = readtable("analysis_data/MMB_IRF_format.csv");
periods = data.period(1:100);

%unconditional mean and medians
inflationq = data.inflationq;
outputgap = data.outputgap;
realrate  = data.real_rate ;
interest = data.interest;
median_inflationq = rmmissing(data.med_inflationq);
median_inflationq = median_inflationq(1:100);
median_outputgap = rmmissing(data.med_outputgap);
median_outputgap = median_outputgap(1:100);
median_realrate = rmmissing(data.med_real_rate);
median_realrate = median_realrate(1:100);
median_interest = rmmissing(data.med_interest);
median_interest = median_interest(1:100);
median_inflationq = rmmissing(data.med_inflationq);
median_inflationq = median_inflationq(1:100);
median_outputgap = rmmissing(data.med_outputgap);
median_outputgap = median_outputgap(1:100);
median_realrate = rmmissing(data.med_real_rate);
median_realrate = median_realrate(1:100);
median_interest = rmmissing(data.med_interest);
median_interest = median_interest(1:100);
mean_inflationq = rmmissing(data.mean_inflationq);
mean_inflationq = mean_inflationq(1:100);
mean_outputgap = rmmissing(data.mean_outputgap);
mean_outputgap = mean_outputgap(1:100);
mean_realrate = rmmissing(data.mean_real_rate);
mean_realrate = mean_realrate(1:100);
mean_interest = rmmissing(data.mean_interest);
mean_interest = mean_interest(1:100);
mean_inflationq = rmmissing(data.mean_inflationq);
mean_inflationq = mean_inflationq(1:100);
mean_outputgap = rmmissing(data.mean_outputgap);
mean_outputgap = mean_outputgap(1:100);
mean_realrate = rmmissing(data.mean_real_rate);
mean_realrate = mean_realrate(1:100);
mean_interest = rmmissing(data.mean_interest);
mean_interest = mean_interest(1:100);

%Estimated means and medians and panels
estimated = data.model_type == "Estimated";
inflationq_estimated = data.inflationq(estimated);
outputgap_estimated = data.outputgap(estimated);
realrate_estimated  = data.real_rate(estimated);
interest_estimated = data.interest(estimated);
median_inflationq_Estimated = rmmissing(data.med_inflationq_Estimated);
median_inflationq_Estimated = median_inflationq_Estimated(1:100);
median_outputgap_Estimated = rmmissing(data.med_outputgap_Estimated);
median_outputgap_Estimated = median_outputgap_Estimated(1:100);
median_realrate_Estimated = rmmissing(data.med_real_rate_Estimated);
median_realrate_Estimated = median_realrate_Estimated(1:100);
median_interest_Estimated = rmmissing(data.med_interest_Estimated);
median_interest_Estimated = median_interest_Estimated(1:100);
median_inflationq_Estimated = rmmissing(data.med_inflationq_Estimated);
median_inflationq_Estimated = median_inflationq_Estimated(1:100);
median_outputgap_Estimated = rmmissing(data.med_outputgap_Estimated);
median_outputgap_Estimated = median_outputgap_Estimated(1:100);
median_realrate_Estimated = rmmissing(data.med_real_rate_Estimated);
median_realrate_Estimated = median_realrate_Estimated(1:100);
median_interest_Estimated = rmmissing(data.med_interest_Estimated);
median_interest_Estimated = median_interest_Estimated(1:100);
mean_inflationq_Estimated = rmmissing(data.mean_inflationq_Estimated);
mean_inflationq_Estimated = mean_inflationq_Estimated(1:100);
mean_outputgap_Estimated = rmmissing(data.mean_outputgap_Estimated);
mean_outputgap_Estimated = mean_outputgap_Estimated(1:100);
mean_realrate_Estimated = rmmissing(data.mean_real_rate_Estimated);
mean_realrate_Estimated = mean_realrate_Estimated(1:100);
mean_interest_Estimated = rmmissing(data.mean_interest_Estimated);
mean_interest_Estimated = mean_interest_Estimated(1:100);
mean_inflationq_Estimated = rmmissing(data.mean_inflationq_Estimated);
mean_inflationq_Estimated = mean_inflationq_Estimated(1:100);
mean_outputgap_Estimated = rmmissing(data.mean_outputgap_Estimated);
mean_outputgap_Estimated = mean_outputgap_Estimated(1:100);
mean_realrate_Estimated = rmmissing(data.mean_real_rate_Estimated);
mean_realrate_Estimated = mean_realrate_Estimated(1:100);
mean_interest_Estimated = rmmissing(data.mean_interest_Estimated);
mean_interest_Estimated = mean_interest_Estimated(1:100);

%Calibrated means and medians and panels
calibrated = data.model_type == "Calibrated";
inflationq_estimated = data.inflationq(calibrated);
outputgap_estimated = data.outputgap(calibrated);
realrate_estimated  = data.real_rate(calibrated);
interest_estimated = data.interest(calibrated);
median_inflationq_Calibrated = rmmissing(data.med_inflationq_Calibrated);
median_inflationq_Calibrated = median_inflationq_Calibrated(1:100);
median_outputgap_Calibrated = rmmissing(data.med_outputgap_Calibrated);
median_outputgap_Calibrated = median_outputgap_Calibrated(1:100);
median_realrate_Calibrated = rmmissing(data.med_real_rate_Calibrated);
median_realrate_Calibrated = median_realrate_Calibrated(1:100);
median_interest_Calibrated = rmmissing(data.med_interest_Calibrated);
median_interest_Calibrated = median_interest_Calibrated(1:100);
median_inflationq_Calibrated = rmmissing(data.med_inflationq_Calibrated);
median_inflationq_Calibrated = median_inflationq_Calibrated(1:100);
median_outputgap_Calibrated = rmmissing(data.med_outputgap_Calibrated);
median_outputgap_Calibrated = median_outputgap_Calibrated(1:100);
median_realrate_Calibrated = rmmissing(data.med_real_rate_Calibrated);
median_realrate_Calibrated = median_realrate_Calibrated(1:100);
median_interest_Calibrated = rmmissing(data.med_interest_Calibrated);
median_interest_Calibrated = median_interest_Calibrated(1:100);
mean_inflationq_Calibrated = rmmissing(data.mean_inflationq_Calibrated);
mean_inflationq_Calibrated = mean_inflationq_Calibrated(1:100);
mean_outputgap_Calibrated = rmmissing(data.mean_outputgap_Calibrated);
mean_outputgap_Calibrated = mean_outputgap_Calibrated(1:100);
mean_realrate_Calibrated = rmmissing(data.mean_real_rate_Calibrated);
mean_realrate_Calibrated = mean_realrate_Calibrated(1:100);
mean_interest_Calibrated = rmmissing(data.mean_interest_Calibrated);
mean_interest_Calibrated = mean_interest_Calibrated(1:100);
mean_inflationq_Calibrated = rmmissing(data.mean_inflationq_Calibrated);
mean_inflationq_Calibrated = mean_inflationq_Calibrated(1:100);
mean_outputgap_Calibrated = rmmissing(data.mean_outputgap_Calibrated);
mean_outputgap_Calibrated = mean_outputgap_Calibrated(1:100);
mean_realrate_Calibrated = rmmissing(data.mean_real_rate_Calibrated);
mean_realrate_Calibrated = mean_realrate_Calibrated(1:100);
mean_interest_Calibrated = rmmissing(data.mean_interest_Calibrated);
mean_interest_Calibrated = mean_interest_Calibrated(1:100);


%unconditional inflationq
h=figure('rend','painters','pos',[10 10 1000 700]);
plot(data.period,inflationq,'LineWidth',1); hold on;%cov_00

plot(data.period,-data.inflationq(:,1)*0,'Color',[0 0 0],'LineWidth',1.5); hold on; %black line through center

plot(periods, median_inflationq,'LineWidth',5,'Color',[1 0 0]);
plot(periods,mean_inflationq,'LineWidth',5,'LineStyle',':','Color',[0.0 1 1]);
%plot(datenum(num2str(lhs_vars.yearmon),'yyyymm'),Y_maturity(:,6),'LineWidth',0.75); hold on;
recessionplot;
set(gca,'XTick',ticks);
datetick('x', 'yyyy', 'keepticks', 'keeplimits')             
               
ylim([-15 15]);
xlim([datenum('197001','yyyymm') datenum('202012','yyyymm')]);
ax = gca;
labels = ax.XAxis.TickLabels; % extract
labels(2:2:end) = nan; % remove every other one
ax.XAxis.TickLabels = labels; % set 
set(gca,'FontSize', 12)

box on;

set(h,'Units','Inches');

pos = get(h,'Position');

set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3),pos(4)])

%print(h,'Figure_3_final_test_2020','-dpdf','-r0')
