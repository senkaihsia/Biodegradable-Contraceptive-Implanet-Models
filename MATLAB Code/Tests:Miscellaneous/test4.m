time = [InvivoMean.Time];
%ydata = [InvivoMean.Mean];
fun = @(kel,time)1220*((exp(-kel.*time))-(exp(-.*time)));
x0 = [0];

% Utilise Matlab least squares curve fit solver to fit the above nonlinear equation
% to data.

kel = lsqcurvefit(fun,x0,time,ydata)

% plot the result on graph to see fit 
figure()
plot(time,ydata,'ko',time,fun(kel,time),'b-')
legend('Data','Fitted Concentration Model')
title('Data and Fitted Concentration Model')
ylabel('LNG Plasma Concentration (\mug/ml)')
xlabel('Time (Days)')