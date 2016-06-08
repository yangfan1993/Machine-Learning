T = 1000;
Xtest = X(:, 1:183);
Xtrain = X(:, 184:683);
ytrain = label(:, 184:683);
ytest = label(:, 1:183);
p = ones(1, 500);
p = p / 500;
alphat = [];
epsilont = [];
wt = [];
x = [];
testerrs = [];
trainerrs = [];
pt = [];
for t = 1:1000
    x = [x, t];
    psample = [p(100); p(200); p(300)];
    pt = [pt, psample];
    % part 1
    train = [Xtrain; ytrain];
    sample = Boostsample(500, p, train);
    Xsample = sample(1:10, :);
    ysample = sample(11, :);
    % part 2
    w = zeros(10, 1);
    for i = 1:500
        xi = Xsample(:, i);
        yi = ysample(:, i);
        sigma = 1/(1 + exp(-yi * xi' * w));
        w = w + 0.01 * (1-sigma) * yi * xi;
    end
    wt = [wt, w]; 
    % part 3
    f = (sign(Xtrain' * w))';
    match = p .* (ytrain .* f);
    epsilon = -sum(match(match < 0));
    alpha = 0.5 * log((1-epsilon)/epsilon);
    epsilont = [epsilont, epsilon];
    alphat = [alphat, alpha];
    % part 4
    temp = alpha * ytrain .* f; 
    p = p .* exp(-temp);
    % part 5
    sump = sum(p);
    p = p/sum(p);
    % calculate errors
    pred = sign(Xtest' * wt);
    for i = 1:183
        pred(i, :) = pred(i, :) .* alphat;
    end
    fboost = (sign(sum(pred, 2)))';
    testerr = sum((ytest .* fboost) < 0)/183;
    testerrs = [testerrs, testerr];
    pred = sign(Xtrain' * wt);
    for i = 1:500
        pred(i, :) = pred(i, :) .* alphat;
    end
    fboost = (sign(sum(pred, 2)))';
    trainerr = sum((ytrain .* fboost) < 0)/500;
    trainerrs = [trainerrs, trainerr];
end
plot(x, testerrs);
hold on;
plot(x, trainerrs);
%subplot(1,2,1);
%plot(x, alphat);
%subplot(1,2,2);
%plot(x, epsilont);
%plot(x, pt(1, :));
%hold on;
%plot(x, pt(2, :));
%hold on;
%plot(x, pt(3, :));