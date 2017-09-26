function [posVis, qtVis, timeVis, scaleGT] = readVisual(dataset)
%
% Read camera poses and timestamps from the input files. 
% See the README.txt for more information about the input format.
%
% INPUT:    dataset : Name of the dataset (string)
%
% OUTPUT:   posVis  : Visual positions (Nx3 matrix)
%           qtVis   : Visual orientations (Nx4 matrix)
%           timeVis : Timestamps in seconds (Nx1 vector)
%           scaleGT : Ground truth scale if defined (scalar)
%

fprintf('%s', repmat('-', 1, 60));
fprintf('\nReading visual data (%s)\n', dataset);

basePath = sprintf('../data/%s/',dataset);

% Read camera poses
if exist([basePath 'poses.txt'],'file')
    fileID = fopen([basePath 'poses.txt']);
    vis = textscan(fileID,'%f %f %f %f %f %f %f %f');
    fclose(fileID);
    timeVis = vis{1};
    timeVis = 1e-9*(timeVis - timeVis(1));
    posVis = [vis{2} vis{3} vis{4}];
    qtVis = [vis{5} vis{6} vis{7} vis{8}];
else
   error('poses.txt not found! Check inputs.'); 
end

% Read ground truth scale if defined
if exist([basePath 'groundtruth.txt'],'file')
    fileID = fopen([basePath 'groundtruth.txt']);
    gt = textscan(fileID,'%f');
    fclose(fileID);
    scaleGT = gt{1};
    fprintf('Ground truth scale was defined = %.4f\n', scaleGT);
else
    scaleGT = 0;
end

dtVis = mean(diff(timeVis));
fprintf('Frame rate of the camera = %.2f fps\n', 1/(dtVis));

end

