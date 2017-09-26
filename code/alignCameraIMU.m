function [accVis,qtVis,accImu,t] = ...
    alignCameraIMU(accVis,qtVis,tVis,accImu,tImu,Rs,td)
%
% Align inertial and visual-data both temporarily and spatially.
%
% INPUT:    accVis  : Visual acceleration [unknown scale] (Nx3 matrix)
%           qtVis   : Visual orientations (Nx4 matrix)
%           tVis    : Visual timestamps in seconds (Nx1 vector)
%           accImu  : Inertial accelerations [m/s^2] (Mx3 matrix)
%           tImu    : Inertial timestamps in seconds (Mx1 vector)
%           Rs      : Rotation between the camera and IMU (3x3 matrix)
%           td      : Time offset between the camera and IMU (scalar)
%
% OUTPUT:   accVis  : Aligned visual acceleration (Kx3 matrix)
%           qtVis   : Aligned visual orientations (Kx4 matrix)
%           accImu  : Aligned inertial accelerations [m/s^2] (Kx3 matrix)
%           t       : Timestamps in seconds (Kx1 vector)
%

% Use only time period which all sensors have values
timeStop = min([tVis(end) tImu(end)]);
tVis = tVis(tVis <= timeStop);
tImu = tImu(tImu <= timeStop);

accVis = accVis(1:length(tVis),:);
qtVis = qtVis(1:length(tVis),:);
accImu = accImu(1:length(tImu),:);

% Upsample visual-data to match the sampling of the IMU
t = tImu;
accVis = interp1(tVis-td,accVis,t,'linear','extrap');
qtVis = interp1(tVis-td,qtVis,t,'linear','extrap'); % Consider using SLERP

% Spatial alignment
accImu = accImu*Rs;

end

