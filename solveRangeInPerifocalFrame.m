function rangeInPQW = solveRangeInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly);
mu = 3.986004418 * 10^14;
perigee = semimajor_axis*(1-eccentricity^2);
r = perigee/(1+eccentricity*cosd(true_anomaly));
rangeInPQW = r.*[cosd(true_anomaly); sind(true_anomaly);0];
end
