Xtest = X(:, 1:183);
Xtrain = X(:, 184:683);
ytrain = label(:, 184:683);
ytest = label(:, 1:183);
Xeffect = Xtrain(2:10, :);
Xpositive = [];
Xnegative = [];
for i = 1:500
    if (ytrain(i)>0) 
        Xpositive = [Xpositive, Xeffect(:, i)];
    else Xnegative = [Xnegative, Xeffect(:, i)];
    end
end
mu1 = mean(Xpositive, 2);
mu0 = mean(Xnegative, 2);
pi1 = sum(ytrain > 0);
pi0 = sum(ytrain < 0);
sigma = cov(Xeffect');
w0 = log(pi1 / pi0) - 0.5*((mu1+mu0)' / sigma) *(mu1-mu0);
w = sigma \ (mu1 - mu0);
w = [w0; w];
f = (sign(Xtest' * w))';
match = ytest .* f;
acc = sum(match > 0)/183;