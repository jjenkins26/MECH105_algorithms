function [I] = Simpson(x, y)
% Numerical evaluation of integral by Simpson's 1/3 Rule
% Inputs
%   x = the vector of equally spaced independent variable
%   y = the vector of function values with respect to x
% Outputs:
%   I = the numerical integral calculated

%% Start Function - Initial checks

%Check if each x-interval is the same size

    % Make a linearly spaced vector that is compared to the original.
    checkVec = linspace(x(1), x(end), length(x));

    if ~(isequal(checkVec,x))
        error("Not all points are equally spaced.")
    end

%Check if both input vectors are the same length.
    
    if length(x) ~= length(y)
        error("Input vectors must be the same length.")
    end

%% End initial checks - Start function

% Determine if the number of INTERVALS is odd or even.
    
    if floor(length(x)/2) == length(x)/2 
        % odd number of intervals.
        odd = 1;
    else  % even number of intervals.
        odd = 0;
    end

if odd == 0 % if there are an even number of intervals

    %Sum even and odd vector components individually - ignore first and last
    oddSums = sum(y(3:2:end-1));  % sum of odd function values
    evenSums = sum(y(2:2:end-1));  % sum of even function values

%Compute the integral
h = (x(end - x(1))) / (length(x) - 1); %The width of each interval
I = (y(1) + 4 * evenSums + 2 * oddSums + y(end)) * h / 3;

elseif odd == 1 %If there are an odd number of intervals

    warning('N is odd, so this will use the trap rule for the last interval')

    %Sum even and odd vector components individually - ignore first and
    %last - 2

    %Trap computation
    trap = (x(end) - x(end - 1)) * (y(end) + y(end - 1)) / 2;
    I = trap;

    if length(x) > 2

        %Compute the integral
          oddSums = sum(y(3:2:end-1));  % sum of odd function values
          evenSums = sum(y(2:2:end-2));  % sum of even function values

        h = (x(end) - x(1)) / (length(x) - 1); %The width of each interval
        I = (y(1) + 4 * evenSums + 2 * oddSums + y(end)) * (h / 3) + trap;
    end

end


