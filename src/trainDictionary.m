function [ dict ] = trainDictionary( Y, Kd, T, iters )
    if nargin < 4
        iters = 20;
    end
    
    Ky = size(Y, 2); % Number of training inputs
    
    [IDX, D] = kmeans(Y', Kd); % init dictionary
    D = normc(D);
    D = D';
    for i = 1:iters
        i
        X = getSparseCombination(D, Y, T); % sparse coding step
        for k = 1:Kd
            Ek = Y - D(:,[1:k-1, k+1:Kd]) * X([1:k-1, k+1:Kd], :);
            xk = X(k, :); % row
            wk = find(xk);
            if(size(wk, 2) == 0)
                continue;
            end
            Ekr = Ek(:, wk);
            [U,S,V] = svd(Ekr, 'econ');
            D(:,k) = U(:,1);
            X(k, wk) = S(1,1) * V(:,1)';
        end
    end
    dict = D;
end

