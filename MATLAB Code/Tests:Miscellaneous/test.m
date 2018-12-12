predconct = @(V,conc)[(((2*df*D)./V)+(conc(1:15)).*(2-(kel*dt)))./(2+(kel*dt))]
x0 = [1] 
V= lsqcurvefit(predconct,x0,xdata(1:15),ydata(1:15))
plot(xdata(1:15),ydata(1:15),'ko',xdata(1:15),predconc(V,conc),'b-')