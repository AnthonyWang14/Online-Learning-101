function [ prob_mat ] = create_prob_mat( odds_mat )
%odds matrix ----> compute probability for each row, get rid of NaN rows
%and count the number of rows deleted.
%then build a new matrix with probabilities and results as labels
nan_count=0;
prob_mat=zeros(size(odds_mat));

for i=1:size(odds_mat, 1)
    if(any(isnan(odds_mat(i, :))))
        nan_count =  nan_count+1;    
    else
        prob_mat(i, :) = [odds2p(odds_mat(i, 1:size(odds_mat, 2)-1)), odds_mat(i, end)];
    end
end
nan_count
find(any(prob_mat, 2)==0)
prob_mat = prob_mat(any(prob_mat, 2), :);



end

