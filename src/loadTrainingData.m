% Load training data with samples in columns into variable called Y.
% Load data dimension into n and number of samples into Ky.

Y = zeros(32256, 39); 
for i=1:9
    tmp = imread(strcat('../data/CroppedYale_Subset/0', num2str(i),'/1.pgm'));
    Y(:, i) = tmp(:);
end
for i=10:39
    if(i == 14) continue;
    end
    tmp = imread(strcat('../data/CroppedYale_Subset/', num2str(i),'/1.pgm'));
    Y(:, i) = tmp(:);
end

n = 32256;
Ky = 39;
    