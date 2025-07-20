function fig= PlotAllTrajectory(Config, TrajectoryData)           

    fig = figure();    
                           
    scatter(TrajectoryData(:,2), TrajectoryData(:,3), 10, TrajectoryData(:,4), 'filled'); hold on;
    
    colormap(flipud(jet));  
    clim([0 Config.MaxColorBar]);    
    
    cb = colorbar;
    cb.FontSize = 18;
    cb.TickLabelInterpreter = 'none';    
        
    %%
    set(gca, 'FontSize', 18);
    xlim([Config.TimeStart Config.TimeEnd])
    ylim([Config.PositionStart Config.PositionEnd]) % max position
    xlabel('Time (s)');
    ylabel('Position (m)');  
    set(gcf,'Position',[50,400,1500,500]);
    box on;    

    mainPos = [0.1, 0.12, 0.78, 0.8];
    colorbarPos = [0.89, 0.12, 0.015, 0.8];    
    
    ax = gca;
    cb = colorbar;
    
    ax.Position = mainPos;
    cb.Position = colorbarPos;


end


    











