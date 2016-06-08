X = zeros(3012, 8447);
small = 10^-16;
for i=1:8447
    times = Xcnt{i};
    id = Xid{i};
    for j=1:length(id)
        X(id(j), i) = times(j); 
    end
end
W = rand(3012, 25);
H = rand(25, 8447);
x = [];
y = [];
for t=1:200
    disp(t)
    A = W * H;
    for k=1:25 
        sum1 = 0;
        for i=1:3012
            sum1 = sum1 + W(i, k);
        end
        for j=1:8447
            sum2 = 0;
            for i=1:3012
                sum2 = sum2 + W(i,k) * X(i,j) / (A(i,j) + small);
            end
            H(k,j) = H(k,j) * sum2 / (sum1 + small);
        end
    end
    A = W * H;
    for k=1:25
        sum1 = 0;
        for j=1:8447
            sum1 = sum1 + H(k, j);
        end
        for i=1:3012
            sum2 = 0;
            for j=1:8447
                sum2 = sum2 + H(k,j) * X(i,j) / (A(i,j) + small);
            end
            W(i,k) = W(i,k) * sum2 / (sum1 + small);
        end
    end
    A = W * H;
    D = 0;
    for i=1:3012
        for j=1:8447
            D = D + X(i,j) * log(1/(A(i,j)+small)) + A(i,j);
        end
    end
    x = [x, t];
    y = [y, D];
end
plot(x,y);
for i=1:25
    temp = sum(W(:, i));
    W(:, i) = W(:, i)/temp;
end
result = [];
weight = [];
id = [];
for i=1:10
    col = W(:, i*2);
    [res, index] = sort(-col);
    weight = [weight, -res(1:10)];
    id = [id, index(1:10)];
    for j=1:10
        result = [result, nyt_vocab(index(j))];
    end
end
result = reshape(result, 10, 10);
    