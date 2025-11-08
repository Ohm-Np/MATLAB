% ==============================================================
%   Statistics and Adjustment Theory
%   Author: Om Prakash Bhandari & Sandesh Pokhrel
%   Date: 09.11.2025
% ==============================================================


% [B] Probability Density Function (PDF)

% (5) Check which of the following functions is a probability
% density function and explain why.

% pdf requirements:

% -- f(x) should be greater than or equal to 0
% -- integral of f(x) should equal to 1

% verify integrals for the mentioned three functions ....

% (a)
fa = @(x) (5/2).*x - x.^2;
Ia = integral(fa, 0, 1);

% (b)
fb = @(x) x - 2.*x.^2;
Ib = integral(fb, 0, 1);

% (c)
fc = @(x) 2./(x.^2);
Ic = integral(fc, 1, 2);

fprintf('Integral (a) = %.4f\n', Ia);
fprintf('Integral (b) = %.4f\n', Ib);
fprintf('Integral (c) = %.4f\n', Ic);

% Plotting all three functions to see why only function (c)
% is a probability density function

% -- define x-ranges
x1 = linspace(0,1,200); % for (a) & (b)
x2 = linspace(1,2,200); % for (c)

% -- compute function values
y1a = fa(x1);
y1b = fb(x1);
y2c = fc(x2);

% -- create figure
figure;
hold on; grid on;

% plot each function with labels
plot(x1, y1a, 'LineWidth', 2, 'Color', [0 0.45 0.74]); % blue
plot(x1, y1b, 'LineWidth', 2, 'Color', [0.85 0.33 0.10]); % orange
plot(x2, y2c, 'LineWidth', 2, 'Color', [0.47 0.67 0.19]); % green

% -- add details
xlabel('x', 'FontSize', 12);
ylabel('f(x)', 'FontSize', 12);
title('Comparison of Probability Density Functions', 'FontSize', 14);

% -- visualize the area under the curve
% Shade area for (a)
fill([x1 fliplr(x1)], [y1a zeros(size(y1a))], [0 0.45 0.74], ...
    'FaceAlpha', 0.2, 'EdgeColor', 'none');
% Shade area for (b)
fill([x1 fliplr(x1)], [y1b zeros(size(y1b))], [0.85 0.33 0.10], ...
    'FaceAlpha', 0.2, 'EdgeColor', 'none');
% Shade area for (c)
fill([x2 fliplr(x2)], [y2c zeros(size(y2c))], [0.47 0.67 0.19], ...
    'FaceAlpha', 0.2, 'EdgeColor', 'none');


legend({'(a) (5/2)x - x^2', '(b) x - 2x^2', '(c) 2/x^2'}, ...
    'Location', 'northeast');
yline(0, '--k'); % horizontal line at f(x)=0
hold off;



% --------------------------------------------------------------



% (6) Cumulative Distribution Function

% The Cumulative Distribution Function (CDF), of a real-valued random
% variable X, evaluated at x, is the probability function that X will
% take a value less than or equal to x. It is used to describe the
% probability distribution of random variables in a table.

clear; clc; close all;

% -- define pdf as anonymous function
f = @(x) (x>0 & x<1).*1;  % 1 for 0<x<1, else 0

% -- numeric cdf values at some points
x_test = [-0.5, 0, 0.25, 0.5, 0.75, 1, 1.5];
F_numeric = arrayfun(@(x) integral(f, -inf, x), x_test);

% -- numeric expectation via integral
E_numeric = integral(@(t) t.*f(t), -inf, inf);

fprintf('Numeric cdf at test points:\n');
disp(table(x_test', F_numeric', 'VariableNames', {'x', 'F(x)'} ));

% -- display numeric expectation result
fprintf('Numeric expectation E(X) = %.6f\n', E_numeric);

% --- Simulation check ---
N = 1e6;

% generates Uniform(0,1) samples
X = rand(N,1);           
E_sim = mean(X);

fprintf('Simulated mean (N=%d) = %.6f\n', N, E_sim);

% -- plot analytic CDF and empirical CDF --

x_plot = linspace(-0.5,1.5,400);
F_plot = arrayfun(@(x) integral(f, -inf, x), x_plot);

figure;
plot(x_plot, F_plot, 'LineWidth', 2); hold on;

% empirical CDF from simulation
ecdf(X);

xlabel('x'); ylabel('F(x)');
title('Analytic CDF and Empirical CDF');
legend('Analytic F(x)','Empirical CDF (simulation)','Location','southeast');
grid on;



% --------------------------------------------------------------


% (7) Computation of expectation values

clear; clc; close all;

mu = 120;
E_x = mu;

E_y1 = E_x - 15;
E_y2 = (4/3)*E_x - 27;

fprintf('E[y1] = %d\n', E_y1);
fprintf('E[y2] = %d\n', E_y2);



% ========================================================= %
