[ predictions, loss , expert_loss, weights ] = weightedAvg( observations, expert_predictions, 1, @l2sq);
cum_loss = cumsum(loss);
cum_exp_loss = cumsum(expert_loss);

[best_loss, best_idx] = sort(cum_exp_loss, 2);

figure;

hold on;
plot(cum_loss - best_loss(:, 1), 'lineWidth', 2);
plot(cum_exp_loss - repmat(best_loss(:, 1),1, 10));
hold off;




