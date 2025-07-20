function PlotLoop(Config, LoopLocationList)
    
    % Plot each horizontal line
    for i = 1:length(LoopLocationList)
        y = LoopLocationList(i);
        plot([Config.TimeStart, Config.TimeEnd], [y, y], 'k-', 'LineWidth', 1); hold on;
    end    
    
end