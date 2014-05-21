function [ predictions, loss , expert_loss, weights ] = weightedAvg( observations, expert_predictions, varargin)
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

weights = ones(nExpert, 1) / nExpert;
loss = zeros(nGame, 1);
expert_loss = zeros(nGame, nExpert);
predictions = zeros(nGame, ob_dim);


for i = 1:nGame
   
    round_prediction = reshape(expert_predictions(i, :), ob_dim,  nExpert)';
    
    % take the advice from the best expert
    pred = sum(repmat(weights, 1, 3) .* round_prediction) ./ sum(weights);
    
    predictions(i, :) = pred ./ sum(pred);
    
    loss(i) = loss_func(observations(i), predictions(i, :));
    
    for k=1:nExpert
        expert_loss(i, k) = loss_func(observations(i), round_prediction(k, :));
    end
    
    % Update weights
    weights = weights.*exp(- eta * expert_loss(i, :))';
    
    % Normalize weights for numerical stability
    weights = weights ./ sum(weights);
    
   
end



end

