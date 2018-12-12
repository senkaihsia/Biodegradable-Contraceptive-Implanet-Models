xdata = table2array(DataData1);
ydata = table2array(DataData2);

kel = 0.1987;
ka = 28.89;
intercept = 1.217e-03;
fudge = 0.0001634;

fun = @(xdata)intercept*((exp(-kel.*xdata))-(exp(-ka*xdata)))+fudge;
figure(1)
plot(xdata,ydata,'ko',xdata,fun(xdata),'b-')
legend('Data','Fitted Concentration Model')
title('Data and Fitted Concentration Model')
ylabel('LNG Plasma Concentration (\mug/ml)')
xlabel('Time (Days)')



time = xdata;

conc = (intercept*((exp(-kel*time))-(exp(-ka*time)))+fudge);
figure(2)
plot(time,conc,'ko')
v = [DataData4.Time];
w = [transpose(conc)];
AUC = transpose(cumtrapz(v,w,2));

Ct = conc+(kel.*AUC);

Cmax =  0.2022;


absorbfrac = (Ct/(kel*Cmax));
InVivoPer=(absorbfrac*100);
InVitroPer = table2array(DataData3);


figure(3)
plot(time,InVivoPer,'ko')
title('Percentage of Drug Absorbed with Increasing Time')
ylabel('LNG Absorbed (%)')
xlabel('Time (Days)')


IVIVCcoeff = polyfit(InVitroPer(1:24,2),InVivoPer(1:24,2),1);

IVIVCline = IVIVCcoeff(1)*InVitroPer + IVIVCcoeff(2);
figure(4)
plot(InVitroPer,InVivoPer,'ko',InVitroPer,IVIVCline,'b-') 
title('IVIVC Level A: In Vivo Absorption over In Vitro Released')
ylabel('LNG Absorbed \it in vivo (%)')
xlabel('In Vitro Release \it in vitro (%)')

mdl = fitlm(InVitroPer(1:24,2),InVivoPer(1:24,2))
Rsquared = mdl.Rsquared.Ordinary ;
Correlation = corr(InVitroPer(1:24,2),InVivoPer(1:24,2),'Type','Pearson')




