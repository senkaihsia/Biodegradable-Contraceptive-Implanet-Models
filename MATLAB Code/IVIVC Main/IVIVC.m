%In Vivo- In Vitro Correlation MATLAB code built by Senkai Hsia for the 
% Saltzman Bioengineering Lab at Yale University, 2018. 
% 
% Version: 3.1
% 
% Load files from IVIVC folder: VivoTime, VivoDaily, SingleVivo, VitroPercentage
% VivoTime and VivoDaily are data that have been filtered from outliers, absence marked with NaN 
% Please refer to Methods documentation for full explanation. 

% Curve Fit File: VivoFit

% 1. Initial Parameter definition 


xdata = table2array(VivoTime);
ydata = table2array(VivoDaily);

%2. Data obtained from MATLAB Curve Fit to  F(x) =
%a(exp(-kel.x)-exp(-ka.x)+b 
%Manual input needed :( 

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


% 3. Integration according to Wagner-Nelson Method

time = xdata;

conc = (intercept*((exp(-kel*time))-(exp(-ka*time)))+fudge);
figure(2)
plot(time,conc,'ko')
v = [SingleVivo.Time];
w = [transpose(conc)];
AUC = transpose(cumtrapz(v,w,2));

Ct = conc+(kel.*AUC);

%4. Denominator t max estimated at 1200 days. 

fun = @(time) 1.217e-03*((exp(-0.1987*time))-(exp(-28.89*time)))+0.0001634;
Cmax = integral(fun,0,1200);


absorbfrac = (Ct/(kel*Cmax));
InVivoPer=(absorbfrac*100);
InVitroPer = table2array(VitroPercentage);


figure(3)
plot(time,InVivoPer,'ko')
title('Percentage of Drug Absorbed with Increasing Time')
ylabel('LNG Absorbed (%)')
xlabel('Time (Days)')


%5. Adding line of best fit according to series most number of data points,
%calculating R^2 and Pearson's coeff. 

IVIVCcoeff = polyfit(InVitroPer(1:24,2),InVivoPer(1:24,2),1);

IVIVCline = IVIVCcoeff(1)*InVitroPer + IVIVCcoeff(2);
figure(4)
plot(InVitroPer,InVivoPer,'ko',InVitroPer,IVIVCline,'b-') 
title('IVIVC Level A: In Vivo Absorption over In Vitro Released')
ylabel('LNG Absorbed \it in vivo (%)')
xlabel('In Vitro Release \it in vitro (%)')

mdl = fitlm(InVitroPer(1:24,2),InVivoPer(1:24,2));

%6. Final Report of Values and fitted IVIVC equation
mdl
Rsquared = mdl.Rsquared.Ordinary
Correlation = corr(InVitroPer(1:24,2),InVivoPer(1:24,2),'Type','Pearson')





