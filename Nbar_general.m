%% This program calculates average precipitate strengthening factor N_bar for the applied strain tensor. 
% N_bar is the average strenghening factor for the all three varients of
% precipitates.
% N_bar is calculated for the tensile axis orientation along RD, TD and 45
% degrees from RD


clear;
close;



%% Reading the external strain tensor

y = input('Please enter strain condition \n For plane strain input 1 \n For axisymmetric strain inpur 2 \n For any other strain condition enter 3 \n');
         
 switch y
     case 1 
             e_ext= [1,0,0;0,-1,0;0,0,0];
     case 2 
             e_ext= [1,0,0;0,-0.5,0;0,0,-0.5]; 
     case 3
             prompt = 'Please enter the external strain matrix : e11 e12 e13 e21 e22 e23 e31 e32 e33\n';
             e_ext = input(prompt);
     otherwise
             warning('Unexpected choice entered. N_bar can not be calculated.');
%              break;
 end



%% Reading the orientation data file 
prompt = 'The euler angle file name with .txt extension \n';
g_vectorfile = input(prompt);                       %% this stores the file name in a string array variable g_vectorfile. This file is an array of orientation vectors, each vector has three euler angles as components.
g = fopen(g_vectorfile);                            %% g stores the link to the file g_vectorfile

g_matrix_RD = textscan(g, '%f %f %f');              %% g_matrix stores the file (g_vectorfile) data in a matrix 
g_matrix_TD = g_matrix_RD;
g_matrix_TD{1,1}(:) = g_matrix_TD{1,1}(:)-90;       %g_matrix_TD{1,1}(:)+90; in place of g_matrix_TD{1,3}(:)+90;
g_matrix_45RD = g_matrix_RD;
g_matrix_45RD{1,1}(:) = g_matrix_45RD{1,1}(:)-45;

%% ppt information

[shape,DC_ppt,n_varients]= DC_ppt_function();



%%

N(1) = calc_Nbar_general_function(g_matrix_RD,e_ext,DC_ppt,n_varients);
N(2)= calc_Nbar_general_function(g_matrix_TD,e_ext,DC_ppt,n_varients);
N(3)= calc_Nbar_general_function(g_matrix_45RD,e_ext,DC_ppt,n_varients);


fprintf('N average for RD test = "%f" \n', N(1))
fprintf('N average for TD test = "%f" \n', N(2))
fprintf('N average for 45RD test = "%f" \n',N(3))
 











