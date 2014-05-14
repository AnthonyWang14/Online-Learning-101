function [ predictions, invest, profit, property, max_odds ] = simpleSim( initial_invest, observations, expert_predictions, odds, pred_algorithm, pred_params)
%SIMULI simulation of the greedy investment 
%INPUT: 
%   initial_invest            - total investment at the beginning
%   observations        - results of every game 
%   expert_predictions  - predictions of the experts
%   odds                - odds provided by bookmakers
%   pred_algorithm      - prediction algorithm
%   pred_param          - parameters for the prediction algorithm
%
%OUTPUT:
%   predictions         - game result we predict for each round
%   invest              - investment for each round
%   profit              - profit for each round
%   proerty             - all the money we have after n rounds

ob_dim = 3;

profit = zeros(size(observations));
invest = zeros(size(observations));
property = zeros(size(observations));
max_odds = zeros(size(observations));


odds3 = zeros(size(odds,1), size(odds,2)/ob_dim, ob_dim );

for i = 1:ob_dim
    odds3(:, :, i) = odds(:, 1:ob_dim:size(odds,2));
end

% Fold in case we don't have a high probability estimation
conf_thresh = 0.5;

% Game that we start betting.
start = 100;
property(1:start) = initial_invest;


% Apply prediction algorithm to get probability predictions from experts'
% advices
[ ~, ~, predictions, ~ ] = pred_algorithm( observations, expert_predictions, pred_params);

% Transform probability to discrete decision
[max_conf, decisions] = max(predictions, [], 2);

% Decide how much money we would invest on a single game
% TODO: not a good idea, the expection at the round could be negative, which
% lead us to a bad call, never the less focusing on the expectation is  
% Bet on games
for i=start:size(decisions)
    invest(i) = max(0, ((max_conf(i) - conf_thresh) ./ (1 - conf_thresh)) .* (property(i-1)*1/3));
    if decisions(i) == observations(i)
        % Always go for the maximum revenue once we make our decision
        max_odds(i) = max(odds3(i,:,decisions(i)));
        profit(i) = invest(i) * max(odds3(i,:,decisions(i)));            
    else
        % Sadly we lose everything
        profit(i) = - invest(i);
    end
    property(i) = property(i-1) + profit(i);
end



end

