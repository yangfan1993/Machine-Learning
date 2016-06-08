N1 = 943;
N2 = 1682;
K = 20;
L = 0;
c = zeros(N1,1);
% initilize the mu
r = randi([1, N1], 1, K);
mu = U(r, :);
time = 0;
while 1
    oldL = L;
    time = time+1;
    % to update the c
    for i=1:N1
        point = U(i, :);
        dist = [];
        for k=1:K
            dis = norm(point - mu(k, :));
            dist = [dist, dis];
        end
        [result, index] = sort(dist);
        c(i) = index(1);
    end
    % to update the mu
    mu = zeros(K, 10);
    n = zeros(K, 1);
    for i=1:N1
        cluster = c(i);
        n(cluster) = n(cluster) + 1;
        mu(cluster, :) = mu(cluster, :) + U(i, :); 
    end
    for i=1:10
        mu(:, i) = mu(:, i) ./ n;
    end
    % to calculate the L
    L = 0;
    for i=1:N1
        cluster = c(i);
        L = L + norm(U(i, :) - mu(cluster, :)).^2;
    end
    if (oldL == L)
        break;
    end
end
[result, index] = sort(-n);
top = index(1:5);
result = -result;
centroid = mu(top, :);
number = n(top, :);
matrix = [];
for i=1:N2
    column = [];
    for j=1:5
        dist = V(i, :) * centroid(j, :)';
        column = [column; dist];
    end
    matrix = [matrix, column];
end
distances = [];
ids = [];
for j=1:5
    [result, index] = sort(matrix(j, :));
    y = index(N2-9:N2);
    x = result(N2-9:N2);
    ids = [ids; y];
    distances = [distances; x];
end
names = movie_names(ids);