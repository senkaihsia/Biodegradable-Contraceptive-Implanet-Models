time = [InvivoMean.Time];
ydata = [InvivoMean.Mean];


tbl = table(time,ydata)

modelconc = @(b,time) (1/126)*(exp(-b*time))
beta0 = [1220]
mdl = fitnlm(tbl,modelconc,beta0)