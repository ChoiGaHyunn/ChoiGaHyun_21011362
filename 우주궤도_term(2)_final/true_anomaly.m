
mu = 3.986004418*10^(5);
nav.GPS.a = nav.GPS.a * 10^-3;
nav.BDS.a = nav.BDS.a * 10^-3;
nav.QZSS.a = nav.QZSS.a * 10^-3;

%GPS.Tau = 2*pi*sqrt((nav.GPS.a)^3/mu);
%BDS.Tau = 2*pi*sqrt((nav.BDS.a)^3/mu);
%QZSS.Tau = 2*pi*sqrt((nav.QZSS.a)^3/mu);

for i = 1:1440
    GPS.M(i) = nav.GPS.M0 + i*60*sqrt(mu/(nav.GPS.a)^3);
    BDS.M(i) = nav.BDS.M0 + i*60*sqrt(mu/(nav.BDS.a)^3);
    QZSS.M(i) = nav.QZSS.M0 + i*60*sqrt(mu/(nav.QZSS.a)^3);
end

E = 0;
for i = 1:1440
    GPS.E(i) = getE(GPS.M(i),nav.GPS.e);
    numerate = (sqrt(1-(nav.GPS.e)^2)*sin(GPS.E(i)))/(1-nav.GPS.e*cos(GPS.E(i)));
    denum = (cos(GPS.E(i))-nav.GPS.e)/(1-(nav.GPS.e*cos(GPS.E(i))));
    GPS.true_anomaly(i) = atan2(numerate,denum);
end

E = 0;
for i = 1:1440
    BDS.E(i) = getE(BDS.M(i),nav.BDS.e);
    numerate = (sqrt(1-(nav.BDS.e)^2)*sin(BDS.E(i)))/(1-nav.BDS.e*cos(BDS.E(i)));
    denum = (cos(BDS.E(i))-nav.BDS.e)/(1-(nav.BDS.e*cos(BDS.E(i))));
    BDS.true_anomaly(i) = atan2(numerate,denum);
end

E = 0;
for i = 1:1440
    QZSS.E(i) = getE(QZSS.M(i),nav.QZSS.e);
    numerate = (sqrt(1-(nav.QZSS.e)^2)*sin(QZSS.E(i)))/(1-nav.QZSS.e*cos(QZSS.E(i)));
    denum = (cos(QZSS.E(i))-nav.QZSS.e)/(1-(nav.QZSS.e*cos(QZSS.E(i))));
    QZSS.true_anomaly(i) = atan2(numerate,denum); 
end
