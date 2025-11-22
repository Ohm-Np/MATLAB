% ==============================================================
%   Coordinate Transformation of TLS Data (Q1)
%   Author: Om Prakash Bhandari
%   Date: 21.11.2025
% ==============================================================


% List of file prefixes
files = ["S1", "S2", "S3", "S4", "S9", "S10"];

% function to load & convert point clouds in Spherical Coordinates
% into Cartesian Coordinates
for i = 1:length(files)

    name = files(i);

    % ----- Load input file -----
    infile = "Data/" + name + "_PointCloud.txt";
    data = load(infile);

    d     = data(:,1);
    phiI  = data(:,2);
    theta = data(:,3);

    % ----- Convert inclination -> MATLAB elevation -----
    phiM = pi/2 - phiI;

    % ----- Spherical → Cartesian -----

    % [x,y,z] = sph2cart(azimuth,elevation,r) transforms 
    % corresponding elements of the spherical coordinate arrays
    % azimuth, elevation, and r 
    % to Cartesian, or xyz, coordinates

    [x, y, z] = sph2cart(theta, phiM, d);
    cartesian_points = [x, y, z];

    % ----- Save output file -----
    outfile = "Data/" + name + "_PointCloud_Cartesian.txt";
    writematrix(cartesian_points, outfile, 'Delimiter', ' ');

    fprintf("Converted %s and saved to %s\n", infile, outfile);

end
