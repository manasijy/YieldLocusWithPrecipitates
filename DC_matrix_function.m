%% This function creates the direction cosine matrix for one set of euler angles
% This is a common utility function used in many of the programs in other repositories

function [DC] = DC_matrix_function(phi1,phi,phi2) 

    c1 = cosd(phi1);
    c2 = cosd(phi2);
    c0 = cosd(phi);
    s1 = sind(phi1);
    s2 = sind(phi2);
    s0 = sind(phi);
    
    % Now calculating direction cosine matrix for conversion into the
    % crystal reference frame
    a11= c1*c2-s1*s2*c0;
    a12= s1*c2+c1*s2*c0;
    a13= s2*s0;
    a21= -c1*s2-s1*c2*c0;
    a22= -s1*s2+c1*c2*c0;
    a23= c2*s0;
    a31= s1*s0;
    a32= -c1*s0;
    a33= c0;
    
    DC = [a11,a12,a13;a21,a22,a23;a31,a32,a33];
       
end
    
