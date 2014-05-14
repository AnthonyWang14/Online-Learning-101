clear all
threshold_DC =0.7;
for threshold=0.7:0.05:0.9
for eps=1:10
clearvars -except eps threshold threshold_DC 
fname = sprintf('script_1norm_eps%d.mat', eps);
load (fname);
load odd_mat_PL_07_13;

                                      
min_expectation = threshold;
min_probability = threshold;
odds_mat=odd_mat_PL_07_13(:, 1:30);   %Extract just the odds 

outcomes=odd_mat_PL_07_13(:, end);    %Extract just the results

earnings=zeros(size(odds_mat,1), 2);   %Define a new earning-vector


for i=1:size(odds_mat,1)
    earnings(i, 1)= max_expected_value_bet(odds_mat(i,:),outcomes(i),result_vector(i,1:3), min_expectation);
    earnings(i, 2)= max_probability_bet(odds_mat(i,:),outcomes(i),result_vector(i,1:3), min_probability, threshold_DC);
end

plot(cumsum(earnings, 1));
titlename = sprintf('Earnings 1norm eps%d Emin%d', eps, threshold);
title(titlename);
legend('E max', 'Pmax', 'Location', 'Best');
figure;
end  %inner loop for eps

end  %outer loop for threshold of expected value