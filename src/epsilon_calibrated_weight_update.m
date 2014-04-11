function [ new_weights ] = epsilon_calibrated_weight_update( old_weights,predictions,match_number )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

eta=1;
loss=zeros(size(old_weights));

for i=1:length(old_weights)
    
    current_prediction=predictions(1,(i-1)*3+1:(i-1)*3+3);
    loss(i)=epsilon_calibrated_loss(current_prediction,match_number,i);
    
end

exponential_correction=exp(-eta*loss);

not_normalized_weights=old_weights.*exponential_correction;
normalization_const=sum(not_normalized_weights);

new_weights=not_normalized_weights/normalization_const;

end