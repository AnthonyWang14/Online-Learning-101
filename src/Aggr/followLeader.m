function [ predictions, loss , expert_loss, wmat ] = followLeader( observations, expert_predictions, varargin)
% Strong aggregating algorithm for the Brier game
% INPUT:
%   observations        - results of every game 
%   expert_predictions  - predictions of the experts
%   
% OUTPUT:
%   loss                - overall loss of the  algorithm
%   expert_loss         - overall loss of each expert
%   predictions         - predictions of the algorithm
%




%TODO: better argument parsing.
if nargin == 4
    % learning rate
    eta = varargin{1};
    loss_func = varargin{2};
else
    % Default learning rate is 1
    eta = 1;
    loss_func = @l2sq;
end

ob_dim = 3;

nGame = length(observations);
nExpert = size(expert_predictions, 2) / ob_dim;

weights = ones(1, nExpert) / nExpert;
loss = zeros(nGame, 1);
expert_loss = zeros(nGame, nExpert);
predictions = zeros(nGame, ob_dim);


wmat = zeros(nGame, nExpert);

for i = 1:nGame
   
    wmat(i,:) = weights;
    
    round_prediction = reshape(expert_predictions(i, :), ob_dim,  nExpert)';
    
    [~, leader_idx] = max(weights);
    
    % take the advice from the best expert
    predictions(i, :) = round_prediction(leader_idx, :);
    
    for k=1:nExpert
        expert_loss(i, k) = loss_func(observations(i), round_prediction(k, :));
    end
    
    % Likely we suffer the same loss and our trusted pal
    loss(i) = expert_loss(i, leader_idx);
    
    % Update weights
    weights = weights.*exp(- eta * expert_loss(i, :));
    
    % Normalize weights for numerical stability
    weights = weights ./ sum(weights);
    
    
   
end



end

