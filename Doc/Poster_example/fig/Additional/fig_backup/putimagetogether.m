semantic_folder = '';
labeling_folder = '';
layout_folder = '';
ID = [32, 51, 159, 116, 161, 249, 285, 93, 223, 253];

for k = 1:length(ID)
layout = imread([layout_folder,'layout_',num2str(ID(k) ),'.png' ] );
labeling = imread([labeling_folder,'labeling_',num2str(ID(k) ), '.png'] );
semantic = imread([semantic_folder,'segPred_',num2str(ID(k) ),'.png' ] );
layout = layout(41:(end - 40),41:(end - 40),:);
labeling = labeling(41:(end - 40),41:(end - 40),:);
semantic = semantic(41:(end - 40),41:(end - 40),:);
full{k} = cat(2, layout, labeling, semantic);
end

allImage1 = cat(2, full{1},255 * ones(size(full{2},1), 120, 3), full{2} );
allImage2 = cat(2, full{3},255 * ones(size(full{2},1), 120, 3), full{4} );
allImage3 = cat(2, full{5},255 * ones(size(full{2},1), 120, 3), full{6} );
allImage4 = cat(2, full{7},255 * ones(size(full{2},1), 120, 3), full{8} );
allImage5 = cat(2, full{9},255 * ones(size(full{2},1), 120, 3), full{10} );
allImage = cat(1, allImage1, 255 * ones(60, size(allImage1, 2), 3),...
                  allImage2, 255 * ones(60, size(allImage1, 2), 3),...
                  allImage3, 255 * ones(60, size(allImage1, 2), 3),...
                  allImage4, 255 * ones(60, size(allImage1, 2), 3),...
                  allImage5);

figure(1);
imshow(uint8(allImage) );
imwrite(allImage, 'qualitative_results10.png','png');