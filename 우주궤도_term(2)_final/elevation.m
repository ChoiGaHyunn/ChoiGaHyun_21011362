
function el = elevation(ENU, el_mask)
 n = length(ENU);
 el = [];
 for i = 1:n
       Ru = ENU(i,3);
       Rrel = sqrt(ENU(i,1)^2+ENU(i,2)^2+ENU(i,3)^2);
       el_temp = asind(Ru/Rrel);
       if el_temp < el_mask
           el = [el,NaN];
       else
           el = [el,el_temp];
       end
   end   
end




