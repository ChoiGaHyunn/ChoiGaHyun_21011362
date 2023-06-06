function out = PQW2ECI(arg_prg,inc_angle,RAAN,A)
R(RAAN,3'')=[cosd(RAAN) -sind(RAAN) 0; sind(RAAN) cosd(RAAN) 0; 0 0 1] ;
R(inc_angle,1')=[1 0 0;0 cosd(inc_angle) -sind(inc_angle);0 sind(inc_angle) cosd(inc_angle)];
R(arg_prg,3)=[1 0 0;0 cosd(arg_prg) -sind(arg_prg);0 sind(arg_prg) cosd(arg_prg)];
out = transpose(R(RAAN,3'') * R(inc_angle,1') * R(arg_prg,3)) *A ;
end
