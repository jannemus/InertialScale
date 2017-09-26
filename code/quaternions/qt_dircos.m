%QT_DIRCOS  Convert quaternion into direction cosine matrix
%
% Syntax:
%   C = qt_dircos(q)
%
% In:
%   q - Unit quaternion(s) as 4xN matrix
%   use_sym - Return symbolic variables (default 0)
%
% Out:
%   C - Cosine matrices as 3x3xN matrix 
%
% Description:
%   Convert quaternion into direction cosine matrix
%   such that rotation defined by the quaternion
%   can be expressed as
%
%     r' = C r

% Copyright (C) 2006-2013 Simo Särkkä
%
% $Id: qt_dircos.m,v 1.1 2013/12/26 23:26:12 simosark Exp $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.

function C = qt_dircos(q,use_sym)

  if nargin < 2
      use_sym = [];
  end
  if isempty(use_sym)
      use_sym = 0;
  end
  
  C = zeros(3,3,size(q,2));
  if use_sym
      C = sym(C);
  end
  
  for i=1:size(q,2)
    C(1,1,i) = q(1,i)^2 + q(2,i)^2-q(3,i)^2-q(4,i)^2;
    C(1,2,i) = 2 * (q(2,i) * q(3,i) - q(1,i) * q(4,i));
    C(1,3,i) = 2 * (q(2,i) * q(4,i) + q(1,i) * q(3,i));
    C(2,1,i) = 2 * (q(2,i) * q(3,i) + q(1,i) * q(4,i));
    C(2,2,i) = q(1,i)^2 - q(2,i)^2 + q(3,i)^2 - q(4,i)^2;
    C(2,3,i) = 2 * (q(3,i) * q(4,i) - q(1,i) * q(2,i));
    C(3,1,i) = 2 * (q(2,i) * q(4,i) - q(1,i) * q(3,i));
    C(3,2,i) = 2 * (q(3,i) * q(4,i) + q(1,i) * q(2,i));
    C(3,3,i) = q(1,i)^2 - q(2,i)^2 - q(3,i)^2 + q(4,i)^2;
  end
  
  
  
