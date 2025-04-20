clc;
clear;
close all;


%% 1. Cargar parámetros y generar entorno
params = get_simulation_parameters();

% Redes ordenadas
    % R = hexagonal_finite_cluster(10, params.d);
    % R = red_hexagonal(21,21,params.d);
    % R = red_hexagonal(11,21,params.d);
    % R = red_cuadrada(25,25,params.d);
    % R = generate_windmill_positions(12,params);

% Redes caóticas
     R = generate_chaotic_cluster(50,5,0.5,1000);

% Onda incidente plana externa sobre scatterers alineados
%     lambda = 2*pi/params.k;
%     R= [0 params.d*lambda; 0 0]; %2*params.d*lambda 0;3*params.d*lambda 0;4*params.d*lambda 0]';

% Visualización de métodos para Figuras del paper
%    figure();
%    R1 = red_cuadrada(5,5,params.d);
%    R2 = red_hexagonal(1,1,params.d);
%    subplot(1,2,1);
%    scatter(R1(1,:),R1(2,:), 50,[0 0 1],'filled');
%    grid on; hold on; axis equal;
%    xlabel('x/d'); ylabel('y/d');
%    xlim([R1(1,1)-1 R1(1,end)+1]);
%    ylim([R1(2,1)-1 R1(2,end)+1]);
%    subplot(1,2,2);
%    % Crear un vector de colores rojo-azul en pares
%    n = size(R2, 2); % número de puntos
%    colors = zeros(n, 3); % matriz de colores RGB
%    for i = 1:n
%        if mod(i,2) == 1
%            colors(i,:) = [1 0 0]; % rojo
%        else
%            colors(i,:) = [0 0 1]; % azul
%        end
%    end
%    scatter(R2(1,:), R2(2,:), 50, colors, 'filled');
%    grid on; hold on; axis equal;
%    xlabel('x/d'); ylabel('y/d');
%    xlim([R2(1,1)-1 R2(1,end)+1]);
%    ylim([R2(2,1)-1 R2(2,end)+1]);
%
%    figure();
%    n = size(R, 2); 
%    colors = zeros(n, 3);
%    for i = 1:n
%        if mod(i,2) == 1
%            colors(i,:) = [1 0 0]; % rojo
%        else
%            colors(i,:) = [0 0 1]; % azul
%        end
%    end
%    scatter(R(1,:), R(2,:), 50, colors, 'filled');
%    grid on; hold on; axis equal;
%    xlabel('x/d'); ylabel('y/d');
%    xlim([min(R(1,:))-3 max(R(1,:))+3]);
%    ylim([min(R(2,:))-3 max(R(2,:))+3]);
%% 2. Simular scattering múltiple
[psi_e, W1,idx_source] = simulate_scattering(R, params);

%% 3. Visualizar resultados
fig = plot_scattering_results(W1,R,params,idx_source);
