function [scale,gravity,bias] = ...
    estimateScale(A,b,scale0,gravity0,bias0,t)
% Estimation is performed in the frequency domain

fprintf('%s', repmat('-', 1, 60));
fprintf('\nFinal estimation in the frequency domain\n');
tic;

% Select valid range of frequencies [0Hz - 1.2Hz]
N = length(t);
fmax = 1.2;
fs = 1/mean(diff(t));
f = fs*(0:(N/2))/N;
freqRange = (f <= fmax);
fprintf('Upper limit for the frequencies = %.2f Hz\n',fmax);

% Optimize while enforcing gravity constraint: norm(g) = 9.82
options = optimoptions(@fmincon, 'Display', 'off');
gConst = @gravityConstraint;

x0 = [scale0; gravity0; bias0];
x = fmincon(@(x)minFunc(x, A, b, freqRange), ...
    x0, [],[],[],[],[],[],gConst,options);

scale = x(1);
gravity = x(2:4);
bias = x(5:7);

fprintf('Finished in %.3f seconds\n', toc);

end


function [c,ceq] = gravityConstraint(x)

c = [];
ceq = norm([x(2) x(3) x(4)])-9.80;

end


function f = minFunc(x, A, b, freqRange)

Av = A*x; % Visual accelerations
Ai = b;    % Inertial accelerations

Av = [Av(1:3:end) Av(2:3:end) Av(3:3:end)];
Ai = [Ai(1:3:end) Ai(2:3:end) Ai(3:3:end)];

Fv = abs(fft(Av));
Fi = abs(fft(Ai));

Fv = Fv(freqRange,:);
Fi = Fi(freqRange,:);

f = (Fv - Fi).^2;
f = sum(f(:));

end