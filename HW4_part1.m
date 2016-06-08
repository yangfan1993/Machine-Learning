mu1 = [0;0];
mu2 = [3;0];
mu3 = [0;3];
sigma = [1,0;0,1];
num1 = 0;
num2 = 0;
num3 = 0;
% random generate according to distribution
for i=1:500
    temp = rand;
    if (temp <= 0.2)
        num1 = num1+1;
    end
    if (temp > 0.2 && temp <= 0.7)
        num2 = num2+1;
    end
    if (temp > 0.7 && temp <= 1.0)
        num3 = num3+1;
    end
end
obser1 = mvnrnd(mu1, sigma, num1);
obser2 = mvnrnd(mu2, sigma, num2);
obser3 = mvnrnd(mu3, sigma, num3);
obser = [obser1; obser2; obser3];
K = 3;
t = [];
Lt = [];
c = zeros(500,1);
mu = zeros(K, 2);
% initilize the mu
for i=1:K
    x = rand * 3;
    y = rand * 1.8;
    mu(i, 1) = x;
    mu(i, 2) = y;
end
for i=1:20
    t = [t, i-0.5];
    t = [t, i];
    % to update the c
    for j=1:500
        point = obser(j, :);
        dist = [];
        for k=1:K
            dis = norm(point - mu(k, :));
            dist = [dist, dis];
        end
        [result, index] = sort(dist);
        c(j) = index(1);
    end
    % to calculate the L
    L = 0;
    for j=1:500
        cluster = c(j);
        L = L + norm(obser(j, :) - mu(cluster, :)).^2;
    end
    Lt = [Lt, L];
    % to update the mu
    mu = zeros(K, 2);
    n = zeros(K, 1);
    for j=1:500
        cluster = c(j);
        n(cluster) = n(cluster) + 1;
        mu(cluster, :) = mu(cluster, :) + obser(j, :); 
    end
    mu(:, 1) = mu(:, 1) ./ n;
    mu(:, 2) = mu(:, 2) ./ n;
    % to calculate the L
    L = 0;
    for j=1:500
        cluster = c(j);
        L = L + norm(obser(j, :) - mu(cluster, :)).^2;
    end
    Lt = [Lt, L];
end
plot(t, Lt);
%for j=1:500
%    if (c(j) == 1)
%        plot(obser(j, 1), obser(j,2), 'r+');
%    end
%    if (c(j) == 2)
%        plot(obser(j, 1), obser(j,2), 'yo');
%    end
%    if (c(j) == 3)
%        plot(obser(j, 1), obser(j,2), 'b.');
%    end
%    if (c(j) == 4)
%        plot(obser(j, 1), obser(j,2), 'g*');
%    end
%    if (c(j) == 5)
%        plot(obser(j, 1), obser(j,2), 'kx');
%    end
%    hold on;
%end