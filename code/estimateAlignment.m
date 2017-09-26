function [Rs,td,bg] = estimateAlignment(qtVis,tVis,angImu,tImu)
%
% Estimate temporal and spatial alignment between the camera and IMU.
% Gyroscope bias is also estimated in the process.
%
% INPUT:    qtVis   : Visual orientations (Nx4 matrix)
%           tVis    : Visual timestamps in seconds (Nx1 vector)
%           angImu  : Inertial angular velocities [rad/s] (Mx3 matrix)
%           tImu    : Inertial timestamps in seconds (Mx1 vector)
%
% OUTPUT:   Rs      : Rotation between the camera and IMU (3x3 matrix)
%           td      : Time offset between the camera and IMU (scalar)
%           bg      : Gyroscope bias [rad/s] (1x3 vector)
%

fprintf('%s', repmat('-', 1, 60));
fprintf('\nTemporal and spatial alignment\n');
tic;

% Use only time period which all sensors have values
timeStop = min([tVis(end) tImu(end)]);
tVis = tVis(tVis <= timeStop);
tImu = tImu(tImu <= timeStop);

qtVis = qtVis(1:length(tVis),:);
angImu = angImu(1:length(tImu),:);

% Upsample visual-data to match the sampling of the IMU
t = tImu;
dt = mean(diff(t));
qtVis = interp1(tVis,qtVis,t,'linear','extrap'); % Consider using SLERP

% Compute visual angular velocities
qtDiffs = diff(qtVis);
qtDiffs = [qtDiffs; qtDiffs(end,:)]';
angVis = -(2/dt)*qt_mul(qtDiffs, qt_inv(qtVis'));
angVis = angVis(2:4,:)';

% Smooth angular velocities
angVis(:,1) = smooth(angVis(:,1),15);
angVis(:,2) = smooth(angVis(:,2),15);
angVis(:,3) = smooth(angVis(:,3),15);
angImu(:,1) = smooth(angImu(:,1),15);
angImu(:,2) = smooth(angImu(:,2),15);
angImu(:,3) = smooth(angImu(:,3),15);

gRatio = (1 + sqrt(5)) / 2;
tolerance = 0.0001;

maxOffset = 0.5;
a = -maxOffset;
b = maxOffset;

c = b - (b - a) / gRatio;
d = a + (b - a) / gRatio;

iter = 0;

while abs(c - d) > tolerance
   
     % Evaluate function at f(c) and f(d)
    [Rsc,biasc,fc] = solveClosedForm(angVis,angImu,t,c);
    [Rsd,biasd,fd] = solveClosedForm(angVis,angImu,t,d);

    if fc < fd
        b = d;
        Rs = Rsc;
        bg = biasc;
    else
        a = c;
        Rs = Rsd;
        bg = biasd;
    end
    
    c = b - (b - a) / gRatio;
    d = a + (b - a) / gRatio;
    
    iter = iter + 1;
end

td = (b + a) / 2;

fprintf('Golden-section search (%.0f iterations)\n', iter);
fprintf('Finished in %.3f seconds\n', toc);


end



function [Rs,bias,f] = solveClosedForm(angVis,angImu,t,td)
%
% Finds the relative rotation between the camera and IMU when using the 
% provided time offset td. Gyroscope bias is estimated in the process.
%
% INPUT:    angVis  : Visual angular velocities [rad/s] (Mx3 matrix)
%           angImu  : Inertial angular velocities [rad/s] (Mx3 matrix)
%           t       : Timestamps in seconds
%           td      : Time offset in seconds
%
% OUTPUT:   Rs      : Rotation between the camera and IMU (3x3 matrix)
%           bias    : Gyroscope bias [rad/s] (1x3 vector)
%           f       : Function value (sum of squared differences)
%

% Adjust visual angular velocities based on current offset
angVis = interp1(t-td,angVis,t,'linear','extrap');
N = size(angVis,1);

% Compute mean vectors
meanImu = repmat(mean(angImu),N,1);
meanVis = repmat(mean(angVis),N,1);

% Compute centralized point sets
P = angImu - meanImu;
Q = angVis - meanVis;

% Singular value decomposition
[U,S,V] = svd(P'*Q);

% Ensure a right handed coordinate system and correct if necessary
C = eye(3);
if (det(V*U') < 0)
    C(3,3) = -1;
end

Rs = V*C*U';

% Find the translation, which is the gyroscope bias
bias = mean(angVis) - mean(angImu)*Rs;

% Residual
D = angVis - (angImu*Rs + repmat(bias,N,1));
f = sum(D(:).^2);

end

