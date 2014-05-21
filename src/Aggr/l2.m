function lambda = l2(omega, gamma)
% loss function on probability space gamma and discrete observation space
% omega

    delta = zeros(size(gamma));
    delta(omega) = 1;
    lambda = sqrt(sum((gamma - delta).^2));     
end


