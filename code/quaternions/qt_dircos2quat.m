%QT_DIRCOS2QUAT Convert direction cosine matrix to quaternion
%
% Syntax:
%   q = qt_dircos2quat(C)
%
% In:
%   C - Direction cosine matrix
%
% Out:
%   q - Unit quaternion
%
% Description:
%   Convert direction cosine matrix C to quaternion q.

% Copyright (C) 2014 Simo S?rkk?
%
% $Id: qt_dircos2quat.m,v 1.1 2014/07/03 06:26:41 simosark Exp $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.


function q = qt_dircos2quat(C)

    q = zeros(4,1);
    q(1) = sqrt(1 + C(1,1) + C(2,2) + C(3,3))/2;
    
    if abs(q(1)) > 0.01
        q(2) = (C(3,2) - C(2,3)) / q(1) / 4;
        q(3) = (C(1,3) - C(3,1)) / q(1) / 4;
        q(4) = (C(2,1) - C(1,2)) / q(1) / 4;
    else
        q(2) = sqrt(1 + C(1,1) - C(2,2) - C(3,3))/2;
        q(3) = (C(1,2) + C(2,1)) / q(2) / 4;
        q(4) = (C(1,3) + C(3,1)) / q(2) / 4;
        q(1) = (C(3,2) - C(2,3)) / q(2) / 4;
    end
    
