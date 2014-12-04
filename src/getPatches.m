function [ patches ] = getPatches( fname, k )
% Reads file fname and gets kxk patches from it
    image = double(imread(fname));
    imdim = size(image);
    patches = zeros(k * k, (imdim(1)-k+1) * (imdim(2)-k+1));
    counter = 1;
    for dim1 = 1:imdim(1)-k+1
        for dim2 = 1:imdim(2)-k+1
            curpatch = image(dim1:dim1+k-1, dim2:dim2+k-1);
            patches(:, counter) = curpatch(:);
            counter = counter + 1;
        end
    end
end

