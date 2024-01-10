%% calculating length of b, n and t vectors
function [A] = singleX_DC_function(O)

h=O(1);
k=O(2);
l=O(3);
u=O(4);
v=O(5);
w=O(6);
t1=O(7);
t2=O(8);
t3=O(9);
b=sqrt(u^2+v^2+w^2);    % modulus of uvw vector
n=sqrt(h^2+k^2+l^2);    % modulus of hkl vector
t=sqrt(t1^2+t2^2+t3^2); % modulus of transverse vector

%% Calculation of direction cosines form hkl uvw and t1 t2 and t3

    a11= u/b;
    a12= t1/t;
    a13= h/n;
    a21= v/b;
    a22= t2/t;
    a23= k/n;
    a31= w/b;
    a32= t3/t;
    a33= l/n;

    
    A = [a11,a12,a13;a21,a22,a23;a31,a32,a33];