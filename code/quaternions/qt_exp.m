%QT_EXP  Exponential of quaternion
%
% Syntax:
%   q2 = qt_exp(q1)
%
% In:
%   q1 - Original quaternion as 4x1 vector
%        or N quaternions as 4xN matrix
%
% Out:
%   q2 - Exponential quaternion as 4x1 vector
%        or N quaternions as 4xN matrix
%
% Description:
%   Calculate exponential (w.r.t quaternion product) of
%   the quaternion q2 = exp(q1).

% Copyright (C) 2006 Simo Särkkä
%
% $Id: qt_exp.m,v 1.1 2013/12/26 23:26:13 simosark Exp $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

function q2 = qt_exp(q1)

  s = q1(1,:);
  v = q1(2:end,:);
  m = sqrt(sum(v.*v,1));

  
  q2 = [cos(m); v .* repmat(sin(m)./max(m,eps),size(v,1),1)];
  q2 = q2 .* repmat(exp(s),size(q2,1),1);
  
