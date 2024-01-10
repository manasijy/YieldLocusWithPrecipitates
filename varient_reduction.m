clear;
close;
CS = crystalSymmetry('-43m'); % Cubic system
fprintf('Please enter ppt direction.\n In case of needle enter "u v w" and incase of plate enter "h k l" \n');
direction = input('');
d = sscanf(direction,'%d');
direction_miller =  Miller(d(1),d(2),d(3),CS,'hkl'); % direction_miller is a variable of class miller and it stores the ppt direction
                                               % in a vector3d class miller
                                               % form
varients = symmetrise(direction_miller);       % It stores all varients of the ppt in variable 'varients' 
n_varients = length(varients);
varient= varients;
count=0;
for p=n_varients:-1:2
    for q=1:1:p-1
        v1 = [varients(p,1).h,varients(p,1).k,varients(p,1).l];
        v2 = [varients(q,1).h,varients(q,1).k,varients(q,1).l];
        v1_unit = v1/norm(v1);
        v2_unit = v2/norm(v2);
        dot_v1v2 = dot(v1_unit,v2_unit);
        T(p,q) = round(acosd(dot_v1v2));
     
      if (T(p,q)==180)
          varient(p)=[];
      end
    end
end