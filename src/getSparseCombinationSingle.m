% Gets a sparse representation of dat using elements of dict. 
% Orthogonal matching algorithm
% Inputs:   dict: atoms in columns
%           dat: k data columns
%           T: max number of non-zero in sparseX

function [sparseX] = getSparseCombinationSingle(dict, dat, T, nvar)
   % Assume that dict is normalized
   res = dat;
   dictdim = size(dict);
   indices = zeros(T, 1);
   sparseX = zeros(dictdim(2), 1);
   orth = zeros(dictdim(1), T);
   for i=1:T
       innerpdt = dict' * res;
       [C, I] = max(abs(innerpdt));
       indices(i,1) = I;
       orth(:, i) = orthogonalize(orth(:,1:i-1), dict(:,I));
       components = orth(:,1:i)' * dat; % in a column
       projection = orth(:,1:i) * components;
       res = dat - projection;
%        if(var(res) < nvar)
%            break;
%        end
   end
   indices = indices(indices>0);
   sparseX(indices) = dict(:,indices) \ dat;
   
end