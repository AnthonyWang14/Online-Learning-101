function [ p_estimate ] = my_prob( weights, bm_prob )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


if( mod(length(bm_prob), 3)~=0)
    error('Incorrect size of Bookmakers Probablities Vector');
end

bm_prob_mat=reshape(bm_prob,3,length(bm_prob)/3);

%assuming weights to be a row vector
weights_mat=repmat(weights,3,1);

weighted_bm_mat=weights_mat.*bm_prob_mat;
not_normalized_p=sum(weighted_bm_mat');
normalization_const=sum(weights);

p_estimate=not_normalized_p./normalization_const;

end