close all
clear all

load('data.mat');


figure;
hold on;

cc = hsv(12);
    
[ predictions, invest, profit, property, bet_case_leader ] = simpleSim( 100, observations, expert_predictions, odds, @followLeader, {1, @l2th}, 'prob_fix', 0.8);
plot(property, '-', 'color', cc(1, :));


ob_dim = 3;
for i = 1:10
    [ predictions, invest, profit, property, betCase ] = simpleSim( 100, observations, expert_predictions, odds, @followOne, expert_predictions(:, (i-1)*ob_dim+1:i*ob_dim), 'prob_fix', 0.8);
    plot(property, '--', 'color', cc(i+1, :));
end

hold off