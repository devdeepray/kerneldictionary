% Gets a sparse representation of dat using elements of dict. 
% Orthogonal matching algorithm
% Inputs:   dict: atoms in columns
%           dat: k data columns
%           T: max number of non-zero in sparseX

function [sparseX] = getSparseCombinationKernelSingle(Y, A, T, Kzy, Kyy)
   % Assume that dict is normalized
   zest = zeros(size(Kyy, 1), 1);
   indices = [];
   KzyA = Kzy * A;
   KyyA = Kyy * A;
   for i=1:T
       % For all vectors ai, compute the residual products
       tau = KzyA - zest' * KyyA;
       [~, Imax] = max(abs(tau));
       indices = [indices, Imax]
       Ai = A(:, indices);
       xs = inv(Ai' * Kyy * Ai) * (Kzy * Ai)';
       zest = Ai * xs;
   end
   sparseX = zeros(size(A, 2), 1);
   sparseX(indices) = xs;
end