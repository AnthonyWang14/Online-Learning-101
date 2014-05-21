ob_dim = 3;

pp= [];
figure;
for i = 1:10
    [ predictions, invest, profit, property, betCase ] = baselineFollowOne( 100, observations, expert_predictions(:, (i-1)*ob_dim+1:i*ob_dim), odds);
    pp = [pp, property];
end
hold on
plot(pp, '--');

[ predictions, invest, profit, property, betCases ] = simpleSim( 100, observations, expert_predictions, odds, @strongAggr, 3);

plot(property)

[ predictions, invest, profit, property, betCase ] = baselineFollowOne( 100, observations, calib_predictions, odds);

plot(property, '-.')

hold off