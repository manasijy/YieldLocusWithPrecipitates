 function [Nbar] = Nxtal_general_function(A,e_ext,DC_ppt,n_varients)% 

 a =2/3;
 b =1/3;
 e_xtal= transform_e_function(e_ext,A);
 N = zeros(1,n_varients);
 
%  en= (e(1,1)^2+e(2,2)^2+e(3,3)^2);
%  en_cube = (e_ext(1,1)^2+e_ext(2,2)^2+e_ext(3,3)^2);
     for i=1:1:n_varients
         [e]= transform_e_function(e_xtal,DC_ppt{i});
         en= (e(1,1)^2+e(2,2)^2+e(3,3)^2);
         N(i)= sqrt(a*en + b*(2*e(1,2))^2);
     end
     Nbar = mean(N);
     %      w = sqrt(0.666*en)/sqrt(0.666*en_cube);
 end
