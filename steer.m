function A = steer(qr, qn, val, eps)
   qnew = [0 0];
   
   % Steer towards qn with maximum step size of eps
   if val >= eps
       qnew(1) = round(qn(1) + ((qr(1)-qn(1))*eps)/round(dist(qr,qn)));
       qnew(2) = round(qn(2) + ((qr(2)-qn(2))*eps)/round(dist(qr,qn)));
   else
       qnew(1) = round(qr(1));
       qnew(2) = round(qr(2));
   end   
   A = [qnew(1), qnew(2)];
end