 function [N] = calc_Nbar_general_function(g_matrix,e_ext,DC_ppt,n_varients,varargin)% 

 
%% function calc_Nbar_function(g_matrix,e_ext)
l =  length(g_matrix{1,1});
%N = zeros(1,3);
a =2/3;
b =1/3; 
N_bar = zeros(1,l);
N = zeros(1,n_varients);
 
                    for c=1:1:l
                        
                        A = DC_matrix_function(g_matrix{1,1}(c),g_matrix{1,2}(c),g_matrix{1,3}(c));
                      
                        for i=1:1:n_varients
                            e_xtal= transform_e_function(e_ext,A);
                            [e]= transform_e_function(e_xtal,DC_ppt{i});
                            en= (e(1,1)^2+e(2,2)^2+e(3,3)^2);                            
                            N(i)= sqrt(a*en + b*(2*e(1,2))^2);                            
                        end
                        
                        N_bar(c) = mean(N);                        
                    end
                N = mean(N_bar);
 end

