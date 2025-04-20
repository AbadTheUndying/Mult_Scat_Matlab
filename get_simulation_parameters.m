function params = get_simulation_parameters()
% GET_SIMULATION_PARAMETERS Define los parámetros físicos y de simulación.
%   Devuelve una estructura con todos los parámetros necesarios para la simulación,
%   basados en el paper "Elastic analog of graphene" (Phys. Rev. B 87, 115143).

    % --- Parámetros físicos de la placa ---
    params.rho = 2700;       % Densidad de la placa (kg/m³, aluminio)
    params.h = 0.01;        % Espesor de la placa (m)
    params.E = 70e9;         % Módulo de Young (Pa)
    params.nu = 0.33;        % Coeficiente de Poisson 
    params.kR = 500;        % Rigidez del resorte (N/m)
    % Rigidez flexural (D = E·h³ / 12(1-ν²))
    params.D = params.E * params.h^3 / (12*(1 - params.nu^2)); % ≈6.54 Pa·m³  
    %params.D = 6.54;

    % --- Parámetros de la red ---
    params.d = 1;          % Parámetro de red

    % --- Resonadores ---
    params.m = params.D * 1;    % Masa de cada resonador (kg)
    params.gamma = 10;

    % --- Frecuencias y número de onda ---
    params.Omega = 2.589;    % Frecuencia normalizada (adimensional, Ωa = 2.589)
    params.omegaR = sqrt(params.Omega * params.D / (params.rho * params.h));   % Frecuencia de resonancia de los scatterers  (rad/s)
    %params.omegaR = sqrt((params.kR / params.m) * (params.rho * params.d^2 *params.h / params.D));
    %params.omegaR = 2.5;
    params.k = sqrt(params.Omega) * ((params.rho * params.h /params.D)^(1/4)); % Número de onda
    %params.k = sqrt(params.Omega) / sqrt(params.d); % Número de onda normalizado

    % --- Parámetros de simulación ---
    params.field_resolution = 300; % Resolución de la malla para el campo (puntos por eje)
    params.visualize = true       % Visualizar resultados automáticamente
end