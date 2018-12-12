time = [InvivoMean.Time];
ydata = [InvivoMean.Mean];


tbl = table(time,ydata)


modelconc = @(b,x) 1220.*(exp((-b(1).*x(:,1)))- exp((-b(2).*x(:,1))));
beta0 = [0,10]
mdl = fitnlm(tbl,modelconc,beta0)


