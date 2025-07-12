function isOutside = IsOutsideAllParallelograms(corners, CurrentParallelogram)
    % Input:
    %   corners: 4x2 matrix, new parallelogram corners
    %   CurrentParallelogram: N x 1 cell array, each cell is a 4x2 parallelogram or empty
    %
    % Output:
    %   isOutside: true if all points in corners are outside all parallelograms in CurrentParallelogram

    isOutside = true;

    if isempty(CurrentParallelogram)        
        return;
    end

    for i = 1:size(CurrentParallelogram,1)
        pgon = CurrentParallelogram{i,1};

        % Skip empty entries
        if isempty(pgon)
            continue;
        end

        % Check each point in corners
        for j = 1:4
            x = corners(j, 1);
            y = corners(j, 2);

            % Use inpolygon to check if point is inside the parallelogram
            [in, on] = inpolygon(x, y, pgon(:, 1), pgon(:, 2));

            if in || on
                isOutside = false;
                return;  % Early exit: one point already inside
            end
        end
    end
end
