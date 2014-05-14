clear;
A=importdata('NEDERLANDS 2007-2008.csv');
A=importdata('NEDERLANDS 2007-2008.csv');
B=importdata('NEDERLANDS 2008-2009.csv');
C=importdata('NEDERLANDS 2009-2010.csv');
D=importdata('NEDERLANDS 2010-2011.csv');
E=importdata('NEDERLANDS 2011-2012.csv');
F=importdata('NEDERLANDS 2012-2013.csv');


%Split the struct in numeric matrices and text cellarrays
A_data=A.data;
B_data=B.data;
C_data=C.data;
D_data=D.data;
E_data=E.data;
F_data=F.data;
A_textdata=A.textdata;
B_textdata=B.textdata;
C_textdata=C.textdata;
D_textdata=D.textdata;
E_textdata=E.textdata;
F_textdata=F.textdata;

%Separate the result vector from the "datatext" field
Results_A=A_textdata(2:size(A_textdata, 1),7);
Results_B=B_textdata(2:size(B_textdata, 1),7);
Results_C=C_textdata(2:size(C_textdata, 1),7);
Results_D=D_textdata(2:size(D_textdata, 1),7);
Results_E=E_textdata(2:size(E_textdata, 1),7);
Results_F=F_textdata(2:size(F_textdata, 1),7);

%Merge the numerical matrices
NED_07_13_data= [A_data;B_data;C_data;D_data;E_data;F_data];
%Merge the string matrices
NED_07_13_results=[Results_A;Results_B;Results_C; Results_D; Results_E; Results_F];
%Selection of useful numbers in the numerical matrix
NED_07_13_odds = NED_07_13_data(:, 13:42);

%Associate a number to each result 
NED_07_13_numeric_results = zeros(size(NED_07_13_results, 1), size(NED_07_13_results, 2));
for i=1:size(NED_07_13_results, 1)

    if(NED_07_13_results{i, 1}== 'A')
        NED_07_13_numeric_results(i) = 2;
    else
        if(NED_07_13_results{i, 1}== 'D')
            NED_07_13_numeric_results(i) = 0;
        else
            NED_07_13_numeric_results(i) = 1;
        end
    end
end

%Merge everything together
NED_07_13_ready = [NED_07_13_odds, NED_07_13_numeric_results]; %put all together the odds and the results

%Save the final data-matrix and clear the workspace
% save('NED_07_13', 'NED_07_13_ready');

%GENERATE THE TWO USEFUL MATRICES GETTING RID OF ROWS CONTAINING "nan"
%ELEMENTS
%correct two mistaken columns column 19 and column 26
NED_07_13_ready(:, 19) = NED_07_13_ready(:, 19)*0.1;
NED_07_13_ready(:, 26) = NED_07_13_ready(:, 26)*0.1
[not_nan_vector, prob_mat_NED_07_13 ]= create_prob_mat(NED_07_13_ready);
save('prob_mat_NED_07_13', 'prob_mat_NED_07_13');
odd_mat_NED_07_13 = NED_07_13_ready(not_nan_vector, :);
save('odd_mat_NED_07_13', 'odd_mat_NED_07_13');

% clear;