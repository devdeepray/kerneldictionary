data = [];
data = [data, randn(1, 100) * 3 + 5, randn(1, 300) * 6+1];
dict = trainDictionaryKernel(data, 4, 2);