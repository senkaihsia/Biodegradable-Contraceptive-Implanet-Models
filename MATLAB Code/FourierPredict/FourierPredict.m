%Matlab code to validate in vitro correlation (IVIVC).
% Created by Senkai Hsia for the Saltzman Biomedical Engineering Lab at
% Yale University, 2018
% project on biodegrable contraceptives

% Version: 2

% Load Files from FourierPredict: NewTime, New Vitro, SingleVivo, VitroPer,
% VitroTime

% Curve Fits: 27%, Vitro Curve Fit and VivoFit

% 1. Creation of initial conditions for curve fit

X1 = table2array(VitroTime);
Y1 = table2array(VitroPer);

X2 = table2array(NewTime);
Y2 = table2array(NewVitro);
time = table2array(SingleVivo);

% 2. reference model:  f(x) = 100*(1-exp(-kel*x)), R^2 = 0.9788
%Curve Fit conducted manually and inputted coeffs :(

k = 0.0006432;


%f = 100*(1-exp(-k*time(:,1)));
a1 =        18.1;
b1 =   0.0009908;
c1 =     -17.49;
d1 =   -0.003809;
f = a1*exp(b1*time) + c1*exp(d1*time);


a = fft(f);


%3. Tranfer Function in frequency space

kel = 0.1987;
ka = 28.89;
intercept = 1.217e-03;
fudge = 0.0001634;


g = intercept*((exp(-kel*time))-(exp(-ka*time)))+fudge;
b = fft(g);

Tf = b./a;

%4. Data manually inputted from 27% 50K Curve Fit
 a3 =       56.36;
 b3 =   0.0004659;
 c3 =      -55.12;
 d3 =   -0.002031;


h = a3*exp(b3*time) + c3*exp(d3*time);

c = fft(h);

%5. Fourier Transfer of Predicted Curve and inverse transfer to time space

fPredVivo = Tf.*c;

i = (27/35).*fPredVivo;

z = ifft(i);

% 6. For Comparison with 28% (35 assayed) fitted curve
kel = 0.1987;
ka = 28.89;
intercept = 1.217e-03;
fudge = 0.0001634;
conc = intercept*((exp(-kel*time))-(exp(-ka*time)))+fudge;

figure(1)
plot(time,z,'ko', time,z,'-b',time,conc,'-r')
legend('','Predicted In Vivo for 27% Loading','Fitted In Vivo for Observed 35% (28) Loading')
title('Blood plasma concentration over time')
ylabel('LNG Plasma Concentration (\mug/ml)')
xlabel('Time (Days)')





















