function [sol] = hsvHistogram(path_to_image, count_bins)
  ##stergerea eventualelor spatii din path
  path_to_image = strrep (path_to_image, ' ', '');
  image = imread (path_to_image);
  [rows col h] = size (image);
  red = image(:, :, 1);
  green = image(:, :, 2);
  blue = image(:, :, 3);
  [H S V] = rgb_hsv (red, green, blue);
  count = zeros (1, count_bins);
  sol = zeros (1, 3 * count_bins);
  ad = zeros (count_bins + 1, 1);
  edges = [0:(1.01/count_bins):1.01];
  for i = 1:rows
    ad = histc (H(i, :), edges);
    sol(1:count_bins) = sol(1:count_bins) + ad(1:count_bins);
    ad = histc (S(i, :), edges);
    sol(count_bins + 1 : 2 * count_bins) = sol(count_bins + 1 : 2 * count_bins) + ad(1:count_bins);
    ad = histc (V(i, :), edges);
    sol(2 * count_bins + 1 : 3 * count_bins) = sol(2 * count_bins + 1 : 3 * count_bins) + ad(1:count_bins);
  endfor
end
