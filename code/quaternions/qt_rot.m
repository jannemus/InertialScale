%QT_ROT  Rotate vector by quaternion
%
% Syntax:
%   p = qt_rot(q,p)
%
% In:
%   q - Unit quaternion(s) as 4xN matrix
%   p - Point or points as 3xN matrix or
%       as 4xN where first row contants zeros only
%
% Out:
%   p - Rotated point(s) as 3xN or 4xN matrix 
%       depending on the size of input p
%
% Description:
%   Rotate point p according to unit quaternion q.

% Copyright (C) 2004-2006 Simo Särkkä
%
% $Id: qt_rot.m,v 1.1 2013/12/26 23:26:14 simosark Exp $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

function p = qt_rot(q,p)

  if (size(p,2) > 1) & (size(q,2) == 1)
    q = repmat(q,1,size(p,2));
  elseif (size(p,2) == 1) & (size(q,2) > 1)
    p = repmat(p,1,size(q,2));
  elseif (size(p,2) ~= size(q,2))
    error('Sizes of p and q don''t match');
  end

  if size(p,1) == 3
    p = [zeros(1,size(p,2));p];
    p = qt_mul(qt_mul(q,p),qt_conj(q));
    p = p(2:end,:);
  else
    p = qt_mul(qt_mul(q,p),qt_conj(q));
  end

