xdata = table2array(DataData1);
ydata = table2array(DataData2);

kel = 0.1987
ka = 28.89
intercept = 1217
fudge = 158.6
fun = @(xdata)1217*((exp(-0.1987.*xdata))-(exp(-28.89*xdata)))+158.6;
figure(1)
plot(xdata,ydata,'ko',xdata,fun(xdata),'b-')
legend('Data','Fitted Concentration Model')
title('Data and Fitted Concentration Model')
ylabel('LNG Plasma Concentration (\mug/ml)')
xlabel('Time (Days)')



time = xdata;
kel = 0.1987;
ka = 28.89;
intercept = 1217;
fudge = 158.6;

conc = (intercept*((exp(-kel*time))-(exp(-ka*time)))+fudge);
figure(2)
plot(time,conc,'ko')
v = [DataData4.Time];
w = [transpose(conc)];
AUC = transpose(cumtrapz(v,w,2));

Ct = conc+(kel.*AUC)

Cmax = 1.9640e+05


absorbfrac = (Ct/(kel*Cmax));
InVivoPer=(absorbfrac*100)
InVitroPer = table2array(DataData3)


figure(3)
plot(time,InVivoPer,'ko')
title('Percentage of Drug Absorbed with Increasing Time')
ylabel('LNG Absorbed (%)')
xlabel('Time (Days)')


IVIVCcoeff = polyfit(InVitroPer(1:24,2),InVivoPer(1:24,2),1)

IVIVCline = IVIVCcoeff(1)*InVitroPer + IVIVCcoeff(2)
figure(4)
plot(InVitroPer,InVivoPer,'ko',InVitroPer,IVIVCline,'b-') 
title('In Vivo Absorption over In Vitro Released')
ylabel('LNG Absorbed (%)')
xlabel('In Vitro Release (%)')


