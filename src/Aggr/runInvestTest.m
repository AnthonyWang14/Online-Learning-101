close all
clear all

load('data_pl.mat');
load('calib_2_3.mat');

thresh = [0.01];
invest_way = 'exp_fix';

for t = 1:length(thresh)

    figure;
    hold on;

    cc = hsv(6);

    [ predictions, invest, profit, property, bet_case_strong ] = simpleSim( 100, observations, expert_predictions, odds, @strongAggr, 1, invest_way, thresh(t));
    plot(property, '-', 'color', cc(1, :));

    [ predictions, invest, profit, property, bet_case_avg ] = simpleSim( 100, observations, expert_predictions, odds, @weightedAvg, {1, @l2sq}, invest_way, thresh(t));
    plot(property, '-', 'color', cc(2, :));

    [ predictions, invest, profit, property, bet_case_leader ] = simpleSim( 100, observations, expert_predictions, odds, @followLeader, {1, @l2sq}, invest_way, thresh(t));
    plot(property, '-', 'color', cc(3, :));

    % [ predictions, invest, profit, property, bet_case_hw ] = simpleSim( 100, observations, expert_predictions, odds, @homeWin, 1, 'prob_fix', thresh(t));
    %plot(property, '-.', 'color', cc(4, :));

    ob_dim = 3;

    pp= [];
    max_pp = zeros(size(observations));
    bet_case_one = zeros(size(observations));
    for i = 1:10
        [ predictions, invest, profit, property, betCase ] = simpleSim( 100, observations, expert_predictions, odds, @followOne, expert_predictions(:, (i-1)*ob_dim+1:i*ob_dim), invest_way, thresh(t));
        if max_pp(end) < property(end)
            max_pp = property;
            bet_case_one = betCase;
        end
        pp = [pp, property];
    end
    plot(max_pp, '--', 'color', cc(5, :));


    [ predictions, invest, profit, property, bet_case_calib ] = simpleSim( 100, observations, expert_predictions, odds, @followOne, calib_predictions, invest_way, thresh(t));
    plot(property, '-.', 'color', cc(6, :));


    legend('strongAggr', 'weightedAvg', 'followBest', 'bookmaker', 'calibration');
    title(['thresh = ', num2str(thresh(t))]);


    hold off
    
end