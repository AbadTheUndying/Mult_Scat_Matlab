function R = red_hexagonal(numFilas,numColumnas,d)

        % Vectores base de la celda unitaria
        a1 = [d;0];
        a2 = [d*cos(pi/3); d*sin(pi/3)];
        R = [];

        % Posiciones relativas de los resonadores en cada celda unitaria
        R_alpha = (d / (2*sqrt(3))) * [cos(pi/6); sin(pi/6)];
        R_beta = -R_alpha;

        % Generar puntos de la red hexagonal
        for i = 0:numFilas-1
            for j = 0:numColumnas-1
                base = i * a1 + j * a2;
                R = [R, base + R_alpha, base + R_beta];
            end
        end
end