% KSVD algorithm to find a dictionary based sparse representation of
% data.

% Training phase
% Inputs:
% Dictionary initialization D: n x Kd, n is data dimension, Kd is number of
% atoms.
% Data to be represented Y: n x Ky, n is data dimensionm Ky is number of
% data samples to be used to train the dictionary. 

% Load the data samples for training
loadTrainingData;

% Initialize the dictionary with a random subset
Kd = 10;
D = Y(:, randi(Ky, 1, Kd));

for iters = 1:10
    
end