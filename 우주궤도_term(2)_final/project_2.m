%% Term project_2
% 21011362_최가현

%GPS
%BDS
%QZSS
load('nav.mat')

%% find true_anomaly at t=t0

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
    E(1) = nav.BDS.M0;
    i=i+1;
    E(i+1) = nav.BDS.M0 + nav.BDS.e*sin(E(i));
    if abs(E(i+1)-E(i)) < 0.005
        break
    end
end
BDS.true_anomaly_0 = atan((sqrt(1-(nav.BDS.e)^2)*sin(E(i+1))/1-nav.BDS.e*cos(E(i+1)))/(cos(E(i+1))-nav.BDS.e)/1-(nav.BDS.e*cos(E(i+1))));

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

%% datetime
% divide time 24hours to 1440 minutes


t1 = datetime(nav.GPS.toc);
GPS.t = t1 + minutes(1:1440);

t2 = datetime(nav.BDS.toc);
BDS.t = t2 + minutes(1:1440);

t3 = datetime(nav.QZSS.toc);
QZSS.t = t3 +minutes(1:1440);



mu = 3.986004418*10^(5);
nav.GPS.a = nav.GPS.a * 10^-3; % m to km
nav.BDS.a = nav.BDS.a * 10^-3; % m to km
nav.QZSS.a = nav.QZSS.a * 10^-3; % m to km

%% calculate Mean anomaly

for i = 1:1440
    GPS.M(i) = nav.GPS.M0 + i*60*sqrt(mu/(nav.GPS.a)^3);
    BDS.M(i) = nav.BDS.M0 + i*60*sqrt(mu/(nav.BDS.a)^3);
    QZSS.M(i) = nav.QZSS.M0 + i*60*sqrt(mu/(nav.QZSS.a)^3);
end

%calculate true anomaly at t(i)
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

%% calculate perigee

GPS.P = nav.GPS.a*(1-(nav.GPS.e)^2);
BDS.P = nav.BDS.a*(1-(nav.BDS.e)^2);
QZSS.P = nav.QZSS.a*(1-(nav.QZSS.e)^2);

%% r크기 in perifocal frame
GPS_r=[];
BDS_r=[];
QZSS_r=[];

for i=1:1440
    GPS_R = GPS.P/(1+(nav.GPS.e)*cos(GPS.true_anomaly(i)));
    BDS_R = BDS.P/(1+(nav.BDS.e)*cos(BDS.true_anomaly(i)));
    QZSS_R = QZSS.P/(1+(nav.QZSS.e)*cos(QZSS.true_anomaly(i)));

    % r 벡터 in perifocal frame
    GPS_r = [GPS_r; GPS_R*cos(GPS.true_anomaly(i)) GPS_R*sin(GPS.true_anomaly(i)) 0];
    BDS_r = [BDS_r; BDS_R*cos(BDS.true_anomaly(i)) BDS_R*sin(BDS.true_anomaly(i)) 0];
    QZSS_r =[QZSS_r; QZSS_R*cos(QZSS.true_anomaly(i)) QZSS_R*sin(QZSS.true_anomaly(i)) 0];
end
GPS.PQ = GPS_r;
BDS.PQ = BDS_r;
QZSS.PQ = QZSS_r;

%% Perifocal frame to ECI frame

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

%% ECI frame to ECEF frame

GPS_RECEF=[];
BDS_RECEF=[];
QZSS_RECEF=[];
for i=1:1440
    GPS_RECEF = [GPS_RECEF, ECI2ECEF_DCM(GPS.t(i)) * GPS.ECI(i,:)'];
    BDS_RECEF = [BDS_RECEF, ECI2ECEF_DCM(BDS.t(i)) * BDS.ECI(i,:)'];
    QZSS_RECEF = [QZSS_RECEF, ECI2ECEF_DCM(QZSS.t(i)) * QZSS.ECI(i,:)'];
end
GPS.RECEF = GPS_RECEF';
BDS.RECEF = BDS_RECEF';
QZSS.RECEF = QZSS_RECEF';

%% ECEF frame to ENU frame

GPS_RENU=[];
BDS_RENU=[];
QZSS_RENU=[];

lon=37; % 기지국 경도
lat=128; % 기지국 위도
wgs84 = wgs84Ellipsoid('kilometer');

[GPS_RE, GPS_RN, GPS_RU] = ecef2enu(GPS.RECEF(:,1), GPS.RECEF(:,2), GPS.RECEF(:,3),lon,lat,0,wgs84);
[BDS_RE, BDS_RN, BDS_RU] = ecef2enu(BDS.RECEF(:,1), BDS.RECEF(:,2), BDS.RECEF(:,3),lon,lat,0,wgs84);
[QZSS_RE, QZSS_RN, QZSS_RU] = ecef2enu(QZSS.RECEF(:,1), QZSS.RECEF(:,2), QZSS.RECEF(:,3),lon,lat,0,wgs84);

GPS.ENU = [GPS_RE, GPS_RN, GPS_RU];
BDS.ENU = [BDS_RE, BDS_RN, BDS_RU];
QZSS.ENU = [QZSS_RE, QZSS_RN, QZSS_RU];

%% Azimuth and Elevation

GPS.El = elevation(GPS.ENU,0);
GPS.AZ = azimuth(GPS.ENU);

BDS.El = elevation(BDS.ENU,0);
BDS.AZ = azimuth(BDS.ENU);

QZSS.El = elevation(QZSS.ENU,0);
QZSS.AZ = azimuth(QZSS.ENU);


%% Skyplot

f1 = figure;
skyplot(GPS.AZ,GPS.El)
f2 = figure;
skyplot(BDS.AZ,BDS.El)
f3 = figure;
skyplot(QZSS.AZ,QZSS.El)

%% Ground Track

f4 = figure;
[lat,lon,h] = ecef2geodetic(wgs84,GPS.RECEF(:,1),GPS.RECEF(:,2),GPS.RECEF(:,3));
geoplot(lat,lon)
f5 = figure;
[lat,lon,h] = ecef2geodetic(wgs84,BDS.RECEF(:,1),BDS.RECEF(:,2),BDS.RECEF(:,3));
geoplot(lat,lon)
f6 = figure;
[lat,lon,h] = ecef2geodetic(wgs84,QZSS.RECEF(:,1),QZSS.RECEF(:,2),QZSS.RECEF(:,3));
geoplot(lat,lon)
