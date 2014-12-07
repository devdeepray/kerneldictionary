function [ image ] = getImageFromPatches( patches, k, dim1v, dim2v )
    image = zeros(dim1v, dim2v);
    counter = 1;
    for dim1 = 1:dim1v-k+1
        for dim2 = 1:dim2v-k+1
            curpatch = reshape(patches(:, counter), k, k);
            image(dim1:dim1+k-1, dim2:dim2+k-1) = image(dim1:dim1+k-1, dim2:dim2+k-1) + curpatch;
            counter = counter + 1;
        end
        dim1
    end
    image = image / ((k)*(k));
end

