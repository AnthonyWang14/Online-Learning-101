semantic_folder = '';
labeling_folder = '';
layout_folder = '';
ID = [32, 51, 116, 285, 159, 223];

for k = 1:length(ID)
layout = imread([layout_folder,'layout_',num2str(ID(k) ),'.png' ] );
labeling = imread([labeling_folder,'labeling_',num2str(ID(k) ), '.png'] );
semantic = imread([semantic_folder,'segPred_',num2str(ID(k) ),'.png' ] );
layout = layout(41:(end - 40),41:(end - 40),:);
labeling = labeling(41:(end - 40),41:(end - 40),:);
semantic = semantic(41:(end - 40),41:(end - 40),:);
full{k} = cat(2, layout, labeling, semantic);
end

allImage1 = cat(2, full{1}, full{2} );
allImage2 = cat(2, full{3}, full{4} );
allImage3 = cat(2, full{5}, full{6} );
allImage = cat(1, allImage1, allImage2, allImage3);

figure(1);
imshow(uint8(allImage) );
imwrite(allImage, 'qualitative_results.png','png');