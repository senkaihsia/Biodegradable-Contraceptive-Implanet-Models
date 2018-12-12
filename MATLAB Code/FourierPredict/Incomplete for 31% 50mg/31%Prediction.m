% Reference Fourier Conditions 

X1 = table2array(VitroTime);
Y1 = table2array(VitroPer);

X2 = table2array(K31Time);
Y2 = table2array(K31Vitro);
time = VivoTime;

% reference model:  f(x) = 100*(1-exp(-kel*x)), R^2 = 0.9788
k = 0.0006432;


%f = 100*(1-exp(-k*time(:,1)));
a1 =        18.1 
b1 =   0.0009908  
c1 =     -17.49 
d1 =   -0.003809  
f = a1*exp(b1*time) + c1*exp(d1*time)


a = fft(f);


%Tranfer Function

kel = 0.1987;
ka = 28.89;
intercept = 1.217e-03;
fudge = 0.0001634;


g = intercept*((exp(-kel*time))-(exp(-ka*time)))+fudge;
b = fft(g);

Tf = b./a;

%27% 50K 
 a3 =       56.36;
 b3 =   0.0004659;
 c3 =      -55.12;
 d3 =   -0.002031;


h = a3*exp(b3*time) + c3*exp(d3*time);

c = fft(h);

%Fourier Transfer of Predicted Curve 

fPredVivo = Tf.*c;

i = (27/35).*fPredVivo;

z = ifft(i);

figure(1)
plot(time,z,'ko')