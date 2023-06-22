
GPS.P = nav.GPS.a*(1-(nav.GPS.e)^2);
BDS.P = nav.BDS.a*(1-(nav.BDS.e)^2);
QZSS.P = nav.QZSS.a*(1-(nav.QZSS.e)^2);

%r크기
GPS_r=[];
BDS_r=[];
QZSS_r=[];
for i=1:1440
    GPS_R = GPS.P/(1+(nav.GPS.e)*cos(GPS.true_anomaly(i)));
    BDS_R = BDS.P/(1+(nav.BDS.e)*cos(BDS.true_anomaly(i)));
    QZSS_R = QZSS.P/(1+(nav.QZSS.e)*cos(QZSS.true_anomaly(i)));

    GPS_r = [GPS_r; GPS_R*cos(GPS.true_anomaly(i)) GPS_R*sin(GPS.true_anomaly(i)) 0];
    BDS_r = [BDS_r; BDS_R*cos(BDS.true_anomaly(i)) BDS_R*sin(BDS.true_anomaly(i)) 0];
    QZSS_r =[QZSS_r; QZSS_R*cos(QZSS.true_anomaly(i)) QZSS_R*sin(QZSS.true_anomaly(i)) 0];
end
GPS.PQ = GPS_r;
BDS.PQ = BDS_r;
QZSS.PQ = QZSS_r;

GPS_RECI=[];
BDS_RECI=[];
QZSS_RECI=[];
for i=1:1440
    GPS_RECI = [GPS_RECI, PQW2ECI(nav.GPS.omega,nav.GPS.i,nav.GPS.OMEGA)*GPS.PQ(i,:)'];
    BDS_RECI = [BDS_RECI, PQW2ECI(nav.BDS.omega,nav.BDS.i,nav.BDS.OMEGA)*BDS.PQ(i,:)'];
    QZSS_RECI = [QZSS_RECI, PQW2ECI(nav.QZSS.omega,nav.QZSS.i,nav.QZSS.OMEGA)*QZSS.PQ(i,:)'];

end
GPS.ECI = GPS_RECI';
BDS.ECI = BDS_RECI';
QZSS.ECI = QZSS_RECI';






