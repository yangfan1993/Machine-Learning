newX = X(:,2:7);
A = [newX, y];
result = [];
for i = 1:1000
     seq = randperm(392);
     A_train = A(seq(1:372),:);
     T = array2table(A_train);
     lm = fitlm(T, 'A_train7~A_train1+A_train2+A_train3+A_train4+A_train5+A_train6');
     x_test = newX(seq(373:392),:);
     y_pred = predict(lm, x_test);
     y_test = y(seq(373:392));
     y_delta = abs(y_pred-y_test);
     MAE = sum(y_delta)/20;
     result = [result, MAE];
end
avg = mean(result);
devi = std(result);