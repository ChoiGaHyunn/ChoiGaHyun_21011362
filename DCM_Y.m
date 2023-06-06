function MT_Y = DCM_Y(b)
MT_Y = [cosd(b) 0 sind(b); 0 1 0; -sind(b) 0 cosd(b)];
end

