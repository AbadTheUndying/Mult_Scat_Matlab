function R = generate_windmill_positions(N, params)
 %  N: Número de scatterers en el anillo

    theta = linspace(0, 2*pi, N + 1); theta(end) = [];
    R = params.d * [cos(theta); sin(theta)]; % Posiciones (x, y) de los scatterers
end