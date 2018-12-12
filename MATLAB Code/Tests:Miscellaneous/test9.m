time = xdata;
kel = 0.1987;
ka = 28.89;
intercept = 1.217e-03;
fudge = 0.0001634

fun = @(time) 1.217e-03*((exp(-0.1987*time))-(exp(-28.89*time)))+0.0001634;


q = integral(fun,0,1200)




figure()
plot(time,AUC,'ko')
figure()
plot(time,Ct,'ko')