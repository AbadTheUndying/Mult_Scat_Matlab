function R = red_cuadrada(num_filas,num_cols,d)

[X, Y] = meshgrid(0:d:(num_filas-1)*d, 0:d:(num_cols-1)*d);
    R = [X(:), Y(:)]';
end