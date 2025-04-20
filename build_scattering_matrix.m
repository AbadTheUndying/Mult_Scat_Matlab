function A = build_scattering_matrix(R, params)
    num_resonators = length(R);
    T = compute_T_coefficients(R,params); 
    
    % Matriz de distancias entre todos los pares de resonadores
    [X1, X2] = meshgrid(R(1, :), R(1, :));
    [Y1, Y2] = meshgrid(R(2, :), R(2, :));
    dist = sqrt((X1 - X2).^2 + (Y1 - Y2).^2);
    disp('=== Matriz de distancias ===');
    disp(['size R matrix:' num2str(size(R))]);
    disp(['size distance matrix:' num2str(size(dist))]);
    disp(['diag: ' num2str(sum(diag(dist)))]);
    
    % Matriz de Green (dim: num_resonators x num_resonators)
    G_matrix = GreenFunction(params.k, dist);
    disp('=== Matriz G ===');
    disp(['diag: ' num2str(sum(diag(G_matrix)))]);
    
        % Asegurar que T sea un vector fila para multiplicación correcta
        if iscolumn(T)
            T = T';
        end
    
  

    % Multiplicar cada columna j de G_matrix por T(j)
    interaction_matrix = T .* ((ones(num_resonators) - eye(num_resonators))) .* G_matrix; 

    % Construir matriz A
    A = eye(num_resonators) - interaction_matrix;
end