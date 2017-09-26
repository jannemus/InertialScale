%QT_POW  Power of quaternion
%
% Syntax:
%   q2 = qt_pow(q1,p)
%
% In:
%   q1 - Original quaternion as 4x1 vector
%        or N quaternions as 4xN matrix
%    p - Exponent quaternion as 4x1 vector
%        or N quaternions as 4xN matrix.
%        Can be scalar or N scalars as 1xN matrix.
%
% Out:
%   q2 - Logarithm quaternion as 4x1 vector
%        or N quaternions as 4xN matrix
%
% Description:
%   Calculate q1 raised to power q, that is q2 = q1^p.

% Copyright (C) 2006 Simo Särkkä
%
% $Id: qt_pow.m,v 1.1 2013/12/26 23:26:14 simosark Exp $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

function q2 = qt_pow(q1,p)
  if size(p,1) == 1
    q2 = qt_exp(qt_log(q1).*repmat(p,size(q1,1),1));
  else
    q2 = qt_exp(qt_mul(qt_log(q1),p));
  end
  
