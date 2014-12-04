% Gets a sparse representation of dat using elements of dict. 
% Orthogonal matching algorithm
% Inputs:   dict: atoms in columns
%           dat: k data columns
%           T: max number of non-zero in sparseX

function [sparseX] = getSparseCombination1(dict, dat, T)
   % Assume that dict is normalized
   res = dat;
   dictdim = size(dict);
   indices = zeros(T, 1);
   sparseX = zeros(dictdim(2), 1);
   for i=1:T
       innerpdt = dict' * dat;
       [C, I] = max(abs(innerpdt));
       sparseX(I, 1) = innerpdt(I, 1);
       indices(i,1) = I;
       orth = orthogonalize(dict(:, indices(1:i, 1)));
       components = orth' * dat; % in a column
       projection = orth * components;
       res = dat - projection;
   end
   
end