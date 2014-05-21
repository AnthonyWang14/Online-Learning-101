function lambda = l2th(omega, gamma)
% loss function on probability space gamma and discrete observation space
% omega

    delta = zeros(size(gamma));
    delta(omega) = 1;
    if gamma(ommega) > 0.8
        lambda = sum((gamma - delta).^2);
    else
        lambda = 0;
    end
end


