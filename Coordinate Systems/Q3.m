% ==============================================================
%   Coordinate Transformation of TLS Data (Q3)
%   Author: Om Prakash Bhandari
%   Date: 21.11.2025
% ==============================================================

% Load the final merged point cloud in S4 frame
Merged_S4 = load('Data/Merged_Cloud_S4.txt');

% Translation vector
T_S4_WGS84 = [4014686.692, 499058.356, 4914517.523];

% Axis-angle rotation
axis_S4_WGS84 = [-0.3488, 0.1186, -0.9297];
axis_S4_WGS84 = axis_S4_WGS84 / norm(axis_S4_WGS84);

theta = deg2rad(131.509);   % rotation angle (radians)
ux = axis_S4_WGS84(1);
uy = axis_S4_WGS84(2);
uz = axis_S4_WGS84(3);

c = cos(theta);
s = sin(theta);
v = 1 - c;

% Rotation matrix using explicit axis-angle formula
R_S4_WGS84 = [
    c + ux^2*v,      ux*uy*v - uz*s,  ux*uz*v + uy*s;
    uy*ux*v + uz*s,  c + uy^2*v,      uy*uz*v - ux*s;
    uz*ux*v - uy*s,  uz*uy*v + ux*s,  c + uz^2*v
];

% Transform all points from S4 frame to WGS84
Merged_WGS84 = (R_S4_WGS84 * Merged_S4')' + T_S4_WGS84;

writematrix(Merged_WGS84, 'Data/Merged_Cloud_WGS84.txt', 'Delimiter', ' ');

% ---------------------------------------------------------- %

% Load the georeferenced cloud
Merged_WGS84 = load('Data/Merged_Cloud_WGS84.txt');

% Compute centroid
centroid = mean(Merged_WGS84, 1);

% Convert centroid to lat/lon/height

% E = wgs84Ellipsoid creates a referenceEllipsoid object for the
% World Geodetic System of 1984 (WGS84) reference ellipsoid.
% By default, the lengths of the semimajor axis and semiminor axis
% are in meters.

wgs84 = wgs84Ellipsoid('meter');
[lat, lon, h] = ecef2geodetic(wgs84, centroid(1), centroid(2), centroid(3));

fprintf('Estimated position: Latitude = %.6f°, Longitude = %.6f°, Height = %.2f m\n', ...
        lat, lon, h);
