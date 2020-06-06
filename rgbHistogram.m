function [sol] = rgbHistogram(path_to_image, count_bins)
  ##stergerea eventualelor spatii din path
  path_to_image = strrep (path_to_image, ' ', '');
  image = imread (path_to_image);
  [rows col h] = size (image);
  red = image(:, :, 1);
  green = image(:, :, 2);
  blue = image(:, :, 3);
  count = zeros (1, count_bins);
  sol = zeros (1, 3 * count_bins);
  edges = [0:(256/count_bins):256];
  ad = zeros (count_bins + 1, 1);
  for i = 1:rows
    ad = histc (red(i, :), edges);
    sol(1:count_bins) = sol(1:count_bins) + ad(1:count_bins);
    ad = histc (green(i, :), edges);
    sol(count_bins + 1 : 2 * count_bins) = sol(count_bins + 1 : 2 * count_bins) + ad(1:count_bins);
    ad = histc (blue(i, :), edges);
    sol(2 * count_bins + 1 : 3 * count_bins) = sol(2 * count_bins + 1 : 3 * count_bins) + ad(1:count_bins);
  endfor

end
