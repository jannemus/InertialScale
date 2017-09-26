%QT_INV  Inverse of quaternion
%
% Syntax:
%   q2 = qt_inv(q1)
%
% In:
%   q1 - Original quaternion as 4x1 vector
%        or N quaternions as 4xN matrix
%
% Out:
%   q2 - Invert quaternion as 4x1 vector
%        or N quaternions as 4xN matrix
%
% Description:
%   Calculate multiplicative inverse of
%   quaternion q2 = q1^(-1).

% Copyright (C) 2004-2006 Simo Särkkä
%
% $Id: qt_inv.m,v 1.1 2013/12/26 23:26:13 simosark Exp $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

function q2 = qt_inv(q1)
  q2 = qt_conj(q1)./repmat(qt_norm2(q1),4,1);
  
