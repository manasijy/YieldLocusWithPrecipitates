function [e]= transform_e_function(e_ext,A)


%% This function transforms external strain tensor from sample reference frame to the crystal reference frame



e = [0,0,0;0,0,0;0,0,0];
 % Now calculating transformed strain tensor
    for i=1:1:3
        for j=1:1:3
             for k=1:1:3
                for l=1:1:3
              
                    e(i,j)= e(i,j)+ A(i,k)*A(j,l)*e_ext(k,l);
                
                end
             end
        end
    end
    
end

   