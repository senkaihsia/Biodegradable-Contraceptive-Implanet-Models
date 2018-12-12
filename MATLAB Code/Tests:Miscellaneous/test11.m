intercept = -137
checkconc = intercept*((exp(-kel*testtime))-(exp(-ka*testtime)))
plot(testtime,checkconc)