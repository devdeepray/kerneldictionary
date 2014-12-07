function [ patches ] = getDisjointPatchesFromIm( image, k , dfac)
% Reads file fname and gets kxk patches from it
    imdim = size(image);
    patches = zeros(k * k, size(1:dfac:imdim(1)-k+1, 2) * size(1:dfac:imdim(2)-k+1, 2));
    counter = 1;
    for dim1 = 1:dfac:imdim(1)-k+1
        for dim2 = 1:dfac:imdim(2)-k+1
            curpatch = image(dim1:dim1+k-1, dim2:dim2+k-1);
            patches(:, counter) = curpatch(:);
            counter = counter + 1;
        end
    end
end
