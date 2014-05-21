function [ predictions] = homeWin( observations, expert_predications, varargin )
%HOMEWIN Summary of this function goes here
%   Detailed explanation goes here

if nargin == 3
    % Dimension of observation space
    ob_dim = varargin{1};
else
    ob_dim = 3;
end

predictions = zeros(length(observations),ob_dim);

% always go for home win
predictions(:, 1) = 1;

end

