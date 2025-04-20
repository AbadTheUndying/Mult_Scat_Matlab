function R = hexagonal_finite_cluster(size_cluster, d)
% HEXAGONAL_FINITE_CLUSTER Genera un cluster hexagonal finito con bordes en zigzag.
%   R = hexagonal_finite_cluster(size_cluster, d)
%   - size_cluster: Tamaño del cluster (ej. 5 para un hexágono de 5 capas).
%   - d: Distancia entre vecinos.

    a1 = [d; 0];
    a2 = [d*cos(pi/3); d*sin(pi/3)];
    
    R = [];
    for i = -size_cluster:size_cluster
        for j = -size_cluster:size_cluster
            if abs(i + j) <= size_cluster % Condición para bordes en zigzag
                base = i*a1 + j*a2;
                R = [R, base]; 
            end
        end
    end
end