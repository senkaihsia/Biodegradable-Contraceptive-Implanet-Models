X = [Test8.VivoTime]
Y = [test8y]
figure()
plot(X,Y,'ko')


kel = 0.2
%AUC = cumtrapz(Y)
AUC = cumtrapz(X,Y,2)

%Conconcentation up to time t calculated by adding the AUC times Kel to
%the concentration at that point

Ct = Y+(kel*AUC);

%The maximum concentration is calculated from the indefinate integral of
%the concentration function
Cmax = 17500
%Elimination percentage calculated by dividing the concentration up to t by
%the Cmax. This is then subtracted from 1 to yield the absorption rate as
%the total amount of drug is a conserved quantity. (decimals of
%concentration in the system must sum to 1) 

absorbfrac = (Ct/(kel*Cmax))
InVivoPer=(absorbfrac*100)
InVitroPer = [DataData4.Vitro]
%InVitroPer = table2array(DataData3)

%plot in vivo percentage-time graph
figure()
plot(xdata,InVivoPer,'ko')
title('Percentage of Drug Absorbed with Increasing Time')
ylabel('LNG Absorbed (%)')
xlabel('Time (Days)')
figure()
plot(InVitroPer,InVivoPer,'ko')