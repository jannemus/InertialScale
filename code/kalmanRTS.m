function acc = kalmanRTS(pos,t)

fprintf('%s', repmat('-', 1, 60));
fprintf('\nKalman filtering and smoothing\n');
tic;

% Assume that we have roughly uniform sampling
% to optimize computations, otherwise we would need to
% recompute A and Q in the loop which is slower.

dt = mean(diff(t)); 

F = [0 1 0;
     0 0 1;
     0 0 0];
R  = 0.1^2; % Should reflect the truth
L  = [0;0;1];
H  = [1 0 0];
m0 = [0;0;0];
P0 = eye(3)*1e4;

% Compute maximum likelihood estimate of qc on a grid
qc_list = 45:10:130; % List of potential values
lh_list = zeros(size(qc_list)); % Negative log-likelihoods

for j=1:length(qc_list)
    qc = qc_list(j);
    [A,Q] = lti_disc(F,L,qc,dt);
    lh = 0;
    for i=1:size(pos,2)
        Y = pos(:,i)';

        % Kalman filter
        m = m0;
        P = P0;
        kf_m = zeros(size(m,1),size(Y,2));
        kf_P = zeros(size(P,1),size(P,2),size(Y,2));
        for k=1:size(Y,2)
            m = A*m;
            P = A*P*A' + Q;

            nu = Y(:,k) - H*m;
            S = H*P*H' + R;
            K = P*H'/S;
            m = m + K*nu;
            P = P - K*S*K';

            lh = lh + 0.5*log(2*pi) + 0.5*log(det(S)) + 0.5*nu'/S*nu;
            
            kf_m(:,k) = m;
            kf_P(:,:,k) = P;
        end
    end
    
    lh_list(j) = lh;
end


[~,ind] = min(lh_list);
qc = qc_list(ind);
fprintf('Process noise was set to qc = %.2f\n', qc);

%%
% Kalman filter and smoother
%
pos_kfs = zeros(size(pos));
vel_kfs = zeros(size(pos));
acc_kfs = zeros(size(pos));

[A,Q] = lti_disc(F,L,qc,dt);
for i=1:size(pos,2)    
    Y = pos(:,i)';

    % Kalman filter
    m = m0;
    P = P0;
    kf_m = zeros(size(m,1),size(Y,2));
    kf_P = zeros(size(P,1),size(P,2),size(Y,2));
    for k=1:size(Y,2)
        m = A*m;
        P = A*P*A' + Q;
        
        S = H*P*H' + R;
        K = P*H'/S;
        m = m + K*(Y(:,k) - H*m);
        P = P - K*S*K';
        
        kf_m(:,k) = m;
        kf_P(:,:,k) = P;
        
    end
    
    % RTS smoother
    ms = m;
    Ps = P;
    rts_m = zeros(size(m,1),size(Y,2));
    rts_P = zeros(size(P,1),size(P,2),size(Y,2));
    rts_m(:,end) = ms;
    rts_P(:,:,end) = Ps;
    for k=size(kf_m,2)-1:-1:1
        mp = A*kf_m(:,k);
        Pp = A*kf_P(:,:,k)*A'+Q;    
        Ck = kf_P(:,:,k)*A'/Pp; 
        ms = kf_m(:,k) + Ck*(ms - mp);
        Ps = kf_P(:,:,k) + Ck*(Ps - Pp)*Ck';
        rts_m(:,k) = ms;
        rts_P(:,:,k) = Ps;
    end
    
    pos_kfs(:,i) = rts_m(1,:)';
    vel_kfs(:,i) = rts_m(2,:)';
    acc_kfs(:,i) = rts_m(3,:)';
end

acc = acc_kfs;
fprintf('Finished in %.3f seconds\n', toc);

end


function [A,Q] = lti_disc(F,L,Q,dt)

%LTI_DISC  Discretize LTI ODE with Gaussian Noise
%
% Syntax:
%   [A,Q] = lti_disc(F,L,Qc,dt)
%
% In:
%   F  - NxN Feedback matrix
%   L  - NxL Noise effect matrix        (optional, default identity)
%   Qc - LxL Diagonal Spectral Density  (optional, default zeros)
%   dt - Time Step                      (optional, default 1)
%
% Out:
%   A - Transition matrix
%   Q - Discrete Process Covariance
%
% Description:
%   Discretize LTI ODE with Gaussian Noise. The original
%   ODE model is in form
%
%     dx/dt = F x + L w,  w ~ N(0,Qc)
%
%   Result of discretization is the model
%
%     x[k] = A x[k-1] + q, q ~ N(0,Q)
%
%   Which can be used for integrating the model
%   exactly over time steps, which are multiples
%   of dt.

% History:
%   11.01.2003  Covariance propagation by matrix fractions
%   20.11.2002  The first official version.
%
% Copyright (C) 2002, 2003 Simo Särkkä
%
% $Id: lti_disc.m 111 2007-09-04 12:09:23Z ssarkka $
%
% This software is distributed under the GNU General Public 
% Licence (version 2 or later); please refer to the file 
% Licence.txt, included with the software, for details.

  %
  % Check number of arguments
  %
  if nargin < 1
    error('Too few arguments');
  end
  if nargin < 2
    L = [];
  end
  if nargin < 3
    Q = [];
  end
  if nargin < 4
    dt = [];
  end

  if isempty(L)
    L = eye(size(F,1));
  end
  if isempty(Q)
    Q = zeros(size(F,1),size(F,1));
  end
  if isempty(dt)
    dt = 1;
  end

  %
  % Closed form integration of transition matrix
  %
  A = expm(F*dt);

  %
  % Closed form integration of covariance
  % by matrix fraction decomposition
  %
  n   = size(F,1);
  Phi = [F L*Q*L'; zeros(n,n) -F'];
  AB  = expm(Phi*dt)*[zeros(n,n);eye(n)];
  Q   = AB(1:n,:)/AB((n+1):(2*n),:);
end

