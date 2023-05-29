function rangeInPQW = solveRangeInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly);
mu = 3.986004418 * 10^14;
prompt1 = "What is the semimajor_axis? ";
prompt2 = "What is the eccentricity? ";
prompt3 = "What is the true_anomaly? ";
semimajor_axis = input(prompt1);
eccentricity = input(prompt2);
true_anomaly = input(prompt3);
rangeInPQW = [semimajor_axis(1)*cos(true_anomaly) semimajor_axis(2)*sin(true_anomaly) 0];
end
