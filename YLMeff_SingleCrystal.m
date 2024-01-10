clear;      
% close;
 CS = crystalSymmetry('-43m');
%% Creating Bishop Hill stress state matrix from the text file named: BHfile.txt

B = fopen('BHfile.txt');
BH = textscan(B, ' %f %f %f %f %f %f');
fclose(B);

%% ppt details

% shape = 'Needle'; %or 'Plate
d1 = '100';d2 = '110';d3 = '111';
Dircn = {d1, d2, d3}; 
colr = ['r' ,'m', 'k'];
f = 0.008;
sigma_bar = 10000e6;
tau = 88e6;
w = 1; % this code has not incoporated w. We have to figure out how to get it incase of other habits
 
%% Reading the orientation file


prompt = 'The euler angle file name with .txt extension \n';
g_vectorfile = input(prompt);                        
file_g = fopen(g_vectorfile);                            
g_matrix = textscan(file_g, '%f %f %f'); 
fclose(file_g);
l_g =  length(g_matrix{1,1});
 

%% Reading the strain file

S = fopen('strains.txt');
strain = textscan(S, ' %f %f %f ');
l_s =  length(strain{1,1});
fclose(S);
Meff = zeros(l_s,11);
ro = zeros(l_s,11);
g = zeros(l_s,11);
for di=1:1:3
  
    [DC_ppt,n_varient,varient]= DC_ppt_function(CS,Dircn{di});

     for u=1:1:l_s
         for v = 1:1:11
             gamma12 = -1 + 0.2*(v-1);
         e_ext=[strain{1,1}(u),gamma12,0;gamma12,strain{1,2}(u),0;0,0,strain{1,3}(u)];
         Weff= zeros(l_g,1);
             for c=1:1:l_g
                A = DC_matrix_function(g_matrix{1,1}(c),g_matrix{1,2}(c),g_matrix{1,3}(c));
               [e]= transform_e_function(e_ext,A);
               N = Nxtal_general_function(A,e_ext,DC_ppt,n_varient);
%                [N,w]= Nxtal_calc_function1(A,e_ext); 
                W= zeros(1,56);
                BH_state = zeros(56,6);

                        for m=1:1:56 
                            W(m)= -(BH{1,2}(m)*e(1,1))+ BH{1,1}(m)*e(2,2)+ BH{1,4}(m)*(e(2,3)+e(3,2))+BH{1,5}(m)*(e(1,3)+e(3,1))+BH{1,6}(m)*(e(1,2)+e(2,1));
                            BH_state(m,:) = [BH{1,1}(m),BH{1,2}(m),BH{1,3}(m),BH{1,4}(m),BH{1,5}(m),BH{1,6}(m)]; % [A,B,C,F,G,H]
                        end

                        Wmax = max(abs(W));
                        Weff(c) = (1-f)*Wmax + f*w*N*sigma_bar/(tau);
            end
        Meff(u,v) = mean(Weff)/e_ext(1,1);
        ro(u,v) = -strain{1,2}(u)/strain{1,1}(u);
        g(u,v) = gamma12/strain{1,1}(u);
         end
     end 
    
%% Section Contour calculation

            % change the range of kk to  1:6 to plot sections along various
            % Txy
 kk = 1;

    for u=1:1:l_s  
        for v=1:1:11
            %aX+bY = M - cZ, a =1; b = -rho 
              b= -ro(u,v);
              c= 2*g(u,v);
              Txy = 0.1*(kk-1);
              m = Meff(u,v)-c*Txy; 
              lineq = [-1/b,m/b];
              Y = polyval(lineq,-5:0.5:5);
              plot(-5:0.5:5,Y)
              hold on                                                    
        end
    end
pbaspect([1 1 1])              
grid on;
text(-1,0,Dircn(di),'Color','black','FontSize',16);
xlim([-4 4]);
ylim([-4 4]);
xlabel('SigmaXX');
ylabel('SigmaYY');              
figure
end
% clearvars A B BH_State W e Wmax gamma12 e_ext g_matrix g_vectorfile l_g g Meff Y b c Txy;

%% Now for solutionized state
f = 0;
 for u=1:1:l_s
         for v = 1:1:11
             gamma12 = -1 + 0.2*(v-1);
         e_ext=[strain{1,1}(u),gamma12,0;gamma12,strain{1,2}(u),0;0,0,strain{1,3}(u)];
         Weff= zeros(l_g,1);
             for c=1:1:l_g
                A = DC_matrix_function(g_matrix{1,1}(c),g_matrix{1,2}(c),g_matrix{1,3}(c));
               [e]= transform_e_function(e_ext,A);
%                N = Nxtal_general_function(A,e_ext,DC_ppt,n_varient);
% %                [N,w]= Nxtal_calc_function1(A,e_ext); 
                W= zeros(1,56);
                BH_state = zeros(56,6);

                        for m=1:1:56 
                            W(m)= -(BH{1,2}(m)*e(1,1))+ BH{1,1}(m)*e(2,2)+ BH{1,4}(m)*(e(2,3)+e(3,2))+BH{1,5}(m)*(e(1,3)+e(3,1))+BH{1,6}(m)*(e(1,2)+e(2,1));
                            BH_state(m,:) = [BH{1,1}(m),BH{1,2}(m),BH{1,3}(m),BH{1,4}(m),BH{1,5}(m),BH{1,6}(m)]; % [A,B,C,F,G,H]
                        end

                        Wmax = max(abs(W));
                        Weff(c) = Wmax;
            end
        Meff(u,v) = mean(Weff)/e_ext(1,1);
        ro(u,v) = -strain{1,2}(u)/strain{1,1}(u);
        g(u,v) = gamma12/strain{1,1}(u);
         end
 end
 
   
%% Section Contour calculation


 kk = 1;
    for u=1:1:l_s  
        for v=1:1:11
            %aX+bY = M - cZ, a =1; b = -rho 

              b= -ro(u,v);
              c= 2*g(u,v);
              Txy = 0.1*(kk-1);
              m = Meff(u,v)-c*Txy; 
              lineq = [-1/b,m/b];
              Y = polyval(lineq,-5:0.5:5);
              plot(-5:0.5:5,Y)
              hold on
             
                          
        end
    end     
 pbaspect([1 1 1]) 
 grid on;
 text(-1,0,'No ppt','Color','black','FontSize',16);
xlim([-4 4]);
ylim([-4 4]);
xlabel('SigmaXX');
ylabel('SigmaYY');    
% clearvars A B BH_State W e Wmax gamma12 strain e_ext g_matrix g_vectorfile l_g ;