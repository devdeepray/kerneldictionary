function [ dict ] = trainDictionary( Y, Kd, T, iters )
    if nargin < 4
        iters = 20;
    end
    
    Ky = size(Y, 2); % Number of training inputs
    
    [IDX, D] = kmeans(Y', Kd, 'Display','iter', 'MaxIter', 10); % init dictionary
    %D = Y(:, 1:Kd)';
    D = D';
    D = normc(D); % slow, but only once penalty
    oln = 0;
    for i = 1:iters
        i
        X = getSparseCombination(D, Y, T); % sparse coding step
        Ek = Y - D * X;
        
        for k = 1:Kd
            %Ek = Y - D(:,[1:k-1, k+1:Kd]) * X([1:k-1, k+1:Kd], :);
            k
            Ek = Ek + D(:, k) * X(k,:);
            xk = X(k, :); % row
            wk = find(xk);
            if(size(wk, 2) == 0)
                continue;
            end
            Ekr = Ek(:, wk);
            tic
            [U,S,V] = svd(Ekr,'econ');
            toc
            D(:,k) = U(:,1);
            X(k, wk) = S(1,1) * V(:,1)';
            tic
            tk = D(:,k) * X(k, :);
            toc
            Ek = Ek - tk;
        end
        delnorm = oln - norm(Ek)
        oln = norm(Ek)
    end
    dict = normc(D);
end

