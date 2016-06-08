function y = Boostsample(n, w, data)
    y = [];
    for i = 1:n
        temp = rand;
        down = 0;
        up = w(1);
        for j = 1:length(w)
            if (temp <= up && temp >= down)
                y = [y, data(:, j)];
                break;
            end
            down = down + w(j);
            up = up + w(j+1);
        end
    end
end