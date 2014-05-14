clear all
for threshold_e=0.55:0.05:0.9
for eps=1:10
    
clearvars -except eps threshold_e
%LOADING SECTION
% eps=5;
fname = sprintf('script_KLdivergence_eps%d.mat', eps);
load (fname);          %load the entire script of interest
load odd_mat_PL_07_13; %load bookmakers odds for all matches

%DEGREES OF FREEDOM
starting_match = 601;  %make sure that "length(outcomes)-starting_match" is a multiple of 10  (*see check)
min_expectation = threshold_e; %define a threshold for the expected return to bet on
min_probability = 0.8;

%REARRANGE MATRICES
odds_mat = odd_mat_PL_07_13(starting_match:end, 1:30);   %Extract just the odds from the starting match
outcomes = odd_mat_PL_07_13(starting_match:end, end);    %Extract just the results from the starting match
results = result_vector(starting_match:end, :);          %Extract the predictions from the starting match
week_amount = zeros(length(outcomes)/10, 2);
%Check
if(mod(length(outcomes), 10)~=0)
    error('Dimension of total matches is not a multiple of 10'); 
end

%DIVISION BY WEEK-ENDS 
for i=1:length(outcomes)/10
    if(i==1)
        week_amount(i, 1)= amount_update_p(odds_mat((i-1)*10+1:i*10, :), outcomes((i-1)*10+1:i*10), results((i-1)*10+1:i*10, 1:3), 1, min_probability); %initial amount assumed to be 1
    elseif week_amount(i-1, 1)>0  %if the amount vanishes restart from 1 !!!
        week_amount(i, 1)=amount_update_p(odds_mat((i-1)*10+1:i*10, :), outcomes((i-1)*10+1:i*10), results((i-1)*10+1:i*10, 1:3), week_amount(i-1), min_probability);
    elseif week_amount(i-1, 1)==0
        week_amount(i, 1)=1;        
    end
    
    if(i==1)
        week_amount(i, 2)= amount_update_e(odds_mat((i-1)*10+1:i*10, :), outcomes((i-1)*10+1:i*10), results((i-1)*10+1:i*10, 1:3), 1, min_expectation);
    elseif week_amount(i-1, 2)>0
        week_amount(i, 2)= amount_update_e(odds_mat((i-1)*10+1:i*10, :), outcomes((i-1)*10+1:i*10), results((i-1)*10+1:i*10, 1:3), week_amount(i-1), min_expectation);
    elseif week_amount(i-1, 2)==0
        week_amount(i, 2)=1;
    end    
end

plot(week_amount);
titlename=sprintf('EXP Earnings KL eps%d Emin%d', eps, threshold_e);
title(titlename);
legend('P max', 'E max',  'Location', 'Best');
figure;
end
end