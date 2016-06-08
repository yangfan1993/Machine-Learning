newX = X(:,2:7);
A = [newX, y];
result = [];
y_error = [];
for i = 1:1000
     seq = randperm(392);
     A_train = A(seq(1:372),:);
     T = array2table(A_train);
     lm = fitlm(T, 'A_train7~A_train1+A_train2+A_train3+A_train4+A_train5+A_train6');
     x_test = newX(seq(373:392),:);
     y_pred = predict(lm, x_test);
     y_test = y(seq(373:392));
     y_diff = y_pred-y_test;
     y_error = [y_error, y_diff];
     y_delta = (y_diff).^2;
     RMSE = sqrt(sum(y_delta)/20);
     result = [result, RMSE];
end
avg1 = mean(result);
devi1 = std(result);
histogram(y_error,20);
avg2 = mean2(y_error);
diva2 = std2(y_error);
norm = normpdf(y_error, avg2, diva2);
lognorm = log(norm);
MLE = sum(lognorm(:));