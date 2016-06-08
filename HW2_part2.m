C = zeros(10, 10);
tavg = [];
tcov = [];
count = 1;
predict = [];
truth = [];
for i = 1:10
    X = Xtrain( : , 500*(i-1)+1 : 500*i);
    mu = mean(X,2);
    tavg = [tavg, mu];
    y = Q * mu;
    %subplot(2, 5, i);
    %imagesc(reshape(y, 28, 28)');
    sigma = cov(X');
    tcov = [tcov, sigma];
end
for i = 1:500
    point = Xtest(:, i);
    dens = [];
    for j = 1:10
        mu = tavg(:, j);
        sigma = tcov(:, 20*(j-1)+1 : 20*j);
        norm = mvnpdf(point, mu, sigma);
        dens = [dens, norm * 0.1];
    end
    [result, index] = sort(-dens);
    b = index(1)-1;
    a = floor((i-1)/50);
    C(a+1, b+1) = C(a+1, b+1) + 1;
    if (a ~= b)
        if (mod(count, 6) == 0 && count/6 <= 3)
        predict = [predict, b];
        truth = [truth, a];
        y = Q * Xtest(:, i);
        subplot(1, 3, count/6);
        imagesc(reshape(y, 28, 28)');
        end
        count = count +1;
    end
end
precision = trace(C)/500;