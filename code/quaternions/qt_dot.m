%QTDOT  Time derivative of quaternion
%
% Syntax:
%   [dq_dt,F,Q] = qt_dot(q,omega)
%
% In:
%   q     - Quaternion as 4x1 vector or list of
%           quaternions as 4xN matrix
%   omega - Angular velocity as 3x1 vector or list of
%           angular velocities as 3xN matrix
%   use_sym - Return symbolic variables (default 0)
%
% Out:
%   dq_dt - Time derivative(s) as 4xN vector
%   F     - 4x4 matrix F(omega) or 4x4xN if N>1 see below
%   Q     - 4x3 matrix Q(q) or 4x3xN if N>1, see below
%
% Description:
%   Return time derivative of (unit) quaternion q having
%   angular velocity vector omega:
%
%         q = [q1 q2 q3 q4]'
%     omega = [wx wy wz]'
%
%    dq1/dt = -(1/2) (q2 wx + q3 wy + q4 wz)
%    dq2/dt =  (1/2) (q1 wx - q4 wy + q3 wz)
%    dq3/dt =  (1/2) (q4 wx + q1 wy - q2 wz)
%    dq4/dt = -(1/2) (q3 wx - q2 wy - q1 wz)
%
%  which can be written in alternative forms
%
%    dq/dt = F(omega) q
%    dq/dt = Q(q) omega

% Copyright (C) 2004-2013 Simo Särkkä
%
% $Id: qt_dot.m,v 1.1 2013/12/26 23:26:13 simosark Exp $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

function [dq_dt,F,Q] = qt_dot(q,omega,use_sym)

  if nargin < 3
      use_sym = [];
  end
  if isempty(use_sym)
      use_sym = 0;
  end

  if (size(q,2) > 1) & (size(omega,2) == 1)
    omega = repmat(omega,1,size(q,2));
  elseif size(q,2) ~= size(omega,2)
    error('Sizes of q and omega don''t match');
  end

  dq_dt = [-0.5*(q(2,:).*omega(1,:)+q(3,:).*omega(2,:)+q(4,:).*omega(3,:));...
	    0.5*(q(1,:).*omega(1,:)-q(4,:).*omega(2,:)+q(3,:).*omega(3,:));...
	    0.5*(q(4,:).*omega(1,:)+q(1,:).*omega(2,:)-q(2,:).*omega(3,:));...
	   -0.5*(q(3,:).*omega(1,:)-q(2,:).*omega(2,:)-q(1,:).*omega(3,:))];

  if nargout > 1
    F = zeros(4,4,size(q,2));
    if use_sym
      F = sym(F);
    end
    
    Q = zeros(4,3,size(q,2));
    if use_sym
      Q = sym(Q);
    end
    
    for i=1:size(q,2)
      q1 = q(1,i);
      q2 = q(2,i);
      q3 = q(3,i);
      q4 = q(4,i);
      wx = omega(1,i);
      wy = omega(2,i);
      wz = omega(3,i);

      F(:,:,i) = 0.5*[ 0  -wx -wy -wz;...
		       wx   0  wz -wy;...
		       wy -wz   0  wx;...
		       wz  wy -wx   0];
      Q(:,:,i) = 0.5*[-q2 -q3 -q4;...
 		       q1 -q4  q3;...
		       q4  q1 -q2;...
		      -q3  q2  q1];
    end
  end
