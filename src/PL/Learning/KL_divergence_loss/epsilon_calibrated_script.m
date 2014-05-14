clear all;
for epsilon=0.01:0.01:0.1
clearvars -except epsilon
    
starting_match=1;    %da discutere!!!!
load prob_mat_PL_07_13.mat;

weights=ones(1,(size(prob_mat_PL_07_13,2)-1)/3)/((size(prob_mat_PL_07_13,2)-1)/3);   %initialize a uniform distribution of the weights!!!


bm_prob = prob_mat_PL_07_13(:, 1:size(prob_mat_PL_07_13, 2)-1); %take just the probabilities from the matrix and get rid of labels(= match result)

result_vector = zeros((size(prob_mat_PL_07_13, 1)-starting_match+1),6); 

forcaster_loss=zeros((size(prob_mat_PL_07_13, 1)-starting_match+1),1);

bm_loss=zeros((size(prob_mat_PL_07_13, 1)-starting_match+1),10);

avg_bm_loss=zeros(size(bm_loss,1)/10,10);

weights_records=zeros((size(prob_mat_PL_07_13, 1)-starting_match+1),10);

calibration_err=zeros((size(prob_mat_PL_07_13, 1)-starting_match+1), 3);

tic;

for i=starting_match: size(prob_mat_PL_07_13, 1)
    
    weights_records(i-starting_match+1,:)=weights;
   
    current_prediction = my_prob(weights, bm_prob(i,:));
    
    result_vector(i-starting_match+1, 1:length(current_prediction))= current_prediction;
    
    result_vector(i-starting_match+1, length(current_prediction)+1)= prob_mat_PL_07_13(i, end);  %column 4 = "Actual match outcome" column
    
    %store result prediction
    [value, index]=max(current_prediction);
    if(index==1)%forecast home win
        result_vector(i-starting_match+1, length(current_prediction)+2) = 1;
    elseif(index==2)%forecast  draw
        result_vector(i-starting_match+1, length(current_prediction)+2) = 0;
    elseif(index==3)%forecast away win
        result_vector(i-starting_match+1, length(current_prediction)+2) = 2;
    else
        error('dimension of current prediction inconsistent');
    end
    
    %store fail/success
    if(result_vector(i-starting_match+1, length(current_prediction)+2)== prob_mat_PL_07_13(i, end)); %if the forecasted and actual result match
        result_vector(i-starting_match+1, length(current_prediction)+3) = 1; %good result
    else
        result_vector(i-starting_match+1, length(current_prediction)+3) = 0;
    end
    
    
    [weights, bm_loss(i-starting_match+1,:)] = epsilon_calibrated_weight_update(weights, bm_prob(i,:), i, 1/sqrt(i-starting_match+1), epsilon);
    
    [forcaster_loss(i-starting_match+1), calibration_err(i-starting_match+1, :)]=forcaster_eps_calibrated_loss(result_vector(1:(i-starting_match+1),:), epsilon);
     
    
%     if i-starting_match+1==1
%         bm_cumulative_loss(i-starting_match+1,:)=bm_loss(i-starting_match+1);
%         forcaster_cumulative_loss(i-starting_match+1)=forcaster_loss(i-starting_match+1);
%     else
%         bm_cumulative_loss(i-starting_match+1,:)=bm_loss(i-starting_match+1,:)+bm_cumulative_loss(i-starting_match,:);
%         forcaster_cumulative_loss(i-starting_match+1)=forcaster_loss(i-starting_match+1)+forcaster_cumulative_loss(i-starting_match);
%     end
    
    bm_cumulative_loss=cumsum(bm_loss);
    forcaster_cumulative_loss=cumsum(forcaster_loss);
end

plot(bm_cumulative_loss-repmat(forcaster_cumulative_loss, 1, 10))
hold on
plot(zeros(size(forcaster_cumulative_loss)), '--')
%averages every 10 points the forcaster loss to smooth
tmp=reshape(forcaster_loss,10,length(forcaster_loss)/10);
avg_forcaster_loss=mean(tmp);

for i=1:size(bm_loss,2) 
    tmp=reshape(bm_loss(:,i),10,size(bm_loss,1)/10);
    avg_bm_loss(:,i)=mean(tmp);
    
end

time_elapsed=toc;
disp(['Time elapsed:   ' num2str(time_elapsed)]);
fname = sprintf('script_KLdivergence_eps%d.mat', epsilon*100);
save(fname);
figure;
end

