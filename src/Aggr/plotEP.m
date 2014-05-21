close all
clear all

load('data.mat');

figure;

threshE = 0.015;
threshP = 0.80;


cc = hsv(2);

subplot(1,4,1)
hold on;


[ predictions, invest, profit, property, bet_case_avg ] = simpleSim( 100, observations, expert_predictions, odds, @weightedAvg, {1, @l2sq}, 'exp_fix', threshE);
plot(property, '-', 'color', cc(1, :), 'LineWidth', 1.5);

[ predictions, invest, profit, property, bet_case_avg2 ] = simpleSim( 100, observations, expert_predictions, odds, @weightedAvg, {1, @l2sq}, 'prob_fix', threshP);

plot(property, '-', 'color', cc(2, :), 'LineWidth', 1.5);

ylim([50 250])
xlim([0 2200])

legend('expectation (0.15)', 'probability (0.8)', 'location', 'Northwest');

title(['WAA & Brier Loss'], 'fontSize',14);

hold off


subplot(1,4,2)

hold on

load('calib_2_3.mat');

[ predictions, invest, profit, property, bet_case_calib ] = simpleSim( 100, observations, expert_predictions, odds, @followOne, calib_predictions, 'exp_fix', threshE);
plot(property, '-', 'color', cc(1, :), 'LineWidth', 1.5);

[ predictions, invest, profit, property, bet_case_calib2 ] = simpleSim( 100, observations, expert_predictions, odds, @followOne, calib_predictions, 'prob_fix', threshP);
plot(property, '-', 'color', cc(2, :), 'LineWidth', 1.5);

ylim([50 220])
xlim([0 2200])

legend('expectation (0.15)', 'probability (0.8)', 'location', 'Northwest');

title(['WAA & Calibration Loss & epsilon: 0.03'], 'fontSize',14);

hold off



subplot(1,4,3)

hold on

load('calib_2_5.mat');

[ predictions, invest, profit, property, bet_case_calib ] = simpleSim( 100, observations, expert_predictions, odds, @followOne, calib_predictions, 'exp_fix', threshE);
plot(property, '-', 'color', cc(1, :), 'LineWidth', 1.5);

[ predictions, invest, profit, property, bet_case_calib2 ] = simpleSim( 100, observations, expert_predictions, odds, @followOne, calib_predictions, 'prob_fix', threshP);
plot(property, '-', 'color', cc(2, :), 'LineWidth', 1.5);

ylim([50 250])
xlim([0 2200])

legend('expectation (0.15)', 'probability (0.8)', 'location', 'Northwest');

title(['WAA & Calibration Loss & epsilon: 0.05'], 'fontSize',14);

hold off

subplot(1,4,4)

hold on

load('calib_2_7.mat');


[ predictions, invest, profit, property, bet_case_calib ] = simpleSim( 100, observations, expert_predictions, odds, @followOne, calib_predictions, 'exp_fix', threshE);
plot(property, '-', 'color', cc(1, :), 'LineWidth', 1.5);

[ predictions, invest, profit, property, bet_case_calib2 ] = simpleSim( 100, observations, expert_predictions, odds, @followOne, calib_predictions, 'prob_fix', threshP);
plot(property, '-', 'color', cc(2, :), 'LineWidth', 1.5);

ylim([50 250])
xlim([0 2200])

legend('expectation (0.15)', 'probability (0.8)', 'location', 'Northwest');

title(['WAA & Calibration Loss & epsilon 0.07'], 'fontSize',14);

hold off
    