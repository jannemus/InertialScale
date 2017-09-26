%QT_MUL  Quaternion product
%
% Syntax:
%   q3 = qt_mul(q1,q2)
%
% Description:
%   Product of quaternions q3 = q1*q2
%
% In:
%   q1 - First quaternion as 4x1 vector
%        or N quaternions as 4xN matrix
%   q2 - Second quaternion as 4x1 vector
%        or N quaternions as 4xN matrix
%
% Out:
%   q3 - Product quaternion as 4x1 in form [s;v]
%        or N quaternions as 4xN matrix

% Copyright (C) 2004-2006 Simo Särkkä
%
% $Id: qt_mul.m,v 1.1 2013/12/26 23:26:14 simosark Exp $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

function q3 = qt_mul(q1,q2)

  s1 = q1(1,:);
  s2 = q2(1,:);
  v1 = q1(2:end,:);
  v2 = q2(2:end,:);  

  s3 = s1.*s2-sum(v1.*v2,1);
  v3 = v1;
  for i=1:size(v3,2)
    v3(:,i) = s1(i)*v2(:,i)+s2(i)*v1(:,i)+cross(v1(:,i),v2(:,i));
  end
  q3 = [s3;v3];
