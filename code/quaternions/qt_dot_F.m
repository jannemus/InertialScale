%QTDOT  Matrix F in time derivative of quaternion
%
% Syntax:
%   F = qt_dot_F(omega)
%
% In:
%   omega - Angular velocity as 3x1 vector or list of
%           angular velocities as 3xN matrix
%
% Out:
%   F     - 4x4 matrix F(omega) or 4x4xN if N>1 see below
%
% Description:
%   Return matrix F time derivative of (unit) quaternion q having
%   angular velocity vector omega:
%
%    dq/dt = F(omega) q

% Copyright (C) 2004-2006 Simo Särkkä
%
% $Id: qt_dot_F.m,v 1.1 2013/12/26 23:26:13 simosark Exp $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

function F = qt_dot_F(omega)

  F = zeros(4,4,size(omega,2));
    
  for i=1:size(omega,2)
    wx = omega(1,i);
    wy = omega(2,i);
    wz = omega(3,i);

    F(:,:,i) = 0.5*[ 0  -wx -wy -wz;...
		     wx   0  wz -wy;...
		     wy -wz   0  wx;...
		     wz  wy -wx   0];
  end
