trainingData = [];
trainingData = [trainingData, getPatches('../data/test_images/barbara.png', 8);];
trainingData = [trainingData, getPatches('../data/test_images/fingerprint.png', 8);];
trainingData = [trainingData, getPatches('../data/test_images/house.png', 8);];
trainingData = [trainingData, getPatches('../data/test_images/lena.png', 8);];
trainingData = [trainingData, getPatches('../data/test_images/boat.png', 8);];
trainingData = trainingData(:,randi(size(trainingData, 2), 1, 10000));
dict = normc(trainDictionary(trainingData, 200,5, 10));
noisyImage = double(imread('../data/test_images/flinstones.png')) ...
                                + 20 * randn(512,512);
noisyImage(noisyImage<0)=0;
noisyImage(noisyImage>255)=255;
noisyPatches = getPatchesFromIm(noisyImage(1:512, 1:512), 8);            
combvectors = getSparseCombination(dict, noisyPatches, 1);
denoisedImage = dict * combvectors;
dnim = getImageFromPatches(denoisedImage,8,512,512);
nim = getImageFromPatches(noisyPatches,8,512,512);
figure(1);
imshow(nim, [0, 255]);
figure(2);
imshow(dnim, [0, 255]);

noisyImage = double(imread('../data/test_images/barbara.png')) ...
                                + 20 * randn(512,512);
noisyImage(noisyImage<0)=0;
noisyImage(noisyImage>255)=255;
noisyPatches = getPatchesFromIm(noisyImage(1:512, 1:512), 8);            
combvectors = getSparseCombination(dict, noisyPatches, 1);
denoisedImage = dict * combvectors;
dnim = getImageFromPatches(denoisedImage,8,512,512);
nim = getImageFromPatches(noisyPatches,8,512,512);
figure(3);
imshow(nim, [0, 255]);
figure(4);
imshow(dnim, [0, 255]);

noisyImage = double(imread('../data/test_images/boat.png')) ...
                                + 20 * randn(512,512);
noisyImage(noisyImage<0)=0;
noisyImage(noisyImage>255)=255;
noisyPatches = getPatchesFromIm(noisyImage(1:512, 1:512), 8);            
combvectors = getSparseCombination(dict, noisyPatches, 1);
denoisedImage = dict * combvectors;
dnim = getImageFromPatches(denoisedImage,8,512,512);
nim = getImageFromPatches(noisyPatches,8,512,512);
figure(5);
imshow(nim, [0, 255]);
figure(6);
imshow(dnim, [0, 255]);

noisyImage = double(imread('../data/test_images/lena.png')) ...
                                + 20 * randn(512,512);
noisyImage(noisyImage<0)=0;
noisyImage(noisyImage>255)=255;
noisyPatches = getPatchesFromIm(noisyImage(1:512, 1:512), 8);            
combvectors = getSparseCombination(dict, noisyPatches, 1);
denoisedImage = dict * combvectors;
dnim = getImageFromPatches(denoisedImage,8,512,512);
nim = getImageFromPatches(noisyPatches,8,512,512);
figure(7);
imshow(nim, [0, 255]);
figure(8);
imshow(dnim, [0, 255]);

noisyImage = double(imread('../data/test_images/house.png')) ...
                                + 20 * randn(256,256);
noisyImage(noisyImage<0)=0;
noisyImage(noisyImage>255)=255;
noisyPatches = getPatchesFromIm(noisyImage(1:256, 1:256), 8);            
combvectors = getSparseCombination(dict, noisyPatches, 1);
denoisedImage = dict * combvectors;
dnim = getImageFromPatches(denoisedImage,8,256,256);
nim = getImageFromPatches(noisyPatches,8,256,256);
figure(9);
imshow(nim, [0, 255]);
figure(10);
imshow(dnim, [0, 255]);