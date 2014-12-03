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
T = 5;
for iters = 1:10
    X = getSparseCombination(D, Y, T); % sparse coding step
    for k = 1:Kd
        Ek = Y - D(:,[1:k-1, k+1:Kd]) * X([1:k-1, k+1:Kd], :);
        xk = X(k, :); % row
        dk = D(:, k); % col
        wk = find(xk);
        if(size(wk, 2) == 0)
            continue;
        end
        Ekr = Ek(:, wk);
        xkr = xk(:, wk);
        [U,S,V] = svd(Ekr, 'econ');
        D(:,k) = U(:,1);
        X(k, wk) = S(1,1) * V(:,1)';
    end
end
