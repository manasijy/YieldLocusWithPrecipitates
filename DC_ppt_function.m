%% This function is used to calculate the direction cosine matrices for
% different varients of a precipitate. This function uses MTex functions 
% therefore, one is required to install MTex. It was developed on older 
% versions so it might need to be slightly modified to be compatible with
% latest MTex versions.

function [DC_ppt,n_varient,varient]= DC_ppt_function(CS,d)

direction_miller = Miller(str2num(d(1)),str2num(d(2)),str2num(d(3)),CS,'uvw');
varients = symmetrise(direction_miller);

%% Checking for any repetition of the varient directions or inversions
varient = varient_reduction_function(varients);

%% Now finding out the axis angle pair for the rotation of crystal frame to the ppt frame
n_varient = length(varient);

    for i=1:1:n_varient
        rot_axis = cross(vector3d(0,0,1),vector3d(varient(i).xyz));
        rot_angle = angle(vector3d(0,0,1),vector3d(varient(i).xyz));
        o{i} = rotation('axis',rot_axis,'angle',rot_angle);
        DC_ppt{i} = matrix(o{i})'; 
    end     


