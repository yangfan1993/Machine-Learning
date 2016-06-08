Xtest = X(:, 1:183);
Xtrain = X(:, 184:683);
ytrain = label(:, 184:683);
ytest = label(:, 1:183);
w = zeros(10, 1);
for t = 1:1000
    delta = zeros(10, 1);
    for i = 1:500
        xi = Xtrain(:, i);
        yi = ytrain(:, i);
        sigma = 1/(1 + exp(-yi * xi' * w));
        delta = delta + (1-sigma) * yi * xi;
    end
    w = w + 0.01 * delta;
end
f = (sign(Xtest' * w))';
match = ytest .* f;
acc = sum(match > 0)/183;