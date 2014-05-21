function lambda = logloss(omega, gamma)
% loss function on probability space gamma and discrete observation space
% omega(indicating index)
    lambda = -log(gamma(omega));     
end


