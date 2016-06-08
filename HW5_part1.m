M = zeros(759, 759);
for i=1:4185
    match = scores(i, :);
    j1 = match(1);
    p1 = match(2);
    j2 = match(3);
    p2 = match(4);
    M(j1, j1) = M(j1, j1) + (p1>p2) + p1/(p1+p2);
    M(j2, j2) = M(j2, j2) + (p2>p1) + p2/(p1+p2);
    M(j1, j2) = M(j1, j2) + (p2>p1) + p2/(p1+p2);
    M(j2, j1) = M(j2, j1) + (p1>p2) + p1/(p1+p2);
end
for i=1:759
    s = sum(M(i, :));
    M(i, :) = M(i, :)/s;
end
%[V, D] = eigs(M', 1);
%winf = V(:, 1);
[V, D] = eig(M');
eigvalue = [];
for i=1:759
    eigvalue = [eigvalue, D(i,i)];
end
[res, id] = sort(eigvalue);
winf = V(:, id(759));
s = sum(winf);
winf = winf'/s;
w = ones(1, 759)/759;
t = 2500;
y = [];
x = [];
for i=1:t
    x = [x, i];
    w = w * M;
    y = [y, norm(w-winf,1)];
end
[result, index] = sort(-w);
result = -result;
names = legend(index(1:25));
plot(x, y);