function []=release_model_new()
m = 1; %cylindrical coordinates
x = linspace(0,2)  %radius in mm
t_model=[0 5e5 1e6 2e6 3e6 4e6 6e6 8e6 1e7 1.5e7 2e7 3e7 4e7 6e7 8e7] %model time in sec
u0=15; %initial concentration of drug

sol = pdepe(m,@pdex1pde,@pdex1ic,@pdex1bc,x,t_model);
% Extract the first solution component as u.
u = (sol(:,:,1));

check=u';

%SOLUTION PROFILE

figure(1)
plot(x,u');
title('Concentration vs. Radius');
xlabel('Radius(cm)');
ylabel('Concentration(mg/ml)');

figure(2)
plot(x,u0-(u'));
title('Concentration Distribution at various times');
xlabel('Radius(cm)');
ylabel('1-C/C0');


%INTEGRATION

L=1; %length in mm
% dr=1./length(x); %interval
solution=u';








integral1 = solution.*((x'.^3)/3)
integration=trapz(x,integral1)
figure(4)
finalSolution = ((pi*.002.^2*u0*L) - (pi*L*integration))
plot(t_model,finalSolution)





% mg_released=u0-mg_left%u0*2*pi*L-mg_left %calculation of mg released
% 
% 
% figure(3)
% title('LNG Released vs Time');
% xlabel('Time (sec)');
% ylabel('Total LNG Released(mg)');
% plot(t_model,mg_released)
% 
% 
% 
%invitro data
bdi_release=[0 0.42 0.84 1.65 2.47 3.27 4.01 4.84 5.63 6.49 7.42 8.25 8.78 9.68 10.40 11.03 11.65 12.24 12.84 13.51 13.89 14.44 15.0];
time=[0 172800 518400 2.333e6 4.752e6 7.603e6 1.011e7 1.313e7 1.555e7 1.806e7 2.16e7 2.514e7 2.644e7 3.128e7 3.43e7 3.724e7 3.974e7 4.216e7 4.467e7 4.769e7 4.951e7 5.340e7 6.31e7]; %invitro
figure(5);
plot(time,bdi_release);
title('BDI In Vitro Total Release vs. Time');
xlabel('Time (sec)');
ylabel('LNG (ug)');

end

% --------------------------------------------------------------
%pde equation
function [c,f,s] = pdex1pde(x,t_model,u,DuDx);
D=2e-8;
c = 1/D; %1/D in mm^2/sec
f = DuDx;
s = 0; 
end

% --------------------------------------------------------------
%initial conditions
function u0 = pdex1ic(x); 
u0=15;
end

% --------------------------------------------------------------
%boundary conditions
function [pl,ql,pr,qr] = pdex1bc(xl,ul,xr,ur,t_model);
pl = 0;
ql = 1;%since du/dr=0
pr = ur;%since C=0
qr = 0;
end
