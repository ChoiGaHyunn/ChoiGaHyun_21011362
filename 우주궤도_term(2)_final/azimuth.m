function az = azimuth(ENU)
n = length(ENU);
az = [];

for i = 1 : n
    R = ENU(i,1);
    N = ENU(i,2);
    E = sqrt(R^2 + N^2);
    az_temp = acosd(N/E);
    if R < 0
            az = [az,360-az_temp];
        else
            az = [az,az_temp];
    end
end
end