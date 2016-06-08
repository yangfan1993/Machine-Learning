%temp = ones(1,5000);
%Xtrain = [Xtrain; temp];
%temp = ones(1,500);
%Xtest = [Xtest; temp];
%temp = ones(784,1);
%Q = [Q, temp];
C = zeros(10, 10);
w = zeros(21, 10);
count = 1;
predict = [];
truth = [];
distribute = [];
x = [];
y = [];
for k = 1:1000
    deltaw = [];
    for i = 1:10
        pul = Xtrain(:, 500*(i-1)+1 : 500*i);
        deltawi = sum(pul, 2);
        for m = 1:5000
            sig = 0;
            for j = 1:10
                sig = sig + exp(Xtrain(:, m)' * w(:, j));
            end
            per = exp(Xtrain(:, m)' * w(:, i)) / sig;
            deltawi = deltawi - Xtrain(:, m) * per;
        end
        deltaw = [deltaw, deltawi];
    end
    w = w + 0.1/5000 * deltaw;
    %L = 0;
    %for i = 1:10
    %    pul = Xtrain(:, 500*(i-1)+1 : 500*i);
    %    sumpul = sum(pul, 2);
    %    L = L + sumpul'* w(: , i);
    %end
    %for m = 1:5000
    %    sig = 0;
    %    for j = 1:10
    %        sig = sig + exp(Xtrain(:, m)' * w(:, j));
    %    end
    %    L = L - log(sig);
    %end
    %x = [x, k];
    %y = [y, L];
end
%plot(x, y);
for m = 1:500
    prob = [];
    for i = 1:10 
        sigma = 0;
        for j = 1:10
            sigma = sigma + exp(Xtest(:, m)' * w(:, j));
        end
        probi = exp(Xtest(:, m)' * w(:, i))/sigma;
        prob = [prob, probi];
    end
    [result, index] = sort(-prob);
    b = index(1)-1;
    a = floor((m-1)/50);
    C(a+1, b+1) = C(a+1, b+1) + 1;
    if (a ~= b)
        if (mod(count, 10) == 0 && count/10 <= 3)
        predict = [predict, b];
        truth = [truth, a];
        distribute = [distribute; prob];
        pic = Q * Xtest(:, m);
        subplot(1, 3, count/10);
        imagesc(reshape(pic, 28, 28)');
        end
        count = count +1;
    end
end
precision = trace(C)/500;