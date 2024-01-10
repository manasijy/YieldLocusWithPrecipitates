%% This program transforms the external strain tensor to the crystal reference frame. 
% The x direction of the external strain is taken along RD, TD and 45 from RD. 
% The crystal orientation is asked in the euler angle notation in a .txt file format

clear;
close;



%% Reading the external strain tensor

fprintf('Please enter strain condition \n For plane strain input 1 \n For axisymmetric strain inpur 2 \n For any other strain condition enter 3 \n')
 

y = input('');
         
 switch y
     case 1 
             e_ext= [1,0,0;0,-1,0;0,0,0];
     case 2 
             e_ext= [1,0,0;0,-0.5,0;0,0,-0.5]; 
             %e_ext= [-0.5,0,0;0,1,0;0,0,-0.5]; 
     case 3
             prompt = 'Please enter the external strain matrix : e11 e12 e13 e21 e22 e23 e31 e32 e33\n';
             e_ext = input(prompt);
     otherwise
             warning('Unexpected choice entered. strain tensor can not be calculated.');
             break;
 end



%% Reading the orientation data file 
prompt = 'The euler angle file name with .txt extension \n';
g_vectorfile = input(prompt);                       %% this stores the file name in a string array variable g_vectorfile. This file is an array of orientation vectors, each vector has three euler angles as components.
g = fopen(g_vectorfile);                            %% g stores the link to the file g_vectorfile

g_matrix_RD = textscan(g, '%f %f %f');              %% g_matrix stores the file (g_vectorfile) data in a matrix 
fclose(g);

A = DC_matrix_function(g_matrix_RD{1,1}(1),g_matrix_RD{1,2}(1),g_matrix_RD{1,3}(1));
                            [e]= transform_e_function(e_ext,A);
                            disp(e)
g_matrix_TD = g_matrix_RD;
g_matrix_TD{1,3}(:) = g_matrix_TD{1,3}(:)-90;       %g_matrix_TD{1,1}(:)+90; in place of g_matrix_TD{1,3}(:)+90;

A = DC_matrix_function(g_matrix_TD{1,1}(1),g_matrix_TD{1,2}(1),g_matrix_TD{1,3}(1));
                            [e]= transform_e_function(e_ext,A);
                            disp(e)
g_matrix_45RD = g_matrix_RD;
g_matrix_45RD{1,3}(:) = g_matrix_45RD{1,3}(:)-45;

A = DC_matrix_function(g_matrix_45RD{1,1}(1),g_matrix_45RD{1,2}(1),g_matrix_45RD{1,3}(1));
                            [e]= transform_e_function(e_ext,A);
                           disp(e)

%% This program was created to calculate the strain tensor as resolved in the crystal reference frame. When we give certain external strain, we already fix the x,y and z axis. 
%We can change the axes either by swaping rows of the strain matrix or by
%rotating the phi1 euler angle. Here, both approaches can be taken. 
 


