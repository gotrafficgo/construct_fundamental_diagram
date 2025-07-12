function PlotParallelogram_UniColor(AllParallelogram)

    for i = 1:min(10000, size(AllParallelogram, 1))
        corners = AllParallelogram{i};
        if isempty(corners)
            continue;
        end

        corners_closed = [corners; corners(1,:)];  % Close the polygon for plotting
        plot(corners_closed(:,1), corners_closed(:,2), 'b-');
    end    

end
