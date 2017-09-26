%QT_NORM  Norm of quaternion
%
% Syntax:
%   s = qt_norm2(q)
%
% In:
%   q - Quaternion as 4x1 vector
%       or N quaternions as 4xN matrix
%
% Out:
%   s - Norm as scalar or norms
%       of N quaternions as 1xN matrix
%
% Description:
%   Calculate norm of quaternion, i.e., |q|

% Copyright (C) 2004-2006 Simo Särkkä
%
% $Id: qt_norm.m,v 1.1 2013/12/26 23:26:14 simosark Exp $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

function s = qt_norm(q)
  s = sqrt(qt_norm2(q));

