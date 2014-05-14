function [ new_amount ] = amount_update_p( odds, outcomes, predictions, available_amount,  threshold)
% INPUT ARGUMENTS: 10x30 matrix of 10 matches odds = odds
%                  10x1  vector of 10 matches actual results= outcomes
%                  10x3  matrix of prbability distributions forecasted =predictions
%                  value of current amount of money to be invested = available_amount
%                  value of minimum acceptale expected return for betting = threshold

expected_values = zeros(size(odds));  %create a row of zeros for the expected values
% max_expectations
my_outcomes=zeros(length(outcomes), 1);


%DEFINE MY OUTCOMES
for k=1:length(outcomes)    
    ind = find(predictions(k, :)== max(predictions(k, :)));  %take the column index of the maximum value in each "k-th row"
    if(mod(ind(1), 3)==1)                                    %using ind(1) I avoid ambiguities for many maximum values in the same row
        my_outcomes(k) = 1;
    elseif(mod(ind(1), 3)==0)
        my_outcomes(k) = 2;
    elseif(mod(ind(1), 3)==2)
        my_outcomes(k) = 0;
    end
        
end

%DEFINE EXPECTED VALUE MATRIX 
for i=1:(size(odds, 2))/3
    
    expected_values(:, (i-1)*3+1)=predictions(:, 1).*odds(:, (i-1)*3+1) - (ones(size(predictions, 1), 1)-predictions(:, 1));
    
    expected_values(:, (i-1)*3+2)=predictions(:, 2).*odds(:, (i-1)*3+2) - (ones(size(predictions, 1), 1)-predictions(:, 2));
    
    expected_values(:, (i-1)*3+3)=predictions(:, 3).*odds(:, (i-1)*3+3) - (ones(size(predictions, 1), 1)-predictions(:, 3));
    
end

% %DISPLAY SECTION 1
% predictions
% my_outcomes
% outcomes 
% odds
% %expected_values

%COLUMNS AND ROWS DETECTION
[value_p, columns_p] = max(predictions, [], 2); %find the maximum probability estimate for each of the 10 matches

rows = find(value_p>=threshold);  %store the indices of the rows of interest (that overcome the threshold with probability more than "threshold")

matches=odds(rows, :);          %Select the odds of the matches that in which we are confident 
my_outcomes=my_outcomes(rows);  %select my predictions for those confident matches (1 or 2 or 0)
outcomes=outcomes(rows);        %select actual outcomes of the confident matches
columns_p=columns_p(rows);      %in those confident matches which column correspond to maximum probability?

% [value_odd, columns_odd] = max(matches, [], 2); %select the maximum value from each row and store it in value, 
%                                                 %store the indices of the position of each maximum value in each row

% %DISPLAY SECTION 2
% display('newline');
% odds(rows, :)
% predictions(rows, :)
% columns_p
% my_outcomes
% outcomes 
% my_outcomes==outcomes                            



%START BET SIMULATION
if (isempty(find(value_p>=threshold, 1)))
    new_amount = available_amount;         %No bet this week-end
    display('exit');
    return;
else
     new_amount = 0;      %Assuming we reinvest the whole amount every time we find a good match
     
     for j=1:length(rows) %for every confident match
         if(my_outcomes(j)==outcomes(j)) %IF it was correctly predicted
            
             if(columns_p(j)==3) %my correct prediction was away win ----> SELECT THE BEST AWAY WIN ODD FOR THAT MATCH AND compute the reward  
                 odds_selection=matches(j, mod(1:size(matches, 2)-1, 3)==0); %select all the away win odds for the confident match "j"
                 new_amount = new_amount + max(odds_selection)*available_amount/length(rows);
             else
                 odds_selection=matches(j, mod(1:size(matches, 2)-1, 3)==columns_p(j)); %select etiher all the home win odds or the draw ones according to the value of "columns_p(j)"
                 new_amount = new_amount + max(odds_selection)*available_amount/length(rows);
             end
             
%              length(rows)
%              display('done update function');
         end     
     end
     
     return;
          
end


end

