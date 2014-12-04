function [sparseX] = getSparseCombination(dict, dat, T)
   addpath OMP;
   
%    sparseX = zeros(size(dict, 2), size(dat, 2));
%    parfor i=1:size(dat, 2)
%        if(mod(i, 100) == 0) 
%            i
%        end
%        sparseX(:, i) = getSparseCombination1(dict, dat(:,i), T);
%    end
   tic
   sparseX = zeros(size(dict, 2), size(dat, 2));
   parfor i=1:size(dat, 2)
       if(mod(i, 100) == 0) 
           i
       end
       sparseX(:, i) = getSparseCombinationSingle(dict, dat(:,i), T);
   end
   toc
end