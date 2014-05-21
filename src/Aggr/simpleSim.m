function [ predictions, invest, profit, property, bet_cases ] = simpleSim( initial_invest, observations, expert_predictions, odds, pred_algorithm, pred_params, invest_type, invest_thresh)
%SIMULI simulation of the greedy investment 
%INPUT: 
%   initial_invest            - total investment at the beginning
%   observations        - results of every game 
%   expert_predictions  - predictions of the experts
%   odds                - odds provided by bookmakers
%   pred_algorithm      - prediction algorithm
%   pred_param          - parameters for the prediction algorithm
%   invest_type         - type of invest we want to use:
%                           1. exp_conf 
%                           2. prob_conf
%                           3. exp_fix
%                           4. prob_fix
%   invest_thresh       - fold in case we don't have a high probability estimation
%OUTPUT:
%   predictions         - game result we predict for each round
%   invest              - investment for each round
%   profit              - profit for each round
%   proerty             - all the money we have after n rounds
%   bet_cases           - cases we invest money

ob_dim = 3;

profit = zeros(size(observations));
invest = zeros(size(observations));
property = zeros(size(observations));
max_odds = zeros(size(observations));


odds3 = zeros(size(odds,1), size(odds,2)/ob_dim, ob_dim );

for i = 1:ob_dim
    odds3(:, :, i) = odds(:, i:ob_dim:size(odds,2));
end

% Game that we start betting.
start = 101;
property(1:start) = initial_invest;


% Apply prediction algorithm to get probability predictions from experts'
% advices
[predictions] = pred_algorithm( observations, expert_predictions, pred_params);

% Transform probability to discrete decision
[max_conf, decisions] = max(predictions, [], 2);

% Decide how much money we would invest on a single game
% TODO: not a good idea, the expection at the round could be negative, which
% lead us to a bad call, never the less focusing on the expectation is  
% Bet on games

bet_cases = zeros(0, 8);

for i=start:size(decisions)
    
    % Always go for the maximum revenue once we make our decision
    max_odds(i) = max(odds3(i,:,decisions(i)));
   
    invest(i) =  calcInvest(invest_thresh, max_odds(i), max_conf(i), property(i-1), invest_type);
       
    if decisions(i) == observations(i)
        profit(i) = invest(i) * (max(odds3(i,:,decisions(i)))-1);            
    else
        % Sadly we lose everything
        profit(i) = - invest(i);
    end
         
    property(i) = property(i-1) + profit(i);

    % record everything
    if invest(i) > 0
        bet_cases = [bet_cases; [i, max_conf(i), decisions(i), observations(i), invest(i), max_odds(i), profit(i), property(i-1) + profit(i)]];    
    end
end



end

