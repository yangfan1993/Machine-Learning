n = 500;
result = [];
for i=1:n
    temp = rand;
    if (temp <= 0.1)
        num = 1;
    end
    if (temp > 0.1 && temp <= 0.3)
        num = 2;
    end
    if (temp > 0.3 && temp <= 0.6)
        num = 3;
    end
    if (temp > 0.6 && temp <= 1.0)
        num = 4;
    end
    result = [result, num];
end
histogram(result);