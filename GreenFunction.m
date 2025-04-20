function G = GreenFunction(k, r)
    % Calcula la función de Green del paper (sin divergencias en r=0)
    G = (1i/(8*k^2)) * (besselh(0, k*r) + (2*1i/pi)*besselk(0, k*r));
    G(r == 0) = 0; % Anular auto-interacción (diagonal)

end