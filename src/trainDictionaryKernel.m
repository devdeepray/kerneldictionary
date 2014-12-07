function [ dict ] = trainDictionaryKernel( Y, Kd, T, Kernel, iters )
    if (nargin < 4)
        iters = 20;
        Kernel = @(x,y){x' * y};
    end
    Ky = size(Y, 2); % Number of training inputs
    
    [~, D] = kmeans(Y', Kd); % init dictionary
    D = D';
    D = normc(D);
    A = D \ Y;
    
    
    
%     for i = 1:iters
%         i
%         X = getSparseCombination(D, Y, T); % sparse coding step
%         for k = 1:Kd
%             Ek = Y - D(:,[1:k-1, k+1:Kd]) * X([1:k-1, k+1:Kd], :);
%             xk = X(k, :); % row
%             wk = find(xk);
%             if(size(wk, 2) == 0)
%                 continue;
%             end
%             Ekr = Ek(:, wk);
%             QTQ = Ekr' * Kernel(Y, Y)
%             [U,S,V] = svd(Ekr, 'econ');
%             D(:,k) = U(:,1);
%             X(k, wk) = S(1,1) * V(:,1)';
%         end
%     end
%     dict = D;
end

