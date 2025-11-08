% ==============================================================
%   Statistics and Adjustment Theory
%   Authors: Om Prakash Bhandari & Sandesh Pokhrel
%   Date: 09.11.2025
% ==============================================================


% [A] Rolling two dices

% In a random experiment, two dice are rolled. The result of the
% experiment, i.e., the random variable, corresponds to the sum of the
% numbers on the dice.

% (1) What are the elementary events of this experiment?

d = 1:6;
[d1, d2] = meshgrid(d, d);
elementary_events = [d1(:), d2(:)];

disp('Elementary events: (first roll, second roll):');
disp(elementary_events);

% Total number of outcomes

totalOutcomes = size(elementary_events, 1);
disp(['Total number of outcomes: ', num2str(totalOutcomes)]);

% ---------------------------------------------------------------

% (2) Simulate in MATLAB that you performed the experiment 
% 10 times. Plot the absolute and relative frequencies of 
% the elementary events. Do the same for 1000 realizations
% of the experiment and integrate the result in the plot.
% Hint: use the function randi.

clear; clc; close all;

% simulate 10 and 1000 experiments using 'randi'

N1 = 10; % number of rolls for first experiment
N2 = 1000; % number of rolls for second experiment

% -- simulate dice rolls for 10 experiments --

d1_10 = randi([1,6], N1, 1);
d2_10 = randi([1,6], N1, 1);
sum10 = d1_10 + d2_10;

% -- simulate dice rolls for 1000 experiments --

d1_1000 = randi([1,6], N2, 1);
d2_1000 = randi([1,6], N2, 1);
sum1000 = d1_1000 + d2_1000;

% -- define possible sums --

sums = 2:12; 

% -- compute absolute frequencies --
absFreq10 = histcounts(sum10, 1.5:12.5);
absFreq1000 = histcounts(sum1000, 1.5:12.5);

% -- compute relative frequencies --
relFreq10 = absFreq10 / N1;
relFreq1000 = absFreq1000 / N2;

% -- plot absolute frequencies for both experiments --

figure;
bar(sums, [absFreq10' absFreq1000'], 'grouped');
xlabel('Sum of Two Dice');
ylabel('Absolute frequency');
title('Absolute frequencies for 10 and 1000 simulations');
legend('10 Rolls', '1000 Rolls');
grid on;

% -- plot relative frequencies for both experiments --

figure;
bar(sums, [relFreq10' relFreq1000'], 'grouped');
xlabel('Sum of Two Dice');
ylabel('Relative Frequency');
title('Relative frequencies for 10 and 1000 simulations');
legend('10 Rolls', '1000 Rolls');
grid on;

% ---------------------------------------------------------------

% (3) Give the probability for the elementary event.

clear; clc; close all;

% number of experiments (larger the number, greate the accuracy) 
N = 100000; 

d1 = randi(6, N, 1);
d2 = randi(6, N, 1);

% -- combine results as pairs --
outcomes = [d1 d2];

% -- compute empirical probabilities --
counts = zeros(6,6);
for i = 1:N
    counts(d1(i), d2(i)) = counts(d1(i), d2(i)) + 1;
end

% -- divide by total to get probabilities --
probabilities = counts / N;

% -- display results --
disp('Empirical probability matrix for elementary events (i, j):');
disp(probabilities);

fprintf('Sum of all prbabilities = %.4f\n', ...
    sum(probabilities , "all"));

% --------------------------------------------------------------------

% (4) Give the probability for any event which is a subset of 
% the set of the elementary events.

% example event: 7

clear; clc; close all;

% number of simulated rools 
N = 100000;

d1 = randi(6, N, 1);
d2 = randi(6, N, 1);
sums = d1 + d2;

% sum of dice 7
eventSum = (sums == 7); 

% estimate empirical probability
empiricalProbability = sum(eventSum) / N;
fprintf('Empirical probability of rolling a sum of 7: %.4f\n', ...
    empiricalProbability);


% =============================================================== % 
