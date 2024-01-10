%% This program calculates and plots M vs. tensile direction 


clear;      
close;


%% Declaration of variables


global Co;
global BH;

ro =0;
e_ext= zeros(3,3);
Co = sqrt(6);


%% Creating Bishop Hill stress state matrix from the text file named: BHfile.txt

B = fopen('BHfile.txt');
BH = textscan(B, ' %f %f %f %f %f %f');
fclose(B);



%% Code to plot M vs theta



Mtheta = zeros(10,11);
ro_min = zeros(10,1);
M_min = zeros(10,1);
theta = zeros(10,1);
r_value = zeros(10,1);






    
    %% Reading the orientation data file 
prompt = 'The euler angle file name with .txt extension \n';
g_vectorfile = input(prompt);                       %% this stores the file name in a string array variable g_vectorfile. This file is an array of orientation vectors, each vector has three euler angles as components.
g = fopen(g_vectorfile);                            %% g stores the link to the file g_vectorfile


g_matrix_RD = textscan(g, '%f %f %f');              %% g_matrix stores the file (g_vectorfile) data in a matrix 
fclose(g);


%% Changing the tensile direction incrementally and calculating M vs ro for each g file
    for i=1:1:10

           g_matrix_theta = g_matrix_RD;
           g_matrix_theta{1,1}(:) = g_matrix_theta{1,1}(:)-10*(i-1);       
           theta(i)= 10*(i-1);

                for j=1:1:11

                    ro= 0.1*(j-1);
                    e_ext= [1,0,0;0,-ro,0;0,0,ro-1];

                    Mtheta(i,j) = calculate_M_function(g_matrix_theta,e_ext);

                end

           for k=1:1:11
              if Mtheta(i,k)== min(Mtheta(i,:))
                 ro_min(i) = 0.1*(k-1);
                 r_value(i)= ro_min(i)/(1-ro_min(i)); %r_value
                 M_min(i) = min(Mtheta(i,:));
                 break;
              end
           end           
           
           
    end

 %plotyy(theta,r_value,theta,M_min)
 figure   
 plot(theta,r_value,'-.+r')
 xlabel('theta (degree)');
 ylabel('r_value');
 
 figure
 
 plot(theta,M_min,'--xg')
 xlabel('theta (degree)');
 ylabel('M');

