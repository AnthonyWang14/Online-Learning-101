function [not_nan_selection prob_mat ] = create_prob_mat( odds_mat )
%odds matrix ----> compute probability for each row, get rid of NaN rows
%and count the number of rows deleted.
%then build a new matrix with probabilities and results as labels
nan_count=0;
prob_mat=zeros(size(odds_mat));
not_nan_rows = zeros(size(odds_mat, 1), 1);

for i=1:size(odds_mat, 1)
    if(any(isnan(odds_mat(i, :))))
        nan_count =  nan_count+1;  %cunt the number of not a number rows  
    else
        prob_mat(i, :) = [odds2p(odds_mat(i, 1:size(odds_mat, 2)-1)), odds_mat(i, end)];
        not_nan_rows(i)= i;        %at every not nan row set the number to a nonzero value
    end
end
nan_count
find(any(prob_mat, 2)==0);
prob_mat = prob_mat(any(prob_mat, 2), :);
not_nan_selection=not_nan_rows(not_nan_rows~=0);   %"not_nan_rows~=0" is a logic vector: 0 corresponds to a "nan" row while 1 corresponds to normal row, 
                                              %THEN we just select the normal rows:
                                              %"not_nan_rows(not_nan_rows~=0)"
                                              %and each element has exactly
                                              %the row number to be
                                              %selected



end

