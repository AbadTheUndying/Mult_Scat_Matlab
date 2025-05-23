function [psi_e, W1,idx_source] = simulate_scattering(R, params)
    % Resuelve el sistema y calcula el campo total
    A = build_scattering_matrix(R, params);
    disp('=== Matriz A ===');
    disp(['size: ' num2str(size(A))]);
    disp(['diag: ' num2str(prod(diag(A)))]);
    
    % Inicializar onda incidente 
        psi0 = zeros(length(R),1);
    % Posición
        % Encontrar el resonador con máxima coordenada x e y
        %    [~, idx_source] = max(R(1, :) + R(2, :));

        % Resonador central para red cuadrada
        %   idx_source = round(length(R)/2);

        % Encontrar un resonador concreto similar al del paper
        %   coord_obj = [18.75; 16.5988];   % Coordenadas objetivo del resonador
        %   distancias = vecnorm(R - coord_obj, 2, 1);  % Distancia euclídea columna a columna
        %   [~, idx_source] = min(distancias);

        % Para onda incidente plana
            theta = 0;  % dirección de propagación (0 = eje x)
            k = params.k;
            kvec = k * [cos(theta); sin(theta)];

    % Definir la fuente
        % Fuente puntual
        %   psi0(idx_source) = 1;
        % Onda plana incidente
            % Evaluar la onda plana en cada resonador
                psi0 = exp(1i * (kvec' * R));  % R es 2xN, psi0 es 1xN
            % Asegurarse de que psi0 sea columna
                psi0 = psi0.';  % ahora psi0 es Nx1
                idx_source = [];  % no hay una fuente puntual en este caso

    disp('=== Onda incidente===');
    disp(['size: ' num2str(size(psi0))]);

    % Resolver sistema lineal
    psi_e = A \ psi0;
    disp('=== Onda externa ===');
    disp(['size: ' num2str(size(psi_e))]);
    
    % Calcular el campo total en una malla
    x = linspace(min(R(1,:)) - 3, max(R(1,:)) + 3, params.field_resolution);
    y = linspace(min(R(2,:)) - 3, max(R(2,:)) + 3, params.field_resolution);
    [X, Y] = meshgrid(x, y);
    W1 = zeros(size(X));
    
    for n = 1:length(R)
        r = sqrt((X - R(1,n)).^2 + (Y - R(2,n)).^2);
        W1 = W1 + psi_e(n) * GreenFunction(params.k, r);
    end
    
    % Añadir la onda incidente (fuente puntual)        
    %    r_source = sqrt((X - R(1, idx_source)).^2 + (Y - R(2, idx_source)).^2);
    %    W1 = W1 + GreenFunction(params.k, r_source);

    % Añadir la onda incidente (fuente no puntual)
        W1 = W1 + exp(1i * (kvec(1) * X + kvec(2) * Y));
end
