function T = compute_T_coefficients(R,params)
    % Calcula t y T para todos los resonadores
    omega = params.Omega;
    omegaR = params.omegaR;
    
    t = (params.m / params.D) * (omegaR^2 * omega^2) / (omegaR^2 - omega^2); % Fuerza del resonador
    T = t ./ (1 - 1i * t / (8 * params.k^2));
    
    % Si hay múltiples tipos de resonadores, expandir aquí
    T = T * ones(1, size(R, 2)); % Todos iguales en este caso

    % Imprimir valores clave
    disp('=== Parámetros de Scattering ===');
    disp(['t: ', num2str(t)]);
    disp(['T: ', num2str(T)]);
    disp(['size T: ' num2str(size(T))]);

end