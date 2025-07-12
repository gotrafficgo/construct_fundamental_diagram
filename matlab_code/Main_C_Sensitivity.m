function Main_C_Sensitivity()

    addpath(genpath(pwd));   

    RandStream.setGlobalStream(RandStream('mt19937ar','Seed', 0));


    %% wave speed: 20
    % wave_speed = 20;
    
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F001');  Edie_FD(TrajectoryData, DataInformation, wave_speed, 111, 'r.-', 0);   
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F002');  Edie_FD(TrajectoryData, DataInformation, wave_speed, 111, 'g.-', 0);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F003');  Edie_FD(TrajectoryData, DataInformation, wave_speed, 111, 'b.-', 0);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F004');  Edie_FD(TrajectoryData, DataInformation, wave_speed, 111, 'c.-', 0);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F005');  Edie_FD(TrajectoryData, DataInformation, wave_speed, 111, 'm.-', 0);    
    % AddReferenceLine(111, -15);
    % AddLegendAndSave_ZenTraffic(111, 'Edie', wave_speed, 1);  % in paper
    % 
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0750am-0805am', 'Lane1'); Edie_FD(TrajectoryData, DataInformation, wave_speed, 6666, 'r.-', 0);  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0805am-0820am', 'Lane1'); Edie_FD(TrajectoryData, DataInformation, wave_speed, 6666, 'b.-', 0);
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0820am-0835am', 'Lane1'); Edie_FD(TrajectoryData, DataInformation, wave_speed, 6666, 'k.-', 0); 
    % AddReferenceLine(6666, -16);
    % AddLegendAndSave_NGSIM(6666, 'Edie', wave_speed, 1);  % in paper


    %% wave speed: 10
    wave_speed = 10;

    [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F001');  Edie_FD(TrajectoryData, DataInformation, wave_speed, 111, 'r.-', 0);   
    [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F002');  Edie_FD(TrajectoryData, DataInformation, wave_speed, 111, 'g.-', 0);
    [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F003');  Edie_FD(TrajectoryData, DataInformation, wave_speed, 111, 'b.-', 0);
    [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F004');  Edie_FD(TrajectoryData, DataInformation, wave_speed, 111, 'c.-', 0);
    [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F005');  Edie_FD(TrajectoryData, DataInformation, wave_speed, 111, 'm.-', 0);    
    AddReferenceLine(111, -15);
    AddLegendAndSave_ZenTraffic(111);  % in paper

    
    [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0750am-0805am', 'Lane1'); Edie_FD(TrajectoryData, DataInformation, wave_speed, 6666, 'r.-', 0);  
    [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0805am-0820am', 'Lane1'); Edie_FD(TrajectoryData, DataInformation, wave_speed, 6666, 'b.-', 0);
    [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0820am-0835am', 'Lane1'); Edie_FD(TrajectoryData, DataInformation, wave_speed, 6666, 'k.-', 0); 
    AddReferenceLine(6666, -16);
    AddLegendAndSave_NGSIM(6666);  % in paper    
    

end




function AddLegendAndSave_NGSIM(figID)
    
    fig = figure(figID);

    h1 = plot(nan, nan, 'r.-', 'MarkerSize', 10); hold on;
    h2 = plot(nan, nan, 'b.-', 'MarkerSize', 10);
    h3 = plot(nan, nan, 'k.-', 'MarkerSize', 10);
    
    legend([h1, h2, h3], {'7:50-8:05 am', '8:05-8:20 am', '8:20-8:35 am'}, 'Box', 'off');
    set(gca, 'FontSize', 18);

end


function AddLegendAndSave_ZenTraffic(figID)
    
    fig = figure(figID);

    h1 = plot(nan, nan, 'r.-', 'MarkerSize', 10); hold on;
    h2 = plot(nan, nan, 'g.-', 'MarkerSize', 10);
    h3 = plot(nan, nan, 'b.-', 'MarkerSize', 10);
    h4 = plot(nan, nan, 'c.-', 'MarkerSize', 10);
    h5 = plot(nan, nan, 'm.-', 'MarkerSize', 10);
    
    legend([h1, h2, h3, h4, h5], {'F001', 'F002', 'F003', 'F004', 'F005'}, 'Box', 'off');
    set(gca, 'FontSize', 18);

end


function AddReferenceLine(figID, slope)

    figure(figID);

    x0 = 100;
    y0 = 1200;
    
    L = 700;
    
    dx = 1;
    dy = slope;
    dir = [dx, dy] / norm([dx, dy]);
    
    halfL = L / 2;
    p1 = [x0, y0] - halfL * dir;
    p2 = [x0, y0] + halfL * dir;
    

    plot([p1(1), p2(1)], [p1(2), p2(2)], 'k-', 'LineWidth', 2);
    
    text(x0+5, y0+5, [num2str(slope) ' km/h'], 'FontSize', 18, 'Color', 'k', 'FontWeight', 'normal');   

end



























