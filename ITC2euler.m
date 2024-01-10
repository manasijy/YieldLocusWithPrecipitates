%% This program calculates the euler angles for the given hkl, uvw crystal orientation
clear
close

fprintf('This program calculates the euler angles \n for the given {hkl}<uvw> \n')
fprintf('PLEASE ENTER h k l u v w of the crystal\n')
O= input('');         % crystal_orientation array
XO = sscanf(O,'%d');


h=XO(1);
k=XO(2);
l=XO(3);
u=XO(4);
v=XO(5);
w=XO(6);
t1=k*w-l*v;
t2=l*u-h*w;
t3=h*v-k*u;

b=sqrt(u^2+v^2+w^2);    % modulus of uvw vector
n=sqrt(h^2+k^2+l^2);    % modulus of hkl vector
t=sqrt(t1^2+t2^2+t3^2); % modulus of transverse vector

%% alternative calculation
phi = acosd(1/n);

if (h^2 + k^2)<0.01 
    phi1=0;
    phi2=phi1;
else
phi1= asind((w/b)*(n/sqrt(h^2 + k^2)));
phi2 = acosd(k/sqrt(h^2 + k^2));

end



%% Other method of calculating euler angles


% %% Calculation of direction cosines form hkl uvw and t1 t2 and t3
% 
%     a11= u/b;
%     a12= t1/t;
%     a13= h/n;
%     a21= v/b;
%     a22= t2/t;
%     a23= k/n;
%     a31= w/b;
%     a32= t3/t;
%     a33= l/n;
% 
%     
%    % A = [a11,a12,a13;a21,a22,a23;a31,a32,a33];
%     
%    if a33>0.99 || a33<-0.99 
%        phi = 0;
%        phi1 = (atand(a12/a11)); % As per formula given in Rollet L3, RHS is divided by 2 and phi2=phi1
%        phi2=0;                  % but if phi is 0, phi1 and phi2 are same rotations so they add.
%    else
%        phi=acosd(a33);
%        phi1=atan2d((a31/sin(phi)),(-a32/sin(phi))); 
%        phi2=atan2d((a13/sin(phi)),(a23/sin(phi))); 
%    end

%% output

 fprintf('phi1 = "%f" \n phi= "%f" \n phi2= "%f" \n',phi1, phi, phi2)   

