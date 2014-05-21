close all
clear all

load('data.mat');

figure;

threshE = 0.02;
threshP = 0.82;


cc = hsv(2);

subplot(2,2,1)
hold on;


[ predictions, invest, profit, property, bet_case_avg ] = simpleSim( 100, observations, expert_predictions, odds, @weightedAvg, {1, @l2sq}, 'exp_fix', threshE);
plot(property, '-', 'color', cc(1, :), 'LineWidth', 1.5);

[ predictions, invest, profit, property, bet_case_avg2 ] = simpleSim( 100, observations, expert_predictions, odds, @weightedAvg, {1, @l2sq}, 'prob_fix', threshP);

plot(property, '-', 'color', cc(2, :), 'LineWidth', 1.5);

ylim([50 200])

legend('expectation', 'probability', 'location', 'Northwest');

title(['WAA & Brier Loss']);

hold off


subplot(2,2,2)

hold on

load('calib_2_3.mat');

[ predictions, invest, profit, property, bet_case_calib ] = simpleSim( 100, observations, expert_predictions, odds, @followOne, calib_predictions, 'exp_fix', threshE);
plot(property, '-', 'color', cc(1, :), 'LineWidth', 1.5);

[ predictions, invest, profit, property, bet_case_calib2 ] = simpleSim( 100, observations, expert_predictions, odds, @followOne, calib_predictions, 'prob_fix', threshP);
plot(property, '-', 'color', cc(2, :), 'LineWidth', 1.5);

ylim([50 200])

legend('expectation', 'probability', 'location', 'Northwest');

title(['WAA & Calibration Loss & epsilon: 0.03']);

hold off



subplot(2,2,3)

hold on

load('calib_2_5.mat');

[ predictions, invest, profit, property, bet_case_calib ] = simpleSim( 100, observations, expert_predictions, odds, @followOne, calib_predictions, 'exp_fix', threshE);
plot(property, '-', 'color', cc(1, :), 'LineWidth', 1.5);

[ predictions, invest, profit, property, bet_case_calib2 ] = simpleSim( 100, observations, expert_predictions, odds, @followOne, calib_predictions, 'prob_fix', threshP);
plot(property, '-', 'color', cc(2, :), 'LineWidth', 1.5);

ylim([50 200])

legend('expectation', 'probability', 'location', 'Northwest');

title(['WAA & Calibration Loss & epsilon: 0.05']);

hold off

subplot(2,2,4)

hold on

load('calib_2_7.mat');


[ predictions, invest, profit, property, bet_case_calib ] = simpleSim( 100, observations, expert_predictions, odds, @followOne, calib_predictions, 'exp_fix', threshE);
plot(property, '-', 'color', cc(1, :), 'LineWidth', 1.5);

[ predictions, invest, profit, property, bet_case_calib2 ] = simpleSim( 100, observations, expert_predictions, odds, @followOne, calib_predictions, 'prob_fix', threshP);
plot(property, '-', 'color', cc(2, :), 'LineWidth', 1.5);

ylim([50, 200])

legend('expectation', 'probability', 'location', 'Northwest');

title(['WAA & Calibration Loss & epsilon 0.07']);

hold off
    