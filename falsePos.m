function [root, fx, ea, iter] = falsePos(func, xl, xu, es, maxit, varargin)
%falsePosition finds the root of a function using false position method
format long
%Define constraints
iter = 0;
ea = 100;
xr = (xl + xu) / 2;

%Do the nargin stuff -- testing the number of inputs
    if nargin < 3
        fprintf('Not enough inputs');
        error
    elseif nargin == 3
            fprintf('Default es = 0.0001')
            es = 0.0001;
            maxit = 200;
    elseif nargin == 4
            fprintf('Default iterations = 200')
            maxit = 200;
    end

% Plot function to visualize the root.
fplot(@(x) func(x),[xl, xu], 'LineWidth',1.5);
hold on
fplot(@(x) 0, [xl,xu])
grid on

%Run program until root is found or iterations max out.
while iter < maxit && ea > es

    %Before xr changes, set xr_old = xr
    xrOld = xr;

    % False position formula -- outputs guess at root
    xr = xu - func(xu) * (xl - xu) / (func(xl) - func(xu));
    % Determine which interval contains the root based on a sign change.
    if func(xr) * func(xl) < 0 % If the sign change is between xr and xl
        xl = xr;
    elseif func(xr) * func(xu) < 0 % if the sign change is between xu and xr
        xu = xr;
    end
    % Calculate ea -- approximate error as a %
    ea = abs((xr - xrOld)/xr) * 100;

    %Increase the iteration by 1
    iter = iter + 1;
end
root = xr;
fx = func(root);
end