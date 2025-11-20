% ==============================================================
%   Coordinate Transformation of TLS Data
%   Author: Om Prakash Bhandari
%   Date: 21.11.2025
% ==============================================================


% Load the final merged point cloud in S4 frame
Merged_S4 = load('Data/Merged_Cloud_S4.txt');  % Nx3

% Translation vector
T_S4_WGS84 = [4014686.692, 499058.356, 4914517.523];

% Axis-angle rotation
axis_S4_WGS84 = [-0.3488, 0.1186, -0.9297];
axis_S4_WGS84 = axis_S4_WGS84 / norm(axis_S4_WGS84); % unit vector
theta_S4_WGS84 = deg2rad(131.509); % convert degrees to radians

% Rodrigues rotation matrix
K = [0 -axis_S4_WGS84(3) axis_S4_WGS84(2);
     axis_S4_WGS84(3) 0 -axis_S4_WGS84(1);
     -axis_S4_WGS84(2) axis_S4_WGS84(1) 0];

R_S4_WGS84 = eye(3) + sin(theta_S4_WGS84)*K + (1 - cos(theta_S4_WGS84))*(K*K);

% Transform all points from S4 frame to WGS84
Merged_WGS84 = (R_S4_WGS84 * Merged_S4')' + T_S4_WGS84;

writematrix(Merged_WGS84, 'Data/Merged_Cloud_WGS84.txt', 'Delimiter', ' ');

% ---------------------------------------------------------- %

% Load the georeferenced cloud
Merged_WGS84 = load('Data/Merged_Cloud_WGS84.txt');

% Compute centroid
centroid = mean(Merged_WGS84, 1);

% Convert centroid from ECEF to lat/lon/height
wgs84 = wgs84Ellipsoid('meter');
[lat, lon, h] = ecef2geodetic(wgs84, centroid(1), centroid(2), centroid(3));

fprintf('Estimated position: Latitude = %.6f°, Longitude = %.6f°, Height = %.2f m\n', lat, lon, h);

% Estimated position:
% Latitude = 50.727726°, Longitude = 7.086691°, Height = 110.41 m

% Which building was measured with the terrestrial laser scanner 
% in this task?

% The coordinates, when entered into Google Maps, point to the
% Institute of Geodesy and Geoinformation, Nußallee 17A, 53115 Bonn.