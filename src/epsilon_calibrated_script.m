clear all;

starting_match=1001;
load prob_mat_PL_07_13.mat;

weights=ones(1,(size(prob_mat_PL_07_13,2)-1)/3)/((size(prob_mat_PL_07_13,2)-1)/3);


bm_prob = prob_mat_PL_07_13(:, 1:size(prob_mat_PL_07_13, 2)-1); %take just the probabilities from the matrix and get rid of labels(= match result)
result_vector = zeros((size(prob_mat_PL_07_13, 1)-starting_match+1),6);
forcaster_loss=zeros((size(prob_mat_PL_07_13, 1)-starting_match+1),1);

tic;

for i=starting_match:size(prob_mat_PL_07_13,1)
   
    current_prediction=my_prob(weights,bm_prob(i,:));
    
    result_vector(i-starting_match+1,1:length(current_prediction))= current_prediction;
    
    %store result prediction
    [value, index]=max(current_prediction);
    if(index==1)%forecast home win
        result_vector(i-starting_match+1, length(current_prediction)+1) = 1;
    elseif(index==2)%forecast  draw
        result_vector(i-starting_match+1, length(current_prediction)+1) = 0;
    elseif(index==3)%forecast away win
        result_vector(i-starting_match+1, length(current_prediction)+1) = 2;
    else
        error('dimension of current prediction inconsistent');
    end
    
    %store fail/success
    if(result_vector(i-starting_match+1, length(current_prediction)+1)== prob_mat_PL_07_13(i, end)); %if the forecasted and actual result match
        result_vector(i-starting_match+1, length(current_prediction)+2) = 1; %good result
    else
        result_vector(i-starting_match+1, length(current_prediction)+2) = 0;
    end
    
    %result_vector(i-starting_match+1,end)=i;
    
    weights=epsilon_calibrated_weight_update(weights,bm_prob(i,:),i);
    
    forcaster_loss(i-starting_match+1)=forcaster_eps_calibrated_loss(result_vector(1:(i-starting_match+1),:));
    
end
figure;
plot(forcaster_loss);
figure;
plot(weights);
time_elapsed=toc;
disp(['Time elapsed:   ' num2str(time_elapsed)]);


