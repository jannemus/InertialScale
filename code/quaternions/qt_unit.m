%QT_UNIT  Create unit quaternion
%
% Syntax:
%   q = qt_unit(u,angle)
%
% In:
%   u     - 3x1 vector representing axis of rotation or
%           N unit vectors as 3xN matrix
%   angle - Rotation angle in radians or N angles as
%           1xN matrix
%
% Out:
%   q - Rotation quaternion in form [s;v]
%       or N quaternions as 4xN matrix
%
% Description:
%   Create unit (rotation) quaternion, which rotates
%   angle radians around vector u.

% Copyright (C) 2004 Simo Särkkä
%
% $Id: qt_unit.m,v 1.1 2013/12/26 23:26:14 simosark Exp $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

function q = qt_unit(u,angle)

  u = u./norm(u);
  s = cos(angle/2);
  v = u.*repmat(sin(angle/2),3,1);
  q = [s;v];
  
