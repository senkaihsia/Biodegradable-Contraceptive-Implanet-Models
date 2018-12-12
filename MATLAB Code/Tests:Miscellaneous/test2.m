time = [InvivoMean.Time];
ydata = [InvivoMean.Mean];


%V = 126
intercept =  1220 ;
kel = 0.028;
ka = 21;
fun = @(ka,time)intercept*((exp(-kel.*time))-(exp(-ka.*time)));
%fun = @(kel,time)(1/V)*(exp(-kel.*time))


plot(time,ydata,'ko',time,fun(ka,time),'b-')