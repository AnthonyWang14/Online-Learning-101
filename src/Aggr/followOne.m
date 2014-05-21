function [ predictions] = followOne( observations, expert_predications, varargin )
%HOMEWIN Summary of this function goes here
%   Detailed explanation goes here

if nargin == 3
    % Dimension of observation space
    input_predictions = varargin{1};
else
    error('no input prediction provided.');
end

predictions = input_predictions;


end

