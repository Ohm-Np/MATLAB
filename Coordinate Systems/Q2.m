% =====================================================================
%   Coordinate Transformation of TLS Data (Q2) 
%   Author: Om Prakash Bhandari
%   Date: 21.11.2025
% =====================================================================

function merge_clouds_to_S4()

% ---------------------- Load All Point Clouds ------------------------
S1  = load('Data/S1_PointCloud_Cartesian.txt');
S2  = load('Data/S2_PointCloud_Cartesian.txt');
S3  = load('Data/S3_PointCloud_Cartesian.txt');
S4  = load('Data/S4_PointCloud_Cartesian.txt');
S9  = load('Data/S9_PointCloud_Cartesian.txt');
S10 = load('Data/S10_PointCloud_Cartesian.txt');

% Identity matrix for Rodrigues formula
I = eye(3);

% Helper function: Rodrigues rotation

    function R = rodrigues(axis, ang)
        axis = axis / norm(axis);
        ax = [     0      -axis(3)   axis(2);
                axis(3)      0      -axis(1);
               -axis(2)   axis(1)      0     ];
        R = cosd(ang)*I + (1 - cosd(ang))*(axis'*axis) + sind(ang)*ax;
    end


% -------------------------- Step 1: S9 → S10 -------------------------
R_9_10 = rodrigues([0.6860, -0.2068, -0.6976], 1.692);
t_9_10 = [6.937, -20.959, -5.135];

S9_in_S10 = (R_9_10 * S9')' + t_9_10;


% -------------------------- Step 2: S10 → S1 -------------------------
R_10_1 = rodrigues([-0.0290, -0.0024, 0.9996], 43.537);
t_10_1 = [13.355, 37.179, 4.224];

S9_in_S1  = (R_10_1 * S9_in_S10')' + t_10_1;
S10_in_S1 = (R_10_1 * S10')'       + t_10_1;


% -------------------------- Step 3: S1 → S2 -------------------------
R_1_2 = rodrigues([0.0005, 0.0001, -1.0000], 79.015);
t_1_2 = [20.672, 33.373, 0.119];

S9_in_S2  = (R_1_2 * S9_in_S1')'  + t_1_2;
S10_in_S2 = (R_1_2 * S10_in_S1')' + t_1_2;
S1_in_S2  = (R_1_2 * S1')'        + t_1_2;


% -------------------------- Step 4: S2 → S3 -------------------------
R_2_3 = rodrigues([0.0228, -0.0020, 0.9997], 36.099);
t_2_3 = [-12.077, 23.572, 0.247];

S9_in_S3  = (R_2_3 * S9_in_S2')'  + t_2_3;
S10_in_S3 = (R_2_3 * S10_in_S2')' + t_2_3;
S1_in_S3  = (R_2_3 * S1_in_S2')'  + t_2_3;
S2_in_S3  = (R_2_3 * S2')'        + t_2_3;


% -------------------------- Step 5: S3 → S4 -------------------------
R_3_4 = rodrigues([-0.0062, -0.0089, 0.9999], 93.143);
t_3_4 = [-3.715, -33.172, 0.109];

S9_in_S4  = (R_3_4 * S9_in_S3')'  + t_3_4;
S10_in_S4 = (R_3_4 * S10_in_S3')' + t_3_4;
S1_in_S4  = (R_3_4 * S1_in_S3')'  + t_3_4;
S2_in_S4  = (R_3_4 * S2_in_S3')'  + t_3_4;
S3_in_S4  = (R_3_4 * S3')'        + t_3_4;


% ---------------- Merge all clouds in S4 frame -----------------------
AllPoints_S4 = [
    S4;
    S1_in_S4;
    S2_in_S4;
    S3_in_S4;
    S9_in_S4;
    S10_in_S4
];

% ------------------------ Save merged cloud --------------------------
writematrix(AllPoints_S4, 'Data/Merged_Cloud_S4.txt', 'Delimiter', ' ');

fprintf("All clouds successfully transformed into S4 frame and merged.\n");

end

% ----------------------- Run function --------------------------------
merge_clouds_to_S4
