% Gets a sparse representation of dat using elements of dict. 
% Orthogonal matching algorithm
% Inputs:   dict: atoms in columns
%           dat: one column
%           T: max number of non-zero in sparseX

function [sparseX] = getSparseCombination(dict, dat, T)
   res = dat;
   dictdim = size(dict);
   indices = [];
   sparseX = zeros(dictdim(2),1 );
   for i=1:T
       % Get inner products in a row
       innerpdt = sum(dict .* repmat(res,1,dictdim(2)), 1);
       % Get index of max inner product
       [C, I] = max(abs(innerpdt));
       % Set coefficient in return vector
       sparseX(I) = innerpdt(I);
       % Add to set of indices
       indices = [indices, I];
       % Orthogonalize the past chosen vector set
       orth = orthogonalize(dict(:, indices));
       % Get projection components
       components = sum(orth .* repmat(dat, 1, size(orth, 2)), 1);
       % Get projection
       proj = sum( orth .* repmat(components, size(orth, 1), 1), 2);
       % Get component outside subspace of chosen vectors
       res = dat - proj;
   end
end