function Main_A_FundamentalDiagram()

    addpath(genpath(pwd));   

    RandStream.setGlobalStream(RandStream('mt19937ar','Seed', 0));


    %% Zen Traffic: Edie    
    [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F001');  Edie_FD(TrajectoryData, DataInformation, 15, 111, 'r.-', 0);   
    [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F002');  Edie_FD(TrajectoryData, DataInformation, 15, 111, 'g.-', 0);
    [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F003');  Edie_FD(TrajectoryData, DataInformation, 15, 111, 'b.-', 0);
    [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F004');  Edie_FD(TrajectoryData, DataInformation, 15, 111, 'c.-', 0);
    [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F005');  Edie_FD(TrajectoryData, DataInformation, 15, 111, 'm.-', 0);    
    AddReferenceLine(111, -15);
    AddLegendAndSave_ZenTraffic(111);  % in paper

    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane2', 'F001'); Edie_FD(TrajectoryData, DataInformation, 15, 222, 'r.-', 0);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane2', 'F002'); Edie_FD(TrajectoryData, DataInformation, 15, 222, 'g.-', 0);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane2', 'F003'); Edie_FD(TrajectoryData, DataInformation, 15, 222, 'b.-', 0);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane2', 'F004'); Edie_FD(TrajectoryData, DataInformation, 15, 222, 'c.-', 0);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane2', 'F005'); Edie_FD(TrajectoryData, DataInformation, 15, 222, 'm.-', 0);
    
   
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane1', 'F001'); Edie_FD(TrajectoryData, DataInformation, 15, 333, 'r.-', 0);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane1', 'F002'); Edie_FD(TrajectoryData, DataInformation, 15, 333, 'g.-', 0);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane1', 'F003'); Edie_FD(TrajectoryData, DataInformation, 15, 333, 'b.-', 0);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane1', 'F004'); Edie_FD(TrajectoryData, DataInformation, 15, 333, 'c.-', 0);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane1', 'F005'); Edie_FD(TrajectoryData, DataInformation, 15, 333, 'm.-', 0);
    % 
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane2', 'F001'); Edie_FD(TrajectoryData, DataInformation, 15, 444, 'r.-', 0);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane2', 'F002'); Edie_FD(TrajectoryData, DataInformation, 15, 444, 'g.-', 0);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane2', 'F003'); Edie_FD(TrajectoryData, DataInformation, 15, 444, 'b.-', 0);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane2', 'F004'); Edie_FD(TrajectoryData, DataInformation, 15, 444, 'c.-', 0);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane2', 'F005'); Edie_FD(TrajectoryData, DataInformation, 15, 444, 'm.-', 0);


    %% Zen Traffic: Loop
    [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F001'); Loop_FD(TrajectoryData, DataInformation, 555, 'r.-');
    [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F002'); Loop_FD(TrajectoryData, DataInformation, 555, 'g.-');
    [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F003'); Loop_FD(TrajectoryData, DataInformation, 555, 'b.-');
    [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F004'); Loop_FD(TrajectoryData, DataInformation, 555, 'c.-');
    [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane1', 'F005'); Loop_FD(TrajectoryData, DataInformation, 555, 'm.-');
    AddReferenceLine(555, -15);
    AddLegendAndSave_ZenTraffic(555);  % in paper
    
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane2', 'F001'); Loop_FD(TrajectoryData, DataInformation, 666, 'r.-');
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane2', 'F002'); Loop_FD(TrajectoryData, DataInformation, 666, 'g.-');
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane2', 'F003'); Loop_FD(TrajectoryData, DataInformation, 666, 'b.-');
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane2', 'F004'); Loop_FD(TrajectoryData, DataInformation, 666, 'c.-');
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_11', 'Lane2', 'F005'); Loop_FD(TrajectoryData, DataInformation, 666, 'm.-');
    

    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane1', 'F001'); Loop_FD(TrajectoryData, DataInformation, 777, 'r.-');
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane1', 'F002'); Loop_FD(TrajectoryData, DataInformation, 777, 'g.-');
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane1', 'F003'); Loop_FD(TrajectoryData, DataInformation, 777, 'b.-');
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane1', 'F004'); Loop_FD(TrajectoryData, DataInformation, 777, 'c.-');
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane1', 'F005'); Loop_FD(TrajectoryData, DataInformation, 777, 'm.-');
    % 
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane2', 'F001'); Loop_FD(TrajectoryData, DataInformation, 888, 'r.-');
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane2', 'F002'); Loop_FD(TrajectoryData, DataInformation, 888, 'g.-');
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane2', 'F003'); Loop_FD(TrajectoryData, DataInformation, 888, 'b.-');
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane2', 'F004'); Loop_FD(TrajectoryData, DataInformation, 888, 'c.-');
    % [TrajectoryData, DataInformation] = LoadZenTrafficData('TRJ_4', 'Lane2', 'F005'); Loop_FD(TrajectoryData, DataInformation, 888, 'm.-');


    %% NGSIM: Edie
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0400pm-0415pm', 'Lane1'); Edie_FD(TrajectoryData, DataInformation, 16, 1111, 'r.-', 0);  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0500pm-0515pm', 'Lane1'); Edie_FD(TrajectoryData, DataInformation, 16, 1111, 'b.-', 0);
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0515pm-0530pm', 'Lane1'); Edie_FD(TrajectoryData, DataInformation, 16, 1111, 'k.-', 0); 
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0400pm-0415pm', 'Lane2'); Edie_FD(TrajectoryData, DataInformation, 16, 2222, 'r.-', 0);
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0500pm-0515pm', 'Lane2'); Edie_FD(TrajectoryData, DataInformation, 16, 2222, 'b.-', 0);
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0515pm-0530pm', 'Lane2'); Edie_FD(TrajectoryData, DataInformation, 16, 2222, 'k.-', 0);
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0400pm-0415pm', 'Lane3'); Edie_FD(TrajectoryData, DataInformation, 16, 3333, 'r.-', 0);  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0500pm-0515pm', 'Lane3'); Edie_FD(TrajectoryData, DataInformation, 16, 3333, 'b.-', 0);  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0515pm-0530pm', 'Lane3'); Edie_FD(TrajectoryData, DataInformation, 16, 3333, 'k.-', 0);  
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0400pm-0415pm', 'Lane4'); Edie_FD(TrajectoryData, DataInformation, 16, 4444, 'r.-', 0); 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0500pm-0515pm', 'Lane4'); Edie_FD(TrajectoryData, DataInformation, 16, 4444, 'b.-', 0);  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0515pm-0530pm', 'Lane4'); Edie_FD(TrajectoryData, DataInformation, 16, 4444, 'k.-', 0);
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0400pm-0415pm', 'Lane5'); Edie_FD(TrajectoryData, DataInformation, 16, 5555, 'r.-', 0);  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0500pm-0515pm', 'Lane5'); Edie_FD(TrajectoryData, DataInformation, 16, 5555, 'b.-', 0);      
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0515pm-0530pm', 'Lane5'); Edie_FD(TrajectoryData, DataInformation, 16, 5555, 'k.-', 0);      
    

    [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0750am-0805am', 'Lane1'); Edie_FD(TrajectoryData, DataInformation, 16, 6666, 'r.-', 0);  
    [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0805am-0820am', 'Lane1'); Edie_FD(TrajectoryData, DataInformation, 16, 6666, 'b.-', 0);
    [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0820am-0835am', 'Lane1'); Edie_FD(TrajectoryData, DataInformation, 16, 6666, 'k.-', 0); 
    AddReferenceLine(6666, -16);
    AddLegendAndSave_NGSIM(6666);  % in paper
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0750am-0805am', 'Lane2'); Edie_FD(TrajectoryData, DataInformation, 16, 7777, 'r.-', 0);
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0805am-0820am', 'Lane2'); Edie_FD(TrajectoryData, DataInformation, 16, 7777, 'b.-', 0);
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0820am-0835am', 'Lane2'); Edie_FD(TrajectoryData, DataInformation, 16, 7777, 'k.-', 0);
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0750am-0805am', 'Lane3'); Edie_FD(TrajectoryData, DataInformation, 16, 8888, 'r.-', 0);  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0805am-0820am', 'Lane3'); Edie_FD(TrajectoryData, DataInformation, 16, 8888, 'b.-', 0);  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0820am-0835am', 'Lane3'); Edie_FD(TrajectoryData, DataInformation, 16, 8888, 'k.-', 0);  
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0750am-0805am', 'Lane4'); Edie_FD(TrajectoryData, DataInformation, 16, 9999, 'r.-', 0); 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0805am-0820am', 'Lane4'); Edie_FD(TrajectoryData, DataInformation, 16, 9999, 'b.-', 0);  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0820am-0835am', 'Lane4'); Edie_FD(TrajectoryData, DataInformation, 16, 9999, 'k.-', 0);
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0750am-0805am', 'Lane5'); Edie_FD(TrajectoryData, DataInformation, 16, 99991, 'r.-', 0);  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0805am-0820am', 'Lane5'); Edie_FD(TrajectoryData, DataInformation, 16, 99991, 'b.-', 0);      
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0820am-0835am', 'Lane5'); Edie_FD(TrajectoryData, DataInformation, 16, 99991, 'k.-', 0);   


    %% NGSIM: Loop
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0400pm-0415pm', 'Lane1'); Loop_FD(TrajectoryData, DataInformation, 11111, 'r.-');  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0500pm-0515pm', 'Lane1'); Loop_FD(TrajectoryData, DataInformation, 11111, 'b.-');
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0515pm-0530pm', 'Lane1'); Loop_FD(TrajectoryData, DataInformation, 11111, 'k.-'); 
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0400pm-0415pm', 'Lane2'); Loop_FD(TrajectoryData, DataInformation, 22222, 'r.-');
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0500pm-0515pm', 'Lane2'); Loop_FD(TrajectoryData, DataInformation, 22222, 'b.-');
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0515pm-0530pm', 'Lane2'); Loop_FD(TrajectoryData, DataInformation, 22222, 'k.-');
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0400pm-0415pm', 'Lane3'); Loop_FD(TrajectoryData, DataInformation, 33333, 'r.-');  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0500pm-0515pm', 'Lane3'); Loop_FD(TrajectoryData, DataInformation, 33333, 'b.-');  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0515pm-0530pm', 'Lane3'); Loop_FD(TrajectoryData, DataInformation, 33333, 'k.-');  
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0400pm-0415pm', 'Lane4'); Loop_FD(TrajectoryData, DataInformation, 44444, 'r.-'); 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0500pm-0515pm', 'Lane4'); Loop_FD(TrajectoryData, DataInformation, 44444, 'b.-');  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0515pm-0530pm', 'Lane4'); Loop_FD(TrajectoryData, DataInformation, 44444, 'k.-');
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0400pm-0415pm', 'Lane5'); Loop_FD(TrajectoryData, DataInformation, 55555, 'r.-');  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0500pm-0515pm', 'Lane5'); Loop_FD(TrajectoryData, DataInformation, 55555, 'b.-');      
    % [TrajectoryData, DataInformation] = LoadNGSIMData('I80', '0515pm-0530pm', 'Lane5'); Loop_FD(TrajectoryData, DataInformation, 55555, 'k.-');      
    

    [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0750am-0805am', 'Lane1'); Loop_FD(TrajectoryData, DataInformation, 66666, 'r.-');  
    [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0805am-0820am', 'Lane1'); Loop_FD(TrajectoryData, DataInformation, 66666, 'b.-');
    [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0820am-0835am', 'Lane1'); Loop_FD(TrajectoryData, DataInformation, 66666, 'k.-'); 
    AddReferenceLine(66666, -16);
    AddLegendAndSave_NGSIM(66666);  % in paper

    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0750am-0805am', 'Lane2'); Loop_FD(TrajectoryData, DataInformation, 77777, 'r.-');
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0805am-0820am', 'Lane2'); Loop_FD(TrajectoryData, DataInformation, 77777, 'b.-');
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0820am-0835am', 'Lane2'); Loop_FD(TrajectoryData, DataInformation, 77777, 'k.-');
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0750am-0805am', 'Lane3'); Loop_FD(TrajectoryData, DataInformation, 88888, 'r.-');  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0805am-0820am', 'Lane3'); Loop_FD(TrajectoryData, DataInformation, 88888, 'b.-');  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0820am-0835am', 'Lane3'); Loop_FD(TrajectoryData, DataInformation, 88888, 'k.-');  
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0750am-0805am', 'Lane4'); Loop_FD(TrajectoryData, DataInformation, 99999, 'r.-'); 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0805am-0820am', 'Lane4'); Loop_FD(TrajectoryData, DataInformation, 99999, 'b.-');  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0820am-0835am', 'Lane4'); Loop_FD(TrajectoryData, DataInformation, 99999, 'k.-');
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0750am-0805am', 'Lane5'); Loop_FD(TrajectoryData, DataInformation, 999991, 'r.-');  
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0805am-0820am', 'Lane5'); Loop_FD(TrajectoryData, DataInformation, 999991, 'b.-');      
    % [TrajectoryData, DataInformation] = LoadNGSIMData('US101', '0820am-0835am', 'Lane5'); Loop_FD(TrajectoryData, DataInformation, 999991, 'k.-');       

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



























