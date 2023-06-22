function DCM = ECI2ECEF_DCM(time)
jd = juliandate(time);
thGMST = siderealTime(jd);
DCM = DCM_Z(thGMST);
end