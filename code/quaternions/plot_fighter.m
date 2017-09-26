%PLOT_FIGHTER  Plot fighter target
%
% Syntax:
%   plot_plane(target,x,q)
%
% In:
%   target - Target structure
%   x      - Position as 3x1 vector (optional, default [0;0;0])
%   q      - Orientation as 4x1 unit quaternion
%            (optional, default [1;0;0;0])
%
% Out:
%   -
%
% Description:
%   Plot the fighter in given position and orientation

% Copyright (C) 2004-2006 Simo Särkkä
%
% $Id: plot_fighter.m,v 1.1 2013/12/26 23:26:12 simosark Exp $
%
% This software is distributed under the GNU General Public 
% Licence (version 2 or later); please refer to the file 
% Licence.txt, included with the software, for details.

function plot_fighter(target,x,q)

  if nargin<2
    x = [];
  end
  if nargin<3
    q = [];
  end
  if isempty(x)
    x = [0;0;0];
  end
  if isempty(q)
    q = [1;0;0;0];
  end

  points = target.points;
  nvert  = target.nvert;
  colors = target.colors;

  i0 = 1;
  if ishold
    holding = 1;
  else
    holding = 0;
  end

  points = qt_rot(q,points);
  points = points + repmat(x,1,size(points,2));

  for i=1:length(nvert)
    i1 = i0+nvert(i)-1;
    p = points(:,i0:i1);
    fill3(p(1,:),p(2,:),p(3,:),colors(:,i)');
    hold on;
    i0 = i1;
  end

  if ~holding
    hold off;
  end

