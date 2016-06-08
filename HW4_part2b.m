N1 = 943;
N2 = 1682;
K = 20;
L = 0;
c = zeros(N2,1);
% initilize the mu
r = randi([1, N2], 1, K);
mu = V(r, :);
time = 0;
while 1
    oldL = L;
    time = time+1;
    % to update the c
    for j=1:N2
        point = V(j, :);
        dist = [];
        for k=1:K
            dis = norm(point - mu(k, :));
            dist = [dist, dis];
        end
        [result, index] = sort(dist);
        c(j) = index(1);
    end
    % to update the mu
    mu = zeros(K, 10);
    n = zeros(K, 1);
    for j=1:N2
        cluster = c(j);
        n(cluster) = n(cluster) + 1;
        mu(cluster, :) = mu(cluster, :) + V(j, :); 
    end
    for j=1:10
        mu(:, j) = mu(:, j) ./ n;
    end
    % to calculate the L
    L = 0;
    for j=1:N2
        cluster = c(j);
        L = L + norm(V(j, :) - mu(cluster, :)).^2;
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
        dist = norm(V(i, :) - centroid(j, :));
        column = [column; dist];
    end
    matrix = [matrix, column];
end
distances = [];
ids = [];
for j=1:5
    [result, index] = sort(matrix(j, :));
    y = index(1:10);
    x = result(1:10);
    ids = [ids; y];
    distances = [distances; x];
end
names = movie_names(ids);