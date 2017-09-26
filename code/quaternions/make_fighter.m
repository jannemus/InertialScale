%MAKE_FIGHTER  Create fighter target for visualization
%
% Syntax:
%   target = make_fighter(scale)
%
% In:
%   scale - Scale parameter (optional, default 1)
%
% Out:
%   target - The target structure
%
% Description:
%   Creates fighter for visualization purposes.
%   Structure contains the following fields:
%
%     points: 3xN matrix of vertices
%     nvert:  1xM vector of vertices per each M polygons
%     colors: 3xM vector of RGB colors

% Copyright (C) 2004-2006 Simo Särkkä
%
% $Id: make_fighter.m,v 1.1 2013/12/26 23:26:12 simosark Exp $
%
% This software is distributed under the GNU General Public 
% Licence (version 2 or later); please refer to the file 
% Licence.txt, included with the software, for details.

function target = make_fighter(scale)

  if nargin < 1
    scale = [];
  end
  if isempty(scale)
    scale = 1;
  end

  points = [-1  1  0  0  0  0;...
	    -2 -2  2 -2 -2  1;...
	     0  0  0  0  1  0] * scale;
  nvert  = [3 3];
  colors = [1 0;
	    0 0;
	    0 1];
  target = struct('points',points,'nvert',nvert,'colors',colors);
  

