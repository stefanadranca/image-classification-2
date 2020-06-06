function [w] = learn(X, y, lr, epochs)
  [n m] = size (X);
  ##scalarea
  for i = 1:m
    X(:, i) = (X(:, i) - mean (X(:, i))) / std (X(:, i));
  endfor
  Xp = X;
  Xp(:, m + 1) = 1; #coloana de 1
  w = ((-0.1) + (0.2) * rand (m + 1, 1));
  Xbatch = zeros (64, m + 1);
  ybatch = zeros (64, 1);
  for epoch = 1:epochs
    lines = randi (n, 1, 64); #alegerea celor 64 de linii random
    Xbatch(1:64, :) = Xp(lines(:), :);
    ybatch = y(lines(:));
    sum = 0;
    for j = 1:64
      sum = sum + (Xbatch(j, :) * w - ybatch(j)) * Xbatch(j, i);
     endfor 
    w(i) = w(i) - (lr * sum) / n;
  endfor
endfunction