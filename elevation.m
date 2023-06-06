function el = elevation(ENU, el_mask)
RU = diag(ENU*[0;0;1]);
Rr = diag(sqrt(diag(ENU*ENU')));
el = asind(diag(RU/Rr)');
el(el <= el_mask) = NaN;
end