output out = PQW2ECI(arg_prg,inc_angle,RAAN,A)
R(RAAN,3'')=[cos(RAAN) -sin(RAAN) 0; sin(RAAN) cos(RAAN) 0; 0 0 1] ;
R(inc_angle,1')=[1 0 0;0 cos(inc_angle) -sin(inc_angle);0 sin(inc_angle) cos(inc_angle)];
R(arg_prg,3)=[1 0 0;0 cos(arg_prg) -sin(arg_prg);0 sin(arg_prg) cos(arg_prg)];
out_1 = R(RAAN,3'') * R(inc_angle,1') * R(arg_prg,3) *A ;
out = transpose(out_1);
