%QT_SLERP  Spherical linear interpolation with quaternions
%
% Syntax:
%   q2 = qt_slerp(q0,q1,t)
%
% In:
%   q0 - Start quaternion as 4x1 vector
%   q1 - End quaternion as 4x1 vector
%    t - Time in range [0,1] or 1xM matrix of
%        times of interpolation.
%
% Out:
%   q2 - 1xM matrix of interpolated quaternions.
%
% Description:
%   Perform spherical linear interpolation (SLERP)
%   with quaternions. The interpolation is performed
%   such that with t=0 the interpolated quaternion is
%   at starting point and with t=1 at the end point.
%   The values between smoothly vary between the end points.

% Copyright (C) 2006 Simo Särkkä
%
% $Id: qt_slerp.m,v 1.1 2013/12/26 23:26:14 simosark Exp $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

function q2 = qt_slerp(q0,q1,t)
  p  = qt_mul(q1,qt_inv(q0));
  q2 = zeros(size(q1,1),length(t));
  for i=1:length(t)
    q2(:,i) = qt_mul(qt_pow(p,t(i)),q0);
  end

