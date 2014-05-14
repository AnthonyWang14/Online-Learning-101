function [ earnings ] = max_probability_bet( odds_row, outcome, my_prob, min_probability, threshold_DC )
earnings=0;
money_to_bet=10;
if(any(my_prob>=threshold_DC))
   [min_value, index]= min(my_prob, [], 2);   %index= not happening event
   if mod(index,3)==1;
    not_result=1;
    elseif mod(index,3)==2
    not_result=0;
    else
    not_result=2;
   end
   if(not_result~=outcome)
       earnings=0.03*money_to_bet;
   else
       earnings=-money_to_bet;
   end    
end

if (any(my_prob>=min_probability))
    [max_value, index]= max(my_prob, [], 2);
    if mod(index,3)==1;
    result=1;
    elseif mod(index,3)==2
    result=0;
    else
    result=2;
    end
    odds_of_interest=odds_row(index:3:27+index);
    odd=max(odds_of_interest);
    if(result==outcome)
        earnings=money_to_bet*odd;
    else
        earnings=-money_to_bet;
    end
end


end

