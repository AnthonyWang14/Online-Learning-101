function [ loss, calibration_err ] = forcaster_eps_calibrated_loss ( history, epsilon )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% epsilon=0.02 ;

prediction = history(end,1:3);

home_selection=(history(:,1)<=prediction(1)+epsilon & history(:,1)>=prediction(1)-epsilon);

draw_selection=(history(:,2)<=prediction(2)+epsilon & history(:,2)>=prediction(2)-epsilon);

away_selection=(history(:,3)<=prediction(3)+epsilon & history(:,3)>=prediction(3)-epsilon);

home_history_outcome=history(home_selection,4);
relative_home_frequency=sum(home_history_outcome==1)/length(home_history_outcome);

draw_history_outcome=history(draw_selection,4);
relative_draw_frequency=sum(draw_history_outcome==0)/length(draw_history_outcome);

away_history_outcome=history(away_selection,4);
relative_away_frequency=sum(away_history_outcome==2)/length(away_history_outcome);

calibrated_vec=[relative_home_frequency relative_draw_frequency relative_away_frequency];

calibration_err = prediction-calibrated_vec;

y1=calibrated_vec(1);             p1=prediction(1);
y2=calibrated_vec(2);             p2=prediction(2);
y3=calibrated_vec(3);             p3=prediction(3);
if(y1==0)
    y1=0.0001;
elseif(y1==1)
    y1=0.9999;
end
    
if(y2==0)
    y2=0.0001;
elseif(y2==1)
    y2=0.9999;
end

if(y3==0)
    y3=0.0001;
elseif(y3==1)
    y3=0.9999;
end

loss= y1*log(y1/p1)+(1-y1)*log((1-y1)/(1-p1))+y2*log(y2/p2)+(1-y2)*log((1-y2)/(1-p2))+y3*log(y3/p3)+(1-y3)*log((1-y3)/(1-p3));


end

