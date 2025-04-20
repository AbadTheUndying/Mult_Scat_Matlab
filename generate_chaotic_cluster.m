function R = generate_chaotic_cluster(N,cluster_radius,min_distance,max_attempts)
    % GENERATE_CHAOTIC_CLUSTER Crea un arreglo caótico de resonadores no superpuestos
    %
    % Input:
    %   params - Estructura con parámetros:
    %     * N: Número de resonadores (opcional, defecto: 20)
    %     * cluster_radius: Radio del área circular del cluster (opcional, defecto: 5.0)
    %     * min_distance: Distancia mínima entre resonadores (opcional, defecto: 0.5)
    %     * max_attempts: Intentos máximos por resonador (opcional, defecto: 1000)
    %
    % Output:
    %   R - Matriz 2xN con posiciones [x; y] de los resonadores
    
    % Inicialización
    R = zeros(2, N);
    attempts = 0;
    
    % Generación de posiciones
    for i = 1:N
        while true
            % Generar posición candidata
            angle = 2*pi*rand();
            radius = cluster_radius*sqrt(rand());
            candidate = radius * [cos(angle); sin(angle)];
            
            % Verificar distancia mínima
            valid = true;
            for j = 1:i-1
                if norm(candidate - R(:,j)) < min_distance
                    valid = false;
                    break;
                end
            end
            
            % Aceptar posición si es válida
            if valid
                R(:,i) = candidate;
                break;
            end
            
            % Control de intentos máximos
            attempts = attempts + 1;
            if attempts > max_attempts
                warning('No se pudo colocar el resonador %d/%d', i, N);
                return;
            end
        end
    end
end
