close all

figure;
hold on;

cc = hsv(12);

%[ predictions_strong, invest, profit, property, bet_case_strong ] = simpleSim( 100, observations, expert_predictions, odds, @strongAggr, 1, 'exp_fix', 0);
%plot(property, '-', 'color', cc(1, :));

pp= [];
max_pp = zeros(size(observations));
bet_case_one = zeros(size(observations));

ob_dim = 3;
for i = 1:10
    [ predictions, invest, profit, property, betCase ] = simpleSim( 100, observations, expert_predictions, odds, @followOne, expert_predictions(:, (i-1)*ob_dim+1:i*ob_dim), 'exp_fix', 0);
    plot(property, '--', 'color', cc(i+1, :));

end

hold off