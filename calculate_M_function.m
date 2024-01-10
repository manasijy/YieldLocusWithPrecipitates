function [M_]=calculate_M_function(g_matrix,e_ext)




%% This function calculates the taylor factor for a given orientation (euler angle) matrix and external shape change 


global Co;

l =  length(g_matrix{1,1});
M = zeros(1, l);
for c=1:1:l


    A = DC_matrix_function(g_matrix{1,1}(c),g_matrix{1,2}(c),g_matrix{1,3}(c));
    [e_xtal]= transform_e_function(e_ext,A);
    [Wmax]  = maxwork_function(e_xtal);
    M(c)=Co*Wmax;
     
end

M_ = mean(M);

end
   