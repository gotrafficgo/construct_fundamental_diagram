function CandidateParallelogram = MatchPoints(center, corners, extents, T_inv, AllPoints)
% MatchPoints selects points from AllPoints that fall within the specified parallelogram
%
% Inputs:
%   center      - struct containing x and y (center point)
%   corners     - 4×2 matrix representing the corners of the parallelogram
%   extents     - struct containing dx_left, dx_right, dy_top, dy_bottom
%   T_inv       - 2×2 matrix, inverse of the affine transformation matrix
%   AllPoints   - N×4 matrix, original point set (column 2 is x, column 3 is y, column 4 is speed, etc.)
%
% Output:
%   CandidateParallelogram - 1×2 cell: {1} is the corners, {2} is the selected points (inside polygon)

    % (x, y) coordinates of all points
    all_xy = [AllPoints(:, 2), AllPoints(:, 3)];

    % Construct bounding box
    x_min = center.x - extents.dx_left;
    x_max = center.x + extents.dx_right;
    y_min = center.y - extents.dy_bottom;
    y_max = center.y + extents.dy_top;

    % Box filtering (coarse filtering)
    x_all = AllPoints(:, 2);
    y_all = AllPoints(:, 3);
    box_mask = (x_all >= x_min) & (x_all <= x_max) & ...
               (y_all >= y_min) & (y_all <= y_max);

    box_filtered_points = all_xy(box_mask, :);        % Coordinates (N×2)
    box_filtered_data   = AllPoints(box_mask, :);     % Original rows (N×4)

    % Affine transformation to check if inside polygon
    P1 = corners(1, :);  % Reference point
    relative_points = box_filtered_points - P1;       % Offset vectors
    coeffs = (T_inv * relative_points')';             % Each row: [α, β]

    in_polygon_mask = all(coeffs >= 0 & coeffs <= 1, 2);  % Whether inside parallelogram

    % Points falling inside the parallelogram (original data)
    points_in_parallelogram = box_filtered_data(in_polygon_mask, :);

    % Output as cell
    CandidateParallelogram = cell(1, 2);
    CandidateParallelogram{1, 1} = corners;
    CandidateParallelogram{1, 2} = points_in_parallelogram;
end