function PlotParallelogram(SelectedParallelogram_All)
% This function plots parallelograms stored in a cell array,
% coloring them based on their associated speed value (stored in the 3rd column).

    % Extract all speed values from the 3rd column
    speeds = cell2mat(SelectedParallelogram_All(:,3));

    % Identify unique speed values and assign a color to each
    uniqueSpeeds = unique(speeds);
    cmap = lines(length(uniqueSpeeds));  % Use distinct colors from MATLAB's 'lines' colormap

    % Loop through each parallelogram and plot it with corresponding color
    for i = 1:min(10000, size(SelectedParallelogram_All, 1))  % Limit to 10,000 plots for efficiency
        corners = SelectedParallelogram_All{i,1};  % Extract corner coordinates
        speed = SelectedParallelogram_All{i,3};    % Extract speed value

        if isempty(corners)
            continue;  % Skip if corners are empty
        end

        % Find the color index based on speed
        colorIdx = find(uniqueSpeeds == speed, 1);
        thisColor = cmap(colorIdx, :);  % Get corresponding color

        % Close the polygon by repeating the first point
        corners_closed = [corners; corners(1,:)];

        % Plot the parallelogram with assigned color
        plot(corners_closed(:,1), corners_closed(:,2), '-', 'Color', thisColor, 'LineWidth', 1); 
        hold on;
    end    

    % % Set axis labels and title
    % xlabel('Time');
    % ylabel('Position');
    

end