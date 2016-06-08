W = rand(1024, 25);
H = rand(25, 1000);
x = [];
y = [];
for i=1:200
    A = (W' * X);
    B = (W' * W * H);
    for k=1:25
        for j=1:1000
            H(k,j) = H(k,j) * A(k,j) / B(k,j);
        end
    end
    A = (X * H');
    B = (W * (H * H'));
    for j=1:1024
        for k=1:25
            W(j,k) = W(j,k) * A(j,k) / B(j,k);
        end
    end
    L = 0;
    Y = W*H;
    for j=1:1024
        for k=1:1000
            L = L + (X(j,k) - Y(j, k)).^2;
        end
    end
    x = [x, i];
    y = [y, L];
end
%plot(x,y);
for i=1:10
    if i<=5
        subplot(4, 5, i);
    else subplot(4, 5, 5+i);
    end
    imagesc(reshape(W(:,i*2),32,32));
    if i<=5
        subplot(4, 5, i+5);
    else subplot(4, 5, i+10);
    end
    h = H(i*2, :);
    [res, index] = sort(-h);
    imagesc(reshape(X(:,index(1)),32,32));
end