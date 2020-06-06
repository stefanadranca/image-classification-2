function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  ##cale catre director poze cu pisici
  path_to_cats = path_to_testset;
  path_to_cats = strcat (path_to_cats, "cats/");
  ##cale director poze fara pisici
  path_to_noncats = strcat (path_to_testset, "not_cats/");
  ##matrici cu linii siruri de caractere = pathuri catre fisiere
  images1 = strcat (path_to_cats, readdir (path_to_cats));
  images2 = strcat (path_to_noncats, readdir (path_to_noncats));
  images1 = char (images1);
  images2 = char (images2);
  n1 = rows (images1);
  n2 = rows (images2);
  ##initializare vector auxiliar
  x = zeros (1, 3 * count_bins + 1);
  nr_cats = 0;
  nr_cats_n = 0;
  ##matrice cu liniile vectori de parametri pt imagini
  Ximg = zeros (n1 + n2 - 6, 3 * count_bins + 1);
  Ximg(:, 3 * count_bins + 1) = 1;
  ##determinarea tipului de histograma
  if strcmp (histogram, "RGB")
    ok = 1;
  elseif strcmp (histogram, "HSV")
    ok = 0;
  else
    disp ("Eroare: nu ati scris corect tipul histogramei");
  endif
  ##liniile din matrice pentru pozele cu pisici
  for i = 3 : n1 - 1
    if (ok == 1)
      Ximg(i - 2, 1:3 * count_bins) = rgbHistogram...
      (images1(i, :), count_bins);
    else
      Ximg(i - 2, 1:3 * count_bins) = hsvHistogram...
      (images1(i, :), count_bins);
    endif
  endfor
  ##liniile din matrice pentru pozele fara pisici
  for i = 3 : n2 - 1
    if (ok == 1)
      Ximg(i + n1 - 5, 1:3 * count_bins) = rgbHistogram...
      (images2(i, :), count_bins);
    else
      Ximg(i + n1 - 5, 1:3 * count_bins) = hsvHistogram...
      (images2(i, :), count_bins);
    endif
  endfor
  ##scalarea coloanelor matricii cu exceptia celei cu valori de 1
  for i = 1:3 * count_bins
    Ximg(:, i) = (Ximg(:, i) - mean (Ximg(:, i))) / std (Ximg(:, i));
  endfor
  for i = 1 : rows (Ximg)
    x = (Ximg(i, :))';
    if i <= n1 - 3 &&  w' * x >= 0 #poze cu pisici incadrate bine
      nr_cats++;
    else if i > n1 - 3 && w' * x >= 0 #poze fara pisici gresit incadrate
      nr_cats_n++;
    endif
    endif
  endfor
  ##determinarea procentului: nr incadrari corecte/nr total de poze
  percentage = (nr_cats + n2 - 3 - nr_cats_n) / (n1 + n2 - 6);
endfunction
