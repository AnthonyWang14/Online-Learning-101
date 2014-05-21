function [odd_all, margin_all] = getMargin( odd_mat )
%GETMARGIN Summary of this function goes here
%   Detailed explanation goes here

odd_mat = odd_mat(:, 1:30);
ob_dim = 3;

margin = zeros(size(odd_mat, 1), 10);

for i = 1:10
    margin(:, i) = (1 ./ odd_mat(:, ((i-1)*ob_dim+1)) + 1 ./ odd_mat(:, ((i-1)*ob_dim+2)) + 1 ./ odd_mat(:, ((i-1)*ob_dim+3))) - 1;     
end

odd_all = odd_mat(:);
margin_all = margin(:);

figure;
[n, xout] = hist(odd_all);
bar(xout,n/sum(n), 1);
alpha(0.5);
figure;
[n, xout] = hist(margin_all , 20);
bar(xout,n/sum(n), 1);
end

