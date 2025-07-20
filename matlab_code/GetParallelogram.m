function [corners, extents, T_inv] = GetParallelogram(Config, center, giveSpeed)

    % Extract parameters
    Lw = Config.Parallelogram.Lw;
    w  = Config.Parallelogram.w;
    H  = Config.Parallelogram.H;
    v  = giveSpeed / 3.6;

    % Construct direction vector
    u_w = [1, w];              
    u_w = u_w / norm(u_w);     

    u_v = [1, v];              
    u_v = u_v / norm(u_v);     

    % Compute sin(theta) = |u_w × u_v| (scalar)
    sin_theta = abs(u_w(1) * u_v(2) - u_w(2) * u_v(1));

    % Long side and height direction vectors
    vec_w = (Lw / 2) * u_w;    
    vec_v = (H / (2 * sin_theta)) * u_v;

    % Construct the 4 corners of the parallelogram
    c = [center.x, center.y];
    corners = zeros(4, 2);
    corners(1, :) = c - vec_w - vec_v;
    corners(2, :) = c + vec_w - vec_v;
    corners(3, :) = c + vec_w + vec_v;
    corners(4, :) = c - vec_w + vec_v;

    % Extract coordinates for extents calculation
    x_coords = corners(:,1);
    y_coords = corners(:,2);

    extents.dx_left   = abs(center.x - min(x_coords));
    extents.dx_right  = abs(max(x_coords) - center.x);
    extents.dy_top    = abs(max(y_coords) - center.y);
    extents.dy_bottom = abs(center.y - min(y_coords));

    % Compute transformation matrix T and inverse matrix T_inv
    u = corners(2,:) - corners(1,:);
    v = corners(4,:) - corners(1,:);
    T = [u(:), v(:)];
    T_inv = inv(T);  % Inverse matrix for affine transformation
end