C = zeros(10, 10);
count = 1;
predict = [];
truth = [];
for j = 1:500
    dis = [];
    for i = 1:5000
        dist = norm(Xtrain(:, i) - Xtest(:, j));
        dis = [dis, dist];
    end
    [result, index] = sort(dis);
    nearest = index(1:5);
    num = floor((nearest-1)/500);
    b = mode(num);
    a = floor((j-1)/50);
    C(a+1, b+1) = C(a+1, b+1) + 1;
    if (a ~= b)
        if (mod(count, 5) == 0 && count/5 <= 3)
        predict = [predict, b];
        truth = [truth, a];
        y = Q * Xtest(:, j);
        subplot(1, 3, count/5);
        imagesc(reshape(y, 28, 28)');
        end
        count = count +1;
    end
end
precision = trace(C)/500;