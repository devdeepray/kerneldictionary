traininglabels = loadMNISTLabels('../data/recognition/train-labels.idx1-ubyte');
trainingimages = loadMNISTImages('../data/recognition/train-images.idx3-ubyte');

% Prepare training patches. 0 mean 
trainingimages = trainingimages - repmat(mean(trainingimages), size(trainingimages, 1), 1);

varianceimages = var(trainingimages);
% Make patches with unit variance
trainingimages = trainingimages ./ repmat(sqrt(varianceimages), size(trainingimages, 1), 1);

testlabels = loadMNISTLabels('../data/recognition/t10k-labels.idx1-ubyte');
testimages = loadMNISTImages('../data/recognition/t10k-images.idx3-ubyte');

testimages = testimages - repmat(mean(testimages), size(testimages, 1), 1);

variancetest = var(testimages);
% Make patches with unit variance
testimages = testimages ./ repmat(sqrt(variancetest), size(testimages, 1), 1);


% Parameters
recSp = 5; % sparsity
dictSize = 50;




dictionary = trainDictionary(trainingimages, dictSize, recSp, 10);
trainSpComb = getSparseCombination(dictionary, trainingimages, recSp);
testSpComb = getSparseCombination(dictionary, testimages, recSp);

pos = knnsearch(trainSpComb', testSpComb', 'K', 10);
ids = traininglabels(pos);
fids = mode(ids')';







