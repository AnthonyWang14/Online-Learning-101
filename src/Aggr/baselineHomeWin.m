function [ decisions, invest, profit, property, betCase] = baselineHomeWin( initial_invest, observations, odds)
%SIMULI simulation of the greedy investment 
%INPUT: 
%   initial_invest            - total investment at the beginning
%   observations        - results of every game 
%   expert_predictions  - predictions of the experts
%   odds                - odds provided by bookmakers

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
    odds3(:, :, i) = odds(:, i:ob_dim:size(odds,2));
end

% Investment percentage for each round
invest_ratio = 0.02;

% Always bet on home win (1)
decisions = ones(size(observations));

% Game that we start betting.
start = 100;
property(1:start) = initial_invest;

% Decide how much money we would invest on a single game
% TODO: not a good idea, the expection at the round could be negative, which
% lead us to a bad call, never the less focusing on the expectation is  
% Bet on games

betCase = zeros(7,0);

for i=start:size(decisions)
    invest(i) = invest_ratio * property(i-1);
    
    if invest(i) > 0
        
        if decisions(i) == observations(i)
            % Always go for the maximum revenue once we make our decision
            max_odds(i) = max(odds3(i,:,decisions(i)));
            profit(i) = invest(i) * (max(odds3(i,:,decisions(i)))-1);            
        else
            % Sadly we lose everything
            max_odds(i) = -1;
            profit(i) = - invest(i);
        end
        
    betCase = [betCase; [i, decisions(i), observations(i), invest(i), max_odds(i), profit(i), property(i-1) + profit(i)]];    
    end
    
    property(i) = property(i-1) + profit(i);
end



end

