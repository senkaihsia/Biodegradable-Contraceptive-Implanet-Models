% Matlab code to demonstrate in vivo and in vitro correlation (IVIVC). 
% Created by Senkai Hsia for the Saltzman Biomedical Engineering Lab
% project on biodegrable contraceptives

% 1. Calulation of constant of elimination, kel, and first constant of the Bateman
% decay equation.

%Data loaded from excel file 
%xdata = [InvivoMean.Time];
%ydata = [InvivoMean.Mean];

% xdata = table2array(DataData1)
% ydata = table2array(DataData2)


%semilogarithmic plot to determine kel and constant, where kel = - slope
%and the constant is the y intercept of the best fit line 

% xplot = xdata(2:length(xdata));
% logy= log(ydata(2:length(ydata)));
% coeff = polyfit(xplot,logy,1);
% kel = -coeff(1);
% intercept = exp(coeff(2))
% fitline = -kel*xplot + coeff(2);
% 
% %results plotted on graph
% figure()
% plot(xplot,logy,'ko',xplot,fitline,'b-')
% legend('Semilog plot data','Best Fit Line')
% title('Ln of Concentration with Increasing Time')
% ylabel('Ln LNG Plasma Concentration (\mug/ml)')
% xlabel('Time (Days)')

% 2. Estimate constant of absoption, ka, by fitting the Bateman decay
% equation for blood plasma to the in vivo concentration profile. 

%function handle definition, with input variable xdata and unknown ka

% plot(xdata,ydata,'ko')
kel = 0.1987
ka = 28.89
intercept = 1217
fudge = 158.6
fun = @(xdata)1217*((exp(-0.1987.*xdata))-(exp(-28.89*xdata)))+158.6;
% x0 = [0];
% 
% % Utilise Matlab least squares curve fit solver to fit the above nonlinear equation
% % to data.
% 
% kel = lsqcurvefit(fun,x0,xdata,ydata);

%plot the result on graph to see fit 
figure()
plot(xdata,ydata,'ko',xdata,fun(xdata),'b-')
legend('Data','Fitted Concentration Model')
title('Data and Fitted Concentration Model')
ylabel('LNG Plasma Concentration (\mug/ml)')
xlabel('Time (Days)')

%ka value now determined that best fits model to data 


%3. Wagner Nelson deconvolution method to obtain values of absorption
%percentages 

time = xdata;
kel = 0.1987
ka = 28.89
intercept = 1217
fudge = 158.6

conc = (intercept*((exp(-kel*time))-(exp(-ka*time)))+fudge);
v = [DataData4.Time]
w = [concCopy]
AUC = transpose(cumtrapz(v,w,2));

%Conconcentation up to time t calculated by adding the AUC times Kel to
%the concentration at that point

Ct = conc+(kel.*AUC);

%The maximum concentration is calculated from the indefinate integral of
%the concentration function
Cmax = 17500
%Elimination percentage calculated by dividing the concentration up to t by
%the Cmax. This is then subtracted from 1 to yield the absorption rate as
%the total amount of drug is a conserved quantity. (decimals of
%concentration in the system must sum to 1) 

absorbfrac = (Ct/(kel*Cmax));
InVivoPer=(absorbfrac*100)
%InVitroPer = [Data.VitroPer]; 
InVitroPer = table2array(DataData3)

%plot in vivo percentage-time graph
figure()
plot(xdata,InVivoPer,'ko')
title('Percentage of Drug Absorbed with Increasing Time')
ylabel('LNG Absorbed (%)')
xlabel('Time (Days)')
figure()
plot(InVitroPer,InVivoPer,'ko')

4. IVIVC Model Creation

plot in vivo absorbtion % -in vitro released % graph 
IVIVCcoeff = polyfit(InVitroPer,InVivoPer,1);
IVIVCline = IVIVCcoeff(1)*InVitroPer + IVIVCcoeff(2);
figure()
plot(InVitroPer,InVivoPer,'ko',InVitroPer,IVIVCline,'b-') 
legend('Data','IVIVC')
title('In Vivo Absorption over In Vitro Released')
ylabel('LNG Absorbed (%)')
xlabel('In Vitro Release (%)')

%Calculation of r squared values and correlation coefficient
mdl = fitlm(InVitroPer,InVivoPer)
Rsquared = mdl.Rsquared.Ordinary ;
Correlation = corr(InVitroPer,InVivoPer,'Type','Pearson');

%5.Final Printout of Results 
intercept
kel
ka
Rsquared
Correlation









