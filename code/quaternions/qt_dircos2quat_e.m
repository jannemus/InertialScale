%QT_DIRCOS2QUAT_E Convert direction cosine matrix to quaternion
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
%   This code is compatible with Eigen package.

% Copyright (C) 2014 Simo S?rkk?
%
% $Id: qt_dircos2quat_e.m,v 1.1 2014/08/11 18:09:21 simosark Exp $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.


function q = qt_dircos2quat_e(C)

    q = zeros(4,1);

    t = trace(C);
    if (t > 0)
      t = sqrt(t + 1);
      q(1) = 0.5*t;
      t = 0.5/t;
      q(2) = (C(3,2) - C(2,3)) * t;
      q(3) = (C(1,3) - C(3,1)) * t;
      q(4) = (C(2,1) - C(1,2)) * t;
    else
      i = 1;
      if (C(2,2) > C(1,1))
        i = 2;
      end
      if (C(3,3) > C(i,i))
        i = 3;
      end
      j = rem(i,3) + 1;
      k = rem(j,3) + 1;

      t = sqrt(C(i,i)-C(j,j)-C(k,k) + 1);
      q(i+1) = 0.5 * t;
      t = 0.5 / t;
      q(1) = (C(k,j)-C(j,k))*t;
      q(j+1) = (C(j,i)+C(i,j))*t;
      q(k+1) = (C(k,i)+C(i,k))*t;
    end

