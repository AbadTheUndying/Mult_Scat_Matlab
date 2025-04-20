function fig = plot_scattering_results(W1, R, params, idx_source, varargin)
    % PLOT_SCATTERING_RESULTS Visualiza resultados de simulación de scattering múltiple
    %
    % Inputs:
    %   W1         - Campo complejo calculado (matriz 2D)
    %   R          - Posiciones de los resonadores [2 x N]
    %   params     - Estructura con parámetros de simulación (debe contener campo 'd')
    %   idx_source - Índice del resonador fuente
    %   
    % Parámetros opcionales (nombre-valor):
    %   'Colormap'    - Mapa de colores (default: 'parula')
    %   'Colorbar'    - Mostrar colorbar (true/false, default: true)
    %   'ViewAngle'   - Ángulo de vista 3D [azimut, elevación] (default: [0 90])
    %   'LineWidth'   - Grosor de líneas (default: 2)
    %   'FontSize'    - Tamaño de fuente (default: 20)
    %
    % Output:
    %   fig - Handle de la figura creada
    
    % Parámetros por defecto
    p = inputParser;
    addParameter(p, 'Colormap', 'parula', @(x) ischar(x) || ismatrix(x));
    addParameter(p, 'Colorbar', true, @islogical);
    addParameter(p, 'ViewAngle', [0 90], @isnumeric);
    addParameter(p, 'LineWidth', 2, @isnumeric);
    addParameter(p, 'FontSize', 20, @isnumeric);
    parse(p, varargin{:});
    
    % Configurar figura
    fig = figure();
    set(fig, 'color', 'white', 'Position', [100 100 800 600]);
    ax = gca;
    set(ax, 'FontSize', p.Results.FontSize,...
            'FontWeight', 'bold',...
            'LineWidth', p.Results.LineWidth);
    
    % Calcular coordenadas normalizadas
    d = params.d;
    Rx = R(1,:)/d;
    Ry = R(2,:)/d;
    
    % Crear malla de coordenadas
    padding = 3/d;
    xvec = linspace(min(Rx)-padding, max(Rx)+padding, params.field_resolution);
    yvec = linspace(min(Ry)-padding, max(Ry)+padding, params.field_resolution);
    
    % Visualización 3D del campo
    surf(xvec, yvec, abs(W1), 'EdgeColor', 'none');
    colormap(ax, p.Results.Colormap);
    if p.Results.Colorbar
        colorbar;
    end
    
    % Añadir resonadores
    hold on;
    height = max(abs(W1(:))) * 1.1;
    plot3(Rx, Ry, height*ones(size(Rx)), 'ok',...
          'MarkerSize', 3,...
          'MarkerFaceColor', 'k');

    if isempty(idx_source) == 0
        % Destacar fuente
        plot3(Rx(idx_source), Ry(idx_source), height, 'or',...
              'MarkerSize', 12,...
              'MarkerFaceColor', 'r');
    end
        
    % Ajustes finales
    %view(p.Results.ViewAngle);
    axis tight equal;
    title('Simulación de Scattering Múltiple');
    xlabel('x/d'); ylabel('y/d'); zlabel('|W|');
    shading interp;
end