% ==============================================================
%   Coordinate Transformation of TLS Data
%   Author: Om Prakash Bhandari
%   Date: 21.11.2025
% ==============================================================

% ---------------- Step 0: Load all point clouds ----------------
S1 = load('Data\S1_PointCloud_Cartesian.txt');
S2 = load('Data\S2_PointCloud_Cartesian.txt');
S3 = load('Data\S3_PointCloud_Cartesian.txt');
S4 = load('Data\S4_PointCloud_Cartesian.txt');
S9 = load('Data\S9_PointCloud_Cartesian.txt');
S10 = load('Data\S10_PointCloud_Cartesian.txt');

% ---------------- Step 1: S9 -> S10 ----------------
T_S9S10 = [6.937, -20.959, -5.135];
axis_S9S10 = [0.6860, -0.2068, -0.6976]; axis_S9S10 = axis_S9S10/norm(axis_S9S10);
theta_S9S10 = deg2rad(1.692);

K = [0 -axis_S9S10(3) axis_S9S10(2);
     axis_S9S10(3) 0 -axis_S9S10(1);
     -axis_S9S10(2) axis_S9S10(1) 0];
R_S9S10 = eye(3) + sin(theta_S9S10)*K + (1 - cos(theta_S9S10))*(K*K);

S9_in_S10 = (R_S9S10 * S9')' + T_S9S10;

% ---------------- Step 2: S10 -> S1 ----------------
T_S10S1 = [13.355, 37.179, 4.224];
axis_S10S1 = [-0.0290, -0.0024, 0.9996]; axis_S10S1 = axis_S10S1/norm(axis_S10S1);
theta_S10S1 = deg2rad(43.537);

K = [0 -axis_S10S1(3) axis_S10S1(2);
     axis_S10S1(3) 0 -axis_S10S1(1);
     -axis_S10S1(2) axis_S10S1(1) 0];
R_S10S1 = eye(3) + sin(theta_S10S1)*K + (1 - cos(theta_S10S1))*(K*K);

Points_in_S10_frame = [S10; S9_in_S10];
Points_in_S1 = (R_S10S1 * Points_in_S10_frame')' + T_S10S1;

% ---------------- Step 3: S1 -> S2 ----------------
T_S1S2 = [20.672, 33.373, 0.119];
axis_S1S2 = [0.0005, 0.0001, -1.0000]; axis_S1S2 = axis_S1S2/norm(axis_S1S2);
theta_S1S2 = deg2rad(79.015);

K = [0 -axis_S1S2(3) axis_S1S2(2);
     axis_S1S2(3) 0 -axis_S1S2(1);
     -axis_S1S2(2) axis_S1S2(1) 0];
R_S1S2 = eye(3) + sin(theta_S1S2)*K + (1 - cos(theta_S1S2))*(K*K);

Points_in_S1_frame = [S1; Points_in_S1];
Points_in_S2 = (R_S1S2 * Points_in_S1_frame')' + T_S1S2;

% ---------------- Step 4: S2 -> S3 ----------------
T_S2S3 = [-12.077, 23.572, 0.247];
axis_S2S3 = [0.0228, -0.0020, 0.9997]; axis_S2S3 = axis_S2S3/norm(axis_S2S3);
theta_S2S3 = deg2rad(36.099);

K = [0 -axis_S2S3(3) axis_S2S3(2);
     axis_S2S3(3) 0 -axis_S2S3(1);
     -axis_S2S3(2) axis_S2S3(1) 0];
R_S2S3 = eye(3) + sin(theta_S2S3)*K + (1 - cos(theta_S2S3))*(K*K);

Points_in_S2_frame = [S2; Points_in_S2];
Points_in_S3 = (R_S2S3 * Points_in_S2_frame')' + T_S2S3;

% ---------------- Step 5: S3 -> S4 ----------------
T_S3S4 = [-3.715, -33.172, 0.109];
axis_S3S4 = [-0.0062, -0.0089, 0.9999]; axis_S3S4 = axis_S3S4/norm(axis_S3S4);
theta_S3S4 = deg2rad(93.143);

K = [0 -axis_S3S4(3) axis_S3S4(2);
     axis_S3S4(3) 0 -axis_S3S4(1);
     -axis_S3S4(2) axis_S3S4(1) 0];
R_S3S4 = eye(3) + sin(theta_S3S4)*K + (1 - cos(theta_S3S4))*(K*K);

Points_in_S3_frame = [S3; Points_in_S3];
Points_in_S4 = (R_S3S4 * Points_in_S3_frame')' + T_S3S4;

% ---------------- Step 6: Merge with S4 original ----------------
AllPoints_in_S4 = [S4; Points_in_S4];

% ---------------- Step 7: Save final merged cloud ----------------
writematrix(AllPoints_in_S4, 'Data/Merged_Cloud_S4.txt', 'Delimiter', ' ');
