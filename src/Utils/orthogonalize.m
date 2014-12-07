function [ orthnew ] = orthogonalize( orth, new )
%ORTHOGONALIZE Orthogonalization using gram schmidt
%   Orthogonalizes give set of vectors
    if (size(orth, 2) == 0)
        orthnew = new;
        return;
    end
    
    orthnew = new - orth * (orth' * new);
    
    invnorm = 1/norm(orthnew);
    orthnew = invnorm * orthnew; % fast normalize
end

