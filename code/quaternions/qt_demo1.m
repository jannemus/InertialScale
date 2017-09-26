%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Demonstration of quaternion dynamics
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Copyright (C) 2004-2006 Simo Särkkä
%
% $Id: qt_demo1.m,v 1.1 2013/12/26 23:26:12 simosark Exp $
%
% This software is distributed under the GNU General Public
% Licence (version 2 or later); please refer to the file
% Licence.txt, included with the software, for details.


  %
  % Make a plane
  %
  target = make_fighter;
  axis vis3d;
  
  %
  % Simulate
  %
  dt = 0.05;
  omega0 = [0;1;pi];  
  domega = [1;0;-1];
  q0 = qt_unit([0;0;1],0);

  Omega = [];
  Quat  = [];
  omega = omega0;
  q = q0;
  T = [];
  for t=dt:dt:5
%    omega = omega + domega*dt*exp(-t);
    omega = omega + domega*dt*sin(t);
    q = q + dt * qt_dot(q,omega);
    q = q ./ qt_norm(q);

    M = qt_rot(q,eye(3));

    clf;
    plot3([0;omega(1)],[0;omega(2)],[0;omega(3)],'--',...
	  [0;M(1,1)],[0;M(2,1)],[0;M(3,1)],'-',...
	  [0;M(1,2)],[0;M(2,2)],[0;M(3,2)],'-',...
	  [0;M(1,3)],[0;M(2,3)],[0;M(3,3)],'-');
    hold on;

    plot_fighter(target,[],q);
    alpha(0.5);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    grid on;
    axis([-2 2 -2 2 -2 2]);
    drawnow;
    hold off;
    pause(dt);

    Omega = [Omega omega];
    Quat  = [Quat q];
    T = [T t];
  end

