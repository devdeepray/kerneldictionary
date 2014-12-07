function [sparseX] = getSparseCombination(dict, dat, T, nvar)
    if(nargin <4)
        nvar = 0;
    end
    
   sparseX = zeros(size(dict, 2), size(dat, 2));
   parfor i=1:size(dat, 2)
       if(mod(i, 1000) == 0) 
           i
       end
       sparseX(:, i) = getSparseCombinationSingle(dict, dat(:,i), T, nvar);
   end
end