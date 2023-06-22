t1 = datetime(nav.GPS.toc);
GPS.t = t1 + minutes(1:1440);

t2 = datetime(nav.BDS.toc);
BDS.t = t2 + minutes(1:1440);

t3 = datetime(nav.QZSS.toc);
QZSS.t = t3 +minutes(1:1440);