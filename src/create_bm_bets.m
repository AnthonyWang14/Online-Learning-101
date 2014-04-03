function [ bets ] = create_bm_bets( probabilities )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%we expect three probabilities by each bookmaker
if( mod(length(probabilities), 3)~=0)
    error('Incorrect size of Probablities Vector');
end

%initialization of the Bets Vector
bets=zeros(1,length(probabilities)/3);

%initialize the vector that allows to extract resuluts from a logical
%vector that indicates the maximum

result_vec=[1 0 2];

for i=1:length(bets)
    p_current_bm=probabilities((i-1)*3+1:(i-1)*3+3);
    
    tmp=(p_current_bm==max(p_current_bm)); % logial vector with ones for the max and zeros for other val
    bets(i)=result_vec(tmp);
end

end

