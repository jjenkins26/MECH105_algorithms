function [fX, fY, slope, intercept, Rsquared] = linearRegression(x,y)
%linearRegression Computes the linear regression of a data set
%   Compute the linear regression based on inputs:
%     1. x: x-values for our data set
%     2. y: y-values for our data set
%
%   Outputs:
%     1. fX: x-values with outliers removed
%     2. fY: y-values with outliers removed
%     3. slope: slope from the linear regression y=mx+b
%     4. intercept: intercept from the linear regression y=mx+b
%     5. Rsquared: R^2, a.k.a. coefficient of determination
%----------------------------------------------

%% Outliers - disregard except for testing.
%x = [3.1, 1.2, 7.8, 2.4, 6.5, 4.7, 8.2, 9.3, 5.6, 2.9];
%y = [4.3, 3.8, 5.6, 3.9, 6.1, 5.3, 10.5, 12.1, 8.2, 4.7];
%y(2) = 82.3; % introduce an outlier
%y(7) = 2204.2; % introduce another outlier

%%
%Throws error if x and y are not the same size:
    if size(x) ~= size(y) 
        error('Arrays x and y must be the same size, bro')
    end
%%
%Sort the dataset inputted from smallest to largest & establish length variable n.
    n = length(x);
%%
%Sort with respect to Y
    [sortedYY, sortOrder] = sort(y);
    sortedYX = x(sortOrder);
    %Remap variables following sort.
    y = sortedYY;
    x = sortedYX;
%%

%Compute 1st and 3rd quartiles locations for the dataset & interquartile range
    q1ySorted = y(floor(n/4)+1);
    q3ySorted = y(floor(3*n/4)+1);
    IQR = q3ySorted - q1ySorted;
%%
%Removes outliers
    outliers = y < q1ySorted - 1.5 * (IQR) | y > q3ySorted + 1.5 * (IQR);

    x(outliers) = [];
    y(outliers) = [];
%%
% Calculate Best Fit Line and update 'n' to the new length of the array:
    n = length(x);
    sxy = sum(x.*y);
    sx = sum(x);
    sy = sum(y);
    sx2 = sum(x.^2);
    a1 = ((n*sxy - sx * sy)/(n*sx2-sx^2));
    a0 = mean(y) - a1*mean(x);
%%
% rSqrd
    Sr = sum((y - a0 - a1*x).^2);
    St = sum((y - mean(y)).^2);
    rSqrd = (St - Sr)/St;
%%
%Function outputs
    fX = x;
    fY = y;
    slope = a1;
    intercept = a0;
    Rsquared = rSqrd;

%% Create scatter plot of data points --------------------------
scatter(x, y, 'b','filled','o');
hold on;

% Plot line of best fit using a0 and a1
xrange = linspace(min(x), max(x), 100);
yfit = a0 + a1 * xrange;
plot(xrange, yfit, 'r');

% Add labels and title
xlabel('x');
ylabel('y');
title('Linear Regression of Inputted Data'); %-----------------------------------
end
