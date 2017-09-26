%QT_NORM2  Squared norm of quaternion
%
% Syntax:
%   s = qt_norm2(q)
%
% In:
%   q - Quaternion as 4x1 vector
%       or N quaternions as 4xN matrix
%
% Out:
%   s - Squared norm as scalar or squared norms
%       of N quaternions as 1xN matrix
%
% Description:
%   Calculate squared norm of quaternion, i.e., |q|^2

% Copyright (C) 2004-2006 Simo Särkkä
%
% $Id: qt_norm2.m,v 1.1 2013/12/26 23:26:14 simosark Exp $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

function s = qt_norm2(q)

  if size(q,1) ~= 4
    error(sprintf('Number of rows in q is not 4 (q was %dx%d)',...
		  size(q,1),size(q,2)));
  end

  s = sum(q.*q,1);

