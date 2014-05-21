function [ predictions,loss , expert_loss, weights ] = strongAggr( observations, expert_predictions, varargin)
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

ob_dim = 3;

%TODO: better argument parsing.
if nargin == 3
    eta = varargin{1};
else
    % learning rate is fixed to 1, as suggested.
    eta = 1;
end

nGame = length(observations);
nExpert = size(expert_predictions, 2) / ob_dim;


weights = ones(1, nExpert);
loss = zeros(nGame, 1);
expert_loss = zeros(nGame, nExpert);
predictions = zeros(nGame, ob_dim);


for i = 1:nGame
    
    gn = zeros(ob_dim, 1);
    round_prediction = reshape(expert_predictions(i, :), ob_dim,  nExpert)';
    
    for j = 1:ob_dim
   
        % TODO: eliminate this loop
        for k = 1:nExpert
            gn(j) = gn(j) + weights(k)*exp(-eta * l2sq(j, round_prediction(k, :)));
        end
        
        gn(j) = -log(gn(j)) / eta;
   
    end
    
    gns = sort(gn, 'ascend');
    
    % Use intervals
    gns_i = -([1; gns] - [gns; 1]);
    gns_i = [gns_i(2:end-1); 0];
    
    acc = 0;
    for j=1:length(gns_i)
        acc = acc + gns_i(j)*j;
        if acc >= 2
            break;
        end            
    end
    
    % Go one step back
    s = (2 - (acc - gns_i(j)*j))/j + gns(j);
    
    for j=1:ob_dim
        predictions(i, j) = max(s-gn(j), 0) / 2;
    end
    
    loss(i) = l2sq(observations(i), predictions(i, :));
    
    for k=1:nExpert
        expert_loss(i, k) = l2sq(observations(i), round_prediction(k, :));
    end
    
    % Update weights
    weights = weights.*exp(- eta * expert_loss(i, :));
    
    % Normalize weights for numerical stability
    weights = weights ./ sum(weights);
    
end


end



