
for i=1:10
    i
    exp = expert_predictions(:, (i-1)*3+1:(i-1)*3+3);
    [~, expi] = max(exp, [], 2);
    
    sum(expi == observations);
    
    
    

end