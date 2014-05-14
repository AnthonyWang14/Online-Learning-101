function [ loss ] = epsilon_calibrated_loss( prediction, match_number, book_maker_num, epsilon )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% epsilon=0.02;

load prob_mat_PL_07_13.mat;

historic_results = prob_mat_PL_07_13(1:match_number,[(book_maker_num-1)*3+1:(book_maker_num-1)*3+3 size(prob_mat_PL_07_13, 2)]);

%logic vectors for historic predictions being in the interval [current_prediction-epsilon, current_prediction+epsilon]
home_selection=(historic_results(:,1)<=prediction(1)+epsilon & historic_results(:,1)>=prediction(1)-epsilon);

draw_selection=(historic_results(:,2)<=prediction(2)+epsilon & historic_results(:,2)>=prediction(2)-epsilon);

away_selection=(historic_results(:,3)<=prediction(3)+epsilon & historic_results(:,3)>=prediction(3)-epsilon);

home_historic_outcome=historic_results(home_selection, end);
relative_home_frequency=sum(home_historic_outcome==1)/length(home_historic_outcome);

draw_historic_outcome=historic_results(draw_selection,end);
relative_draw_frequency=sum(draw_historic_outcome==0)/length(draw_historic_outcome);

away_historic_outcome=historic_results(away_selection,end);
relative_away_frequency=sum(away_historic_outcome==2)/length(away_historic_outcome);

calibrated_vec=[relative_home_frequency, relative_draw_frequency, relative_away_frequency];

calibration_err = prediction-calibrated_vec;

loss=sqrt(sum(calibration_err.^2));



end

