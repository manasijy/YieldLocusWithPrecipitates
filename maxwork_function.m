function [Wmax]= maxwork_function(e)




%% This function calculates the maximum work done by bishop hill stress states to achieve the specified shape change e
% BH is the matrix containing the 56 bishop hill stress states




global BH;
Wmax=0;

for m=1:1:56
    
    W= -(BH{1,2}(m)*e(1,1))+ BH{1,1}(m)*e(2,2)+ BH{1,4}(m)*(e(2,3)+e(3,2))+BH{1,5}(m)*(e(1,3)+e(3,1))+BH{1,6}(m)*(e(1,2)+e(2,1));
    if (W> Wmax) 
       
        Wmax=W;
       
    end                            
end

end 