%QT_AXIS  Get axis and angle from unit quaternion
%
% Syntax:
%   [u,a] = qt_axis(q)
%
% In:
%   q - Unit quaternions as 4xN matrix
%
% Out:
%   u - Axes as 4xN matrix
%   a - Angles as 4xN matrix
%
% Description:
%   Get axis and angle of unit quaternion rotation.

% Copyright (C) 2004-2006 Simo Särkkä
%
% $Id: qt_axis.m,v 1.1 2013/12/26 23:26:12 simosark Exp $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

function [u,a] = qt_axis(q)

  u  = q(2:end,:);
  nu = sqrt(sum(u.*u,1));
  ind1 = find(nu < eps);
  ind2 = find(nu >= eps);
  u(:,ind1) = repmat([1;0;0],1,length(ind1));
  u(:,ind2) = u(:,ind2) ./ repmat(nu(ind2),3,1);
  a = 2*acos(q(1,:));
