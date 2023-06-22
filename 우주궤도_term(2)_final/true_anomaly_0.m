
%True_anomaly_0

i=0;
while (1)
    E(1) = nav.GPS.M0;
    i=i+1;
    E(i+1) = nav.GPS.M0 + nav.GPS.e*sin(E(i));
    if abs(E(i+1)-E(i)) < 0.005
        break
    end
end
GPS.true_anomaly_0 = atan((sqrt(1-(nav.GPS.e)^2)*sin(E(i+1))/1-nav.GPS.e*cos(E(i+1)))/(cos(E(i+1))-nav.GPS.e)/1-(nav.GPS.e*cos(E(i+1))));


E = 0;
i=0;
while (1)
    E(1) = nav.QZSS.M0;
    i=i+1;
    E(i+1) = nav.QZSS.M0 + nav.QZSS.e*sin(E(i));
    if abs(E(i+1)-E(i)) < 0.005
        break
    end
end
QZSS.true_anomaly_0 = atan((sqrt(1-(nav.QZSS.e)^2)*sin(E(i+1))/1-nav.QZSS.e*cos(E(i+1)))/(cos(E(i+1))-nav.QZSS.e)/1-(nav.QZSS.e*cos(E(i+1))));


E = 0;
i=0;
while (1)
    E(1) = nav.BDS.M0;
    i=i+1;
    E(i+1) = nav.BDS.M0 + nav.BDS.e*sin(E(i));
    if abs(E(i+1)-E(i)) < 0.005
        break
    end
end
BDS.true_anomaly_0 = atan((sqrt(1-(nav.BDS.e)^2)*sin(E(i+1))/1-nav.BDS.e*cos(E(i+1)))/(cos(E(i+1))-nav.BDS.e)/1-(nav.BDS.e*cos(E(i+1))));





