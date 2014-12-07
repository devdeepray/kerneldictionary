% Noise removal demo using sparse dictionaries

% Load noise-image to train dictionary

origImage = double(imread('../data/test_images/flinstones.png'));

% Parameters
percNoise = 10; % Noise percentage
recSp = 3; % sparsity
kVar = 2; % Variance threshold as multiple of noise for training
patchSize = 8;
patchSpace = 2;
dictSize = 512;

% Generate artificial noisy image
imRange = max(max(origImage)) - min(min(origImage));
nVar = (percNoise * 0.01 * imRange)^2;
noisyImage = origImage + sqrt(nVar) * randn(size(origImage));


trainingPatches = getDisjointPatchesFromIm(noisyImage, patchSize, patchSpace);
noisyPatches = getPatchesFromIm(noisyImage, patchSize);

% Prepare training patches. 0 mean and patches with max variance. 
trainingPatches = trainingPatches - repmat(mean(trainingPatches), size(trainingPatches, 1), 1);
varianceOfPatches = var(trainingPatches);
[sortedVar, perm] = sort(varianceOfPatches, 'descend');
% Plot variance
figure(1);
plot(sortedVar);

% Make patches with unit variance
trainingPatches = trainingPatches ./ repmat(sqrt(varianceOfPatches), size(trainingPatches, 1), 1);
% Choose subset with max variance
%trainingPatches = trainingPatches(:, perm(:, 1:100000));
if(size(varianceOfPatches(varianceOfPatches>kVar*nVar), 2) > dictSize)
    trainingPatches = trainingPatches(:, varianceOfPatches > kVar * nVar);
else
    trainingPatches = trainingPatches(:, perm(:, 1:dictSize));
end


% Train dictionary with top variance patches
dictionary = trainDictionary(trainingPatches, dictSize, recSp, 10);

dictionary = [dictionary, normc(ones(size(dictionary(:,1))))];

combvectors = getSparseCombination(dictionary, noisyPatches, recSp, nVar);
denoisedImage = dictionary * combvectors;

dnim = getImageFromPatches(denoisedImage, patchSize, size(origImage, 1), size(origImage, 2));
nim = getImageFromPatches(noisyPatches, patchSize, size(origImage, 1), size(origImage, 2));

figure(1);
imshow(nim, [0, 255]);
figure(2);
imshow(dnim, [0, 255]);





% 
% 
% 
% 
% 
% 
% % Load training data. patch size: 8x8
% trainingData = [];
% trainingData = [trainingData, getPatches('../data/test_images/barbara.png', 8);];
% trainingData = [trainingData, getPatches('../data/test_images/fingerprint.png', 8);];
% trainingData = [trainingData, getPatches('../data/test_images/house.png', 8);];
% trainingData = [trainingData, getPatches('../data/test_images/lena.png', 8);];
% trainingData = [trainingData, getPatches('../data/test_images/boat.png', 8);];
% 
% % Get variance of patches.
% varianceOfData = var(trainingData);
% [sortedVar, perm] = sort(varianceOfData, 'descend');
% trainingData = trainingData(:, perm(:, 1:100000));
% 
% dict = normc(trainDictionary(trainingData, 256,3, 10));
% 
% recSp = 5;
% nSc = 10;
% noisyImage = double(imread('../data/test_images/flinstones.png')) ...
%                                 + nSc * randn(512,512);
% noisyImage(noisyImage<0)=0;
% noisyImage(noisyImage>255)=255;
% noisyPatches = getPatchesFromIm(noisyImage(1:512, 1:512), 8);            
% combvectors = getSparseCombination(dict, noisyPatches, recSp);
% denoisedImage = dict * combvectors;
% dnim = getImageFromPatches(denoisedImage,8,512,512);
% nim = getImageFromPatches(noisyPatches,8,512,512);
% figure(1);
% imshow(nim, [0, 255]);
% figure(2);
% imshow(dnim, [0, 255]);
% 
% noisyImage = double(imread('../data/test_images/barbara.png')) ...
%                                 + nSc * randn(512,512);
% noisyImage(noisyImage<0)=0;
% noisyImage(noisyImage>255)=255;
% noisyPatches = getPatchesFromIm(noisyImage(1:512, 1:512), 8);            
% combvectors = getSparseCombination(dict, noisyPatches, recSp);
% denoisedImage = dict * combvectors;
% dnim = getImageFromPatches(denoisedImage,8,512,512);
% nim = getImageFromPatches(noisyPatches,8,512,512);
% figure(3);
% imshow(nim, [0, 255]);
% figure(4);
% imshow(dnim, [0, 255]);
% 
% noisyImage = double(imread('../data/test_images/boat.png')) ...
%                                 + nSc * randn(512,512);
% noisyImage(noisyImage<0)=0;
% noisyImage(noisyImage>255)=255;
% noisyPatches = getPatchesFromIm(noisyImage(1:512, 1:512), 8);            
% combvectors = getSparseCombination(dict, noisyPatches, recSp);
% denoisedImage = dict * combvectors;
% dnim = getImageFromPatches(denoisedImage,8,512,512);
% nim = getImageFromPatches(noisyPatches,8,512,512);
% figure(5);
% imshow(nim, [0, 255]);
% figure(6);
% imshow(dnim, [0, 255]);
% 
% noisyImage = double(imread('../data/test_images/lena.png')) ...
%                                 + nSc * randn(512,512);
% noisyImage(noisyImage<0)=0;
% noisyImage(noisyImage>255)=255;
% noisyPatches = getPatchesFromIm(noisyImage(1:512, 1:512), 8);            
% combvectors = getSparseCombination(dict, noisyPatches, recSp);
% denoisedImage = dict * combvectors;
% dnim = getImageFromPatches(denoisedImage,8,512,512);
% nim = getImageFromPatches(noisyPatches,8,512,512);
% figure(7);
% imshow(nim, [0, 255]);
% figure(8);
% imshow(dnim, [0, 255]);
% 
% noisyImage = double(imread('../data/test_images/house.png')) ...
%                                 + nSc * randn(256,256);
% noisyImage(noisyImage<0)=0;
% noisyImage(noisyImage>255)=255;
% noisyPatches = getPatchesFromIm(noisyImage(1:256, 1:256), 8);            
% combvectors = getSparseCombination(dict, noisyPatches, recSp);
% denoisedImage = dict * combvectors;
% dnim = getImageFromPatches(denoisedImage,8,256,256);
% nim = getImageFromPatches(noisyPatches,8,256,256);
% figure(9);
% imshow(nim, [0, 255]);
% figure(10);
% imshow(dnim, [0, 255]);
% 
% 
% noisyImage = double(imread('../data/test_images/house.png'));
% noisyImage(1:2:256, 1:2:256) = 0;
% noisyImage(noisyImage<0)=0;
% noisyImage(noisyImage>255)=255;
% noisyPatches = getPatchesFromIm(noisyImage(1:256, 1:256), 8);            
% combvectors = getSparseCombination(dict, noisyPatches, recSp);
% denoisedImage = dict * combvectors;
% dnim = getImageFromPatches(denoisedImage,8,256,256);
% nim = getImageFromPatches(noisyPatches,8,256,256);
% figure(11);
% imshow(nim, [0, 255]);
% figure(12);
% imshow(dnim, [0, 255]);