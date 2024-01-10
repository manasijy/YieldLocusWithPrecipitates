% sigma_xx = Data(1,g).Data(1,r).Stress_set(st,1);
% sigma_yy = Data(1,g).Data(1,r).Stress_set(st,2);
% load YieldLocus_Data;%_small;
sigma_xx = zeros(1,39);
sigma_yy = zeros(1,39);
slope = zeros(1,39);
Data = YieldLocusData;
p = 1;
rho_l = length(Data(1,1).Data);
for i = 1:1:39
    
sigma_xx(p) = Data.Data(1,i).Stress_set(1,1);
sigma_yy(p) = Data.Data(1,i).Stress_set(1,2);
slope(p)= Data.Data(1,i).Rho;
p = p+1;
sigma_xx(p) = Data.Data(1,i).Stress_set(2,1);
sigma_yy(p) = Data.Data(1,i).Stress_set(2,2);
slope(p)= Data.Data(1,i).Rho;
p = p+1;
end

% sigma_xx(p) = Data(1,2).Data(1,i).Stress_set(1,1);
% sigma_yy(p) = Data(1,2).Data(1,i).Stress_set(1,2);
% slope(p)= Data(1,2).Data(1,i).Rho;
% p = p+1;
% sigma_xx(p) = Data(1,2).Data(1,i).Stress_set(2,1);
% sigma_yy(p) = Data(1,2).Data(1,i).Stress_set(2,2);
% slope(p)= Data(1,2).Data(1,i).Rho;
% p = p+1;

for k = 1:1:(p-1)
    x1 = sigma_xx(k);
    y1 = sigma_yy(k);
    X = (x1-3):0.1:(x1+3);
    m = -1/slope(k);
    if (m ~= Inf) 
    Y = m*(X - x1)+y1;
    else Y = y1;
    end
    plot(X,Y,'-')
    hold on
end
% plot(X(:,:),Y(:,:),'.')
% hold on
plot(sigma_xx, sigma_yy, '+')
hold off


