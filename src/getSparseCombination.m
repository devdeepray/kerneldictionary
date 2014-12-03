% Gets a sparse representation of dat using elements of dict. 
% Orthogonal matching algorithm
% Inputs:   dict: atoms in columns
%           dat: k data columns
%           T: max number of non-zero in sparseX

function [sparseX] = getSparseCombination(dict, dat, T)
   
   res = dat; % k columns, residue of each data
   dictdim = size(dict);
   indices = [];
   sparseX = zeros(dictdim(2),size(dat, 2));
   for i=1:T
       % Get inner products in a row
       innerpdt = dict' * dat; % inner pdt of one data is in a column. 
       % Get index of max inner product
       [C, I] = max(abs(innerpdt)); % max indices for each data, all in one row
       % Set coefficient in return vector
       sparseX(sub2ind(size(innerpdt), I, 1:length(I))) = ...
           innerpdt(sub2ind(size(innerpdt), I, 1:length(I)));
       %sparseX(I) = innerpdt(I); %%%%%% LEFT HERE
       % Add to set of indices
       indices = [indices; I];
       for j=1:size(dat, 2)
           % Orthogonalize the past chosen vector set
           orth = orthogonalize(dict(:, indices(:,j)'));
           % Get projection components
           components = sum(orth .* repmat(dat(:,j), 1, size(orth, 2)), 1);
           % Get projection
           proj = sum( orth .* repmat(components, size(orth, 1), 1), 2);
           % Get component outside subspace of chosen vectors
           res(:,j) = dat(:,j) - proj;
       end
   end
   
end