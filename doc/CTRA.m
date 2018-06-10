% MATLAB implementation of the Constant Turn Rate and Acceleration Vehicle Model
% 
% Used primarly to compute the System Model Jacobian and Limits for Omega -> 0
% using MATLAB Symbolic Toolbox

% state vector
syms x y theta

% inputs
syms a omega v t

% System model matrix
f = [
    x + ( 1 / omega^2 ) * (  (v*omega+a*omega*t)*sin(theta+omega*t) + a*( cos(theta+omega*t)-cos(theta) ) - v*omega*sin(theta) );
    y + ( 1 / omega^2 ) * ( -(v*omega+a*omega*t)*cos(theta+omega*t) + a*( sin(theta+omega*t)-sin(theta) ) + v*omega*cos(theta) );
    theta + t * omega;
];

% Compute Jacobian w.r.t state vector
F = jacobian(f, [x,y,theta]);

% simplify computed jacobian
Fs = simplify(F);

% Compute Limits for omega -> 0
fLimit = limit(f, omega, 0);
FLimit = limit(F, omega, 0);

% code is manually transfered to C++
