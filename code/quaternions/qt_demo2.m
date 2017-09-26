%
% Quaternion demo/test 2
%

%%
% Simulate the angular velocity data
%

dt = 0.01;
ww = zeros(3,300);
ww(1,1:100) = 0.5;
ww(3,101:end) = 1;

%%
% Test the differential equation
%
%   dq/dt = q * [0;omega]/2
%
E = eye(3);

q = [1;0;0;0];
for k=1:size(ww,2)
    q = q + dt * qt_mul(q,[0;ww(:,k)]/2)
    q = q / qt_norm(q);

    Ep = qt_rot(q,E);
    clf
    cols = 'rgb';
    lbls = 'xyz';
    for i=1:size(Ep,2)
        plot3([0;Ep(1,i)],[0;Ep(2,i)],[0;Ep(3,i)],[cols(i) '-']);        
        axis([-1 1 -1 1 -1 1]);
        camproj perspective;
        grid on;
        hold on;
        text(Ep(1,i),Ep(2,i),Ep(3,i),lbls(i));
    end
    
    
    pause(0.01)
end

%%
% Test the differential equation
%
%   dq/dt = [0;omega]/2 * q 
%
E = eye(3);

q = [1;0;0;0];
for k=1:size(ww,2)
    q = q + dt * qt_mul([0;ww(:,k)]/2,q)
    q = q / qt_norm(q);

    Ep = qt_rot(q,E);
    clf
    cols = 'rgb';
    lbls = 'xyz';
    for i=1:size(Ep,2)
        plot3([0;Ep(1,i)],[0;Ep(2,i)],[0;Ep(3,i)],[cols(i) '-']);        
        axis([-1 1 -1 1 -1 1]);
        camproj perspective;
        grid on;
        hold on;
        text(Ep(1,i),Ep(2,i),Ep(3,i),lbls(i));
    end
    
    
    pause(0.01)
end
