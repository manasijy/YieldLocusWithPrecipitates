% clear;      
% close;

%% Creating Bishop Hill stress state matrix from the text file named: BHfile.txt

B = fopen('BHfile.txt');
BH = textscan(B, ' %f %f %f %f %f %f');
fclose(B);

%% ppt details
f = 0.008;
sigma_bar = 10000e6;
tau = 88e6;


%% Euler angle input block-  optional
% !! need to change the code
% prompt = 'Please input euler angles [phi1,phi,phi2] \n';
% g_matrix = input(prompt);
% l_g = 1;

%% Reading the orientation file

prompt = 'The euler angle file name with .txt extension \n';
g_vectorfile = input(prompt);                        
g = fopen(g_vectorfile);                            
g_matrix = textscan(g, '%f %f %f');               
l_g =  length(g_matrix{1,1});

%% Reading the strain file

S = fopen('strains.txt');
strain = textscan(S, ' %f %f %f ');
l_s =  length(strain{1,1});
fclose(S);
% YieldLocusData = struct();
% CrystalData =struct();
M = zeros(1,l_s);
Nbar = zeros(1,l_s);
wt = zeros(1,l_s);
ro = zeros(1,l_s);
Meff_g = zeros(1,l_s);
Meff = zeros(1,l_s);

    for u=1:1:l_s
         e_ext=[strain{1,1}(u),0,0;0,strain{1,2}(u),0;0,0,strain{1,3}(u)];
         Wmax= zeros(1,l_g);
         N = zeros(1,l_g);
         w = zeros(1,l_g);
        for c=1:1:l_g
            
            
            A = DC_matrix_function(g_matrix{1,1}(c),g_matrix{1,2}(c),g_matrix{1,3}(c));
            [e]= transform_e_function(e_ext,A);
            [N(c),w(c)]= Nxtal_calc_function1(A,e_ext);    % Added
            W= zeros(1,56);
            BH_state = zeros(56,6);
            
                    for m=1:1:56 

                        W(m)= -(BH{1,2}(m)*e(1,1))+ BH{1,1}(m)*e(2,2)+ BH{1,4}(m)*(e(2,3)+e(3,2))+BH{1,5}(m)*(e(1,3)+e(3,1))+BH{1,6}(m)*(e(1,2)+e(2,1));
                        BH_state(m,:) = [BH{1,1}(m),BH{1,2}(m),BH{1,3}(m),BH{1,4}(m),BH{1,5}(m),BH{1,6}(m)]; % [A,B,C,F,G,H]
                    end
                    
                    Wmax(c)= max(abs(W)); %/e_ext(1,1);
        
%         CrystalData(u).M = Wmax;
%         CrystalData(u).Nbar = N/e_ext(1,1);
%         CrystalData(u).wt = w;
%         CrystalData(u).Rho = -strain{1,2}(u)/strain{1,1}(u); 
%         
%         YieldLocusData(c).Ori= [g_matrix{1,1}(c),g_matrix{1,2}(c),g_matrix{1,3}(c)];
%         YieldLocusData(c).Data = CrystalData;

          Meff_g(c) = (1-f)*Wmax(c) + f*w(c)*N(c)*sigma_bar/(tau);
        
        end
        Meff(u) = mean(Meff_g)/e_ext(1,1);
%         Nbar(u) = mean(N);%/e_ext(1,1);
%         wt(u) = mean(w);%/e_ext(1,1);
        ro(u) = -strain{1,2}(u)/strain{1,1}(u);
    end 
% save('YieldLocus_Data')


%% Plot input data preparation


% ro = zeros(1,39);
% M = zeros(1,39);
% Data = YieldLocusData;
% p = 1;
% rho_l = length(Data(1,1).Data);

% for p = 1:1:l_s
% Meff(p) = (1-f)*M(p) + f*wt(p)*Nbar(p)*sigma_bar/(tau);
% end

figure
for k = 1:1:l_s
if (ro(k) == 0) 
        Y = -4:0.2:4;
        X = Meff(k)*ones(numel(Y));
    else
    X = -4:0.2:4;
    c = -Meff(k);    
    Y = (X+c)/ro(k);    
end    
    plot(X,Y,'-')
    hold on
end

% For negative M values

for k = 1:1:l_s
if (ro(k) == 0) 
        Y = -4:0.2:4;
        X = -Meff(k)*ones(numel(Y));
    else
    X = -4:0.2:4;
    c = Meff(k);    
    Y = (X+c)/ro(k);    
end    
    plot(X,Y,'-')
    hold on
end

xlim([-4 4]);
ylim([-4 4]);
hold off


