
GPS_RENU=[];
BDS_RENU=[];
QZSS_RENU=[];

lon=37;
lat=128;
wgs84 = wgs84Ellipsoid('kilometer');

[GPS_RE, GPS_RN, GPS_RU] = ecef2enu(GPS.RECEF(:,1), GPS.RECEF(:,2), GPS.RECEF(:,3),lon,lat,0,wgs84);
[BDS_RE, BDS_RN, BDS_RU] = ecef2enu(BDS.RECEF(:,1), BDS.RECEF(:,2), BDS.RECEF(:,3),lon,lat,0,wgs84);
[QZSS_RE, QZSS_RN, QZSS_RU] = ecef2enu(QZSS.RECEF(:,1), QZSS.RECEF(:,2), QZSS.RECEF(:,3),lon,lat,0,wgs84);

GPS.ENU = [GPS_RE, GPS_RN, GPS_RU];
BDS.ENU = [BDS_RE, BDS_RN, BDS_RU];
QZSS.ENU = [QZSS_RE, QZSS_RN, QZSS_RU];
