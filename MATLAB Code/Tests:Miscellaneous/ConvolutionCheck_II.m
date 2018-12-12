%Matlab code to check in vitro correlation (IVIVC).
% Created by Senkai Hsia for the Saltzman Biomedical Engineering Lab
% project on biodegrable contraceptives

%Version: 3 

%Load Files from IVIVC: CompleteVivoTime, SingleVivo


%1. Creatiion of inital variables, some obtained from the IVIVC main code,
%need to be manually changed if IVIVC not conducted first. 
F = 1;
D = 0.0175;
kel = 0.1987;
ka = 28.89;
intercept = 1.217e-03;
fudge = 0.0001634;
Vd = 126;

fullTime = CompleteVivoTime;
testtime = table2array(SingleVivo);


% V = (ka*F*X)/(intercept*(ka-kel));

%2. Calculation of differences in fullTime and fraction absorbed according to
%IVIVC model equation

fullTimeplus = fullTime(2:length(fullTime),1);
dt = fullTimeplus - (fullTime(1:length(fullTime)-1,1));
dt = vertcat(0,dt);

checkconc = intercept*((exp(-kel*testtime))-(exp(-ka*testtime)));

InVitroPlus = InVitroPer(2:length(InVitroPer),1);
absorbplus = 3*InVitroPlus + 2.134;
absorb =  1.4576*(InVitroPer(1:(length(InVitroPer)-1),1)) + 2.0577;
df =  (absorbplus - absorb)/100;
df = vertcat(0,df);

%3. Predicated concentration now calculated via Wagner Nelson convolution
% and errors plotted 

predconc = [((((2*df*D)./Vd)+(checkconc.*(2-(kel*dt))))./(2+(kel*dt)))+fudge];
figure(1)
plot(fullTime,predconc,'go',fullTime,ydata,'ko',fullTime,predconc,'g-',xdata,fun(xdata),'b-')
legend('Predicted Plasma Concentration','InVivoData''Predicted Concentration Profile', 'Concentration Model' )
xlabel('Time (Days)')
ylabel('LNG Plasma Concentration (\mug/ml)')
title('Drug Plasma Concentration with Increasing Time')
figure(2)
plot(fullTime,predconc,'go',fullTime,predconc,'g-',xdata,fun(xdata),'b-')
xlabel('Time (Days)')
ylabel('LNG Plasma Concentration (\mug/ml)')
title('Drug Plasma Concentration with Increasing Time')


%4. Report on the average error compared with observed in vivo data and correlation 

PredAUC = cumtrapz(testtime,predconc);
modelconc = (intercept*((exp(-kel*testtime))-(exp(-ka*testtime)))+fudge);
ModelAUC = cumtrapz(testtime,modelconc);
PredError = 100.*(abs(ModelAUC - PredAUC)./ModelAUC);
MeanError = nanmean(PredError)


