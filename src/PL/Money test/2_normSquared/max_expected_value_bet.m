function [ earnings] = max_expected_value_bet( odds, outcome, probabilities, threshold)
%odds=row of odds provided by the bookmakers for a certain match
%outcome=one result of the match
%probabilities= probability distribution forcasted for a certain match

expected_values = zeros(size(odds));  %create a row of zeros for the expected values
money_to_bet=10;                      %define the fixed amount to bet at each match

for i=1:(length(odds))/3
    
    expected_values((i-1)*3+1)=money_to_bet*probabilities(1)*odds((i-1)*3+1)-money_to_bet*(1-probabilities(1));
    
    expected_values((i-1)*3+2)=money_to_bet*probabilities(2)*odds((i-1)*3+2)-money_to_bet*(1-probabilities(2));
    
    expected_values((i-1)*3+3)=money_to_bet*probabilities(3)*odds((i-1)*3+3)-money_to_bet*(1-probabilities(3));
    
end

[M ind]=max(expected_values);

if mod(ind,3)==1;
    result=1;
elseif mod(ind,3)==2
    result=0;
else
    result=2;
end

win=(result==outcome);

 if M>=0.88*money_to_bet
     money_to_bet = money_to_bet*20;
 end

% if win==1
%     earnings=money_to_bet*(odds(ind)-1);
% else
%     earnings=-1*money_to_bet;
% end

if M<=threshold*money_to_bet
    earnings=0;
elseif win==1
    earnings=money_to_bet*(odds(ind)-1);
elseif win==0
    earnings=-1*money_to_bet;
end
    

    
end

