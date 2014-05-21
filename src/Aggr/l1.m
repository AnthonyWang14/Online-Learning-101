function lambda = l1(omega, gamma)
% loss function on probability space gamma and discrete observation space
% omega

    delta = zeros(size(gamma));
    delta(omega) = 1;
    lambda = norm(gamma - delta, 1);     
end


