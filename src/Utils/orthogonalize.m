function [ orthnew ] = orthogonalize( orth, new )
%ORTHOGONALIZE Orthogonalization using gram schmidt
%   Orthogonalizes give set of vectors
    if (size(orth, 2) == 0)
        orthnew = normc(new);
        return;
    end
    orth = normc(orth);
    dotpdts = orth' * new;
    subval = orth * dotpdts;
    orthnew = normc(new - subval);
end

