function [ new_amount ] = amount_update_e( odds, outcomes, predictions, available_amount,  threshold)
% INPUT ARGUMENTS: 10x30 matrix of 10 matches odds = odds
%                  10x1  vector of 10 matches actual results= outcomes
%                  10x3  matrix of prbability distributions forecasted =predictions
%                  value of current amount of money to be invested = available_amount
%                  value of minimum acceptale expected return for betting = threshold

expected_values = zeros(size(odds));  %create a row of zeros for the expected values



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
[value_e columns_e]=max(expected_values, [], 2); %find the maximum expected return for each of the 10 matches

rows = find(value_e>=threshold);
matches = odds(rows, :);
outcomes = outcomes(rows);
columns_e = columns_e(rows);

%--------------------------------------------------------------------------
% %DISPLAY SECTION 2
% display('newline');
% odds(rows, :)
% predictions(rows, :)
% columns_p
% my_outcomes
% outcomes 
% my_outcomes==outcomes                            

my_outcomes=zeros(length(columns_e), 1);

for h=1:size(rows, 1)
    if(columns_e(h)==0)
        my_outcomes(h) = 2;
    elseif(columns_e(h)==1)
        my_outcomes(h) = 1;
    elseif(columns_e(h)==2)
        my_outcomes(h)=0;
    end
end

my_outcomes

%START BET SIMULATION
if (isempty(find(value_e>=threshold, 1)))
    new_amount = available_amount;         %No bet this week-end
    display('exit');
    return;
else
     new_amount = 0;      %Assuming we reinvest the whole amount every time we find a good match
     
     for j=1:length(rows) %for every confident match
         if(my_outcomes(j)==outcomes(j)) %IF it was correctly predicted
             gain = matches(j, columns_e(j));
             new_amount = new_amount + gain*available_amount/length(rows);
%           display('done update function');
         end     
     end
     
     return;
          
end


end


