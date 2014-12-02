function [ orthVecs ] = orthogonalize( vecs )
%ORTHOGONALIZE Orthogonalization using gram schmidt
%   Orthogonalizes give set of vectors
    n_vecs = size(vecs, 2);
    vec_dim = size(vecs, 1);
    A = vecs;
    Q = zeros(vec_dim, n_vecs);
    R = zeros(n_vecs);
    for j=1:n_vecs
        v = vecs(:, j);
        for i=1:j-1
            R(i,j) = Q(:,i)' * A(:,j);
            v = v - R(i,j) * Q(:,i);
        end
        R(j,j) = norm(v);
        Q(:,j) = v / R(j,j);
    end
    orthVecs = Q;
end

