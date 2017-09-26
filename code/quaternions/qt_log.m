%QT_LOG  Logarithm of quaternion
%
% Syntax:
%   q2 = qt_log(q1)
%
% In:
%   q1 - Original quaternion as 4x1 vector
%        or N quaternions as 4xN matrix
%
% Out:
%   q2 - Logarithm quaternion as 4x1 vector
%        or N quaternions as 4xN matrix
%
% Description:
%   Calculate logarithm (w.r.t quaternion product) of
%   the quaternion q2 = log(q1).

% Copyright (C) 2006 Simo Särkkä
%
% $Id: qt_log.m,v 1.1 2013/12/26 23:26:13 simosark Exp $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

function q2 = qt_log(q1)

  s = q1(1,:);
  v = q1(2:end,:);
  m = sqrt(sum(v.*v,1));

  mq = qt_norm(q1);
  q2 = [log(mq); v .* repmat(acos(s./mq)./max(m,eps),size(v,1),1)];
