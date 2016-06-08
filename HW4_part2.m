N1 = 943;
N2 = 1682;
mu = zeros(1,10);
sigma = eye(10)/10;
U = mvnrnd(mu, sigma, N1);
V = mvnrnd(mu, sigma, N2);
x = [];
RMSE = [];
Lt = [];
for k=1:100
    x = [x, k];
    for i=1:N1
        ridge = eye(10) * 0.25 * 10;
        sum1 = zeros(10, 10);
        sum2 = zeros(10, 1);
        ui = user(i).movie_id;
        for j=1:size(ui,2)
            id = ui(j);
            sum1 = sum1 + V(id, :)' * V(id, :);
            sum2 = sum2 + user(i).rating(j) * V(id, :)';
        end
        U(i, :) = ((ridge+sum1)\(sum2))';
    end
    for j=1:N2
        ridge = eye(10) * 0.25 * 10;
        sum1 = zeros(10, 10);
        sum2 = zeros(10, 1);
        vj = movie(j).user_id;
        for i=1:size(vj,2)
            id = vj(i);
            sum1 = sum1 + U(id, :)' * U(id, :);
            sum2 = sum2 + movie(j).rating(i) * U(id, :)';
        end
        V(j, :) = ((ridge+sum1)\(sum2))';
    end
    %error = 0;
    %for t=1:5000
    %    i = ratings_test(t,1);
    %    j = ratings_test(t,2);
    %    predict = round(U(i, :) * V(j, :)');
    %    error = error + (ratings_test(t, 3) - predict).^2;
    %end
    %error = sqrt(error/5000);
    %RMSE = [RMSE, error];
    %L = 0;
    %for i=1:N1
    %    L = L - 5 * norm(U(i, :)).^2;
    %end
    %for j=1:N2
    %    L = L - 5 * norm(V(j, :)).^2;
    %end
    %for i=1:N1
    %    ui = user(i).movie_id;
    %    for j=1:size(ui,2)
    %        id = ui(j);
    %        L = L - 2 * (user(i).rating(j) - U(i, :) * V(id, :)').^2;
    %    end
    %end
    %Lt = [Lt, L];
end
%plot(x(2:100), RMSE(2:100));
%plot(x(2:100), Lt(2:100));
famous = [439, 228, 29]; 
% 228 is Star Trek, 29 is Batman, 439 is Amityville
closest = [];
d = [];
for k=1:3
    id = famous(k);
    dis = [];
    for j=1:N2
        dist = norm(V(j, :) - V(id, :));
        dis = [dis, dist];
    end
    [result, index] = sort(dis);
    nearest = index(1:6);
    distance = dis(nearest);
    closest = [closest; nearest];
    d = [d; distance];
end