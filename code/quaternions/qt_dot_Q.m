%QTDOT  Matrix Q in time derivative of quaternion
%
% Syntax:
%   Q = qt_dot_Q(q)
%
% In:
%   q     - Quaternion as 4x1 vector or list of
%           quaternions as 4xN matrix
%   use_sym - Return symbolic variables (default 0)
%
% Out:
%   Q     - 4x3 matrix Q(q) or 4x3xN if N>1, see below
%
% Description:
%   Return matrix Q in time derivative of (unit) quaternion
%   q having angular velocity vector omega:
%
%    dq/dt = Q(q) omega

% Copyright (C) 2004-2013 Simo Särkkä
%
% $Id: qt_dot_Q.m,v 1.1 2013/12/26 23:26:13 simosark Exp $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

function Q = qt_dot_Q(q,omega,use_sym)

  if nargin < 3
      use_sym = [];
  end
  if isempty(use_sym)
      use_sym = 0;
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
    Q(:,:,i) = 0.5*[-q2 -q3 -q4;...
		    q1 -q4  q3;...
		    q4  q1 -q2;...
		    -q3  q2  q1];
  end

