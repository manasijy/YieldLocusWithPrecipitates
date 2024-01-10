% sigma_xx = Data(1,g).Data(1,r).Stress_set(st,1);
% sigma_yy = Data(1,g).Data(1,r).Stress_set(st,2);
% load YieldLocus_Data;%_small;
sigma_xx = zeros(1,33);
sigma_yy = zeros(1,33);
Data = YieldLocusData;
p = 1;
for i = 1:1:33
    
sigma_xx(p) = Data(1,2).Data(1,i).Stress_set(1,1);
sigma_yy(p) = Data(1,2).Data(1,i).Stress_set(1,2);
p = p+1;
sigma_xx(p) = Data(1,2).Data(1,i).Stress_set(2,1);
sigma_yy(p) = Data(1,2).Data(1,i).Stress_set(2,2);
p = p+1;
end
plot(sigma_xx, sigma_yy, '+')


% X = -2:0.1:2;
% Y = -2:0.1:2;


% r=tan(0.5*psi);
% 
% [X,Y] = pol2cart(lambda,r);
% 
% %[c1,h1]=contour(X,Y,gamma_norm,30);
% 
% [c2,h2]=contour(X,Y,Meff,30);
% %clabel(c2,h2);
% axis([0.0 0.415 0.0 0.37]);