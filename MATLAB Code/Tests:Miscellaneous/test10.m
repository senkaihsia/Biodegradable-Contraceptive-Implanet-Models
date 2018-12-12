%Matlab code to check in vitro correlation (IVIVC).
% Created by Senkai Hsia for the Saltzman Biomedical Engineering Lab
% project on biodegrable contraceptives
%Requires IVIVC code and generation of workspace variable to run. 

%1. Creatiion of inital variables, some obtained from the IVIVC code 
F = 1;
D = 17500;
kel = 0.1987;
ka = 28.89;
intercept = 1217;
fudge = 158.6;

% V = (ka*F*X)/(intercept*(ka-kel));

%2. Calculation of differences in fullTime and fraction absorbed according to
%IVIVC model equation

fullTimeplus = fullTime(2:length(fullTime),1);
dt = fullTimeplus - (fullTime(1:length(fullTime)-1,1));
dt = vertcat(0,dt);

checkconc = intercept*((exp(-kel*testtime))-(exp(-ka*testtime)));

InVitroPlus = InVitroPer(2:length(InVitroPer),1);
absorbplus = 1.4572*InVitroPlus + 2.134;
absorb = 1.4572*(InVitroPer(1:(length(InVitroPer)-1),1)) + 2.134;
df =  (absorbplus - absorb)/100;
df = vertcat(0,df);

%3. Predicated concentration now calculated via Wagner Nelson convolution
% and errors plotted 

predconc = [((((2*df*D)./126)+(checkconc.*(2-(kel*dt))))./(2+(kel*dt)))+fudge];
figure(1)
plot(fullTime,predconc,'go',fullTime,ydata,'ko',fullTime,predconc,'g-',xdata,fun(xdata),'b-')
%plot(fullTime(2:30,:),predconc,'bo',fullTime(2:30,:),ydata(2:30,:),'ro',fullTime(2:30,:),predconc,'-b',fullTime(1:29,:),ydata(1:29,:),'-r',xdata(2:30,:),fun(xdata(2:30,:)),'g-')
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

PredAUC = cumtrapz(testtime,predconc) 
modelconc = (intercept*((exp(-kel*testtime))-(exp(-ka*testtime)))+fudge);
ModelAUC = cumtrapz(testtime,modelconc);
PredError = 100.*(abs(ModelAUC - PredAUC)./ModelAUC);
MeanError = nanmean(PredError)


