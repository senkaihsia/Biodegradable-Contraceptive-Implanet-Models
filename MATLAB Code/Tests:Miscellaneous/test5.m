x1data = [Data.VivoTime];
y1data = [Data.VivoMean];

fun = @(x1data)1046*((exp(-0.069.*x1data))-(exp(-94.95.*x1data)))

plot(x1data,y1data, 'ko',x1data, fun(x1data),'r-')