function lambda = l2sq(omega, gamma)
% loss function on probability space gamma and discrete observation space
% omega

    delta = zeros(size(gamma));
    delta(omega) = 1;
    lambda = sum((gamma - delta).^2);
        
end


