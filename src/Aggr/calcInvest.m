function [ invest ] = calcInvest( thresh, odd, prob, property, type )
%DEFINVEST Summary of this function goes here
%INPUT:
%   thresh   - threshold 
%   odd      - maximum odd provided by bookmakers
%   prob     - probability of our prediction
%   property - property we can bet for each round
%   type     - threshold type. 'expectation' / 'probability'
%OUTPUT:
%
%   invest   - amount to invest in this round
%



switch type
    case 'exp_conf'
        max_margin = 0.1; % It is highly unlikely to have a margin larger than 10%
        invest = min(1, max(0, (odd*prob - 1 - thresh) / (max_margin-thresh))) * (property * 1/3);
    case 'prob_conf'
        invest = max(0, (prob - thresh) / (1 - thresh) ) * (property * 1/3);
    case 'prob_fix'
        if (prob - thresh) > 0
            invest = 5;
        else
            invest = 0;
        end
    case 'exp_fix'
        if (odd*prob - 1 - thresh) > 0
            invest = 5;
        else
            invest = 0;
        end        
    otherwise
        warning('undefined investment scheme... bet 1 for all input.')
        invest = 1;
end
        


end

