function Main_B_AnalyzeParallelogram()

    addpath(genpath(pwd));   

    RandStream.setGlobalStream(RandStream('mt19937ar','Seed', 0));

    root = '/Users/hezhengbing-2023/Library/CloudStorage/OneDrive-Personal/Research/Edie/matlab_github/';

    %% NGSIM: Edie
    % whichSite = 'I80';
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0400pm-0415pm', 'Lane1'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0400pm-0415pm', 'Lane2'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0400pm-0415pm', 'Lane3'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0400pm-0415pm', 'Lane4'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0400pm-0415pm', 'Lane5'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0500pm-0515pm', 'Lane1'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0500pm-0515pm', 'Lane2'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0500pm-0515pm', 'Lane3'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0500pm-0515pm', 'Lane4'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0500pm-0515pm', 'Lane5'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0515pm-0530pm', 'Lane1'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0515pm-0530pm', 'Lane2'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0515pm-0530pm', 'Lane3'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0515pm-0530pm', 'Lane4'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0515pm-0530pm', 'Lane5'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    

    whichSite = 'US101';
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0750am-0805am', 'Lane1'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0750am-0805am', 'Lane2'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0750am-0805am', 'Lane3'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0750am-0805am', 'Lane4'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0750am-0805am', 'Lane5'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);

    [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0805am-0820am', 'Lane1'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation); % in paper
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0805am-0820am', 'Lane2'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0805am-0820am', 'Lane3'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0805am-0820am', 'Lane4'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0805am-0820am', 'Lane5'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % 
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0820am-0835am', 'Lane1'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0820am-0835am', 'Lane2'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0820am-0835am', 'Lane3'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0820am-0835am', 'Lane4'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadNGSIMData(root, whichSite, '0820am-0835am', 'Lane5'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);


    %% Zen Traffic: Edie
    whichSite = 'TRJ_11';
    [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane1', 'F001'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation); % in paper  
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane1', 'F002'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane1', 'F003'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane1', 'F004'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane1', 'F005'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % 
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane2', 'F001'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane2', 'F002'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane2', 'F003'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane2', 'F004'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane2', 'F005'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    
    % whichSite = 'TRJ_4';
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane1', 'F001'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane1', 'F002'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane1', 'F003'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane1', 'F004'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane1', 'F005'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % 
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane2', 'F001'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane2', 'F002'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane2', 'F003'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane2', 'F004'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);
    % [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, 'Lane2', 'F005'); AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation);





end


function AnalyzeParallelogram_bat(whichSite, TrajectoryData, DataInformation)

    if strcmp(whichSite, 'US101')

        AnalyzeParallelogram(whichSite, TrajectoryData, DataInformation, 16, 30);
        AnalyzeParallelogram(whichSite, TrajectoryData, DataInformation, 16, 10);
        AnalyzeParallelogram(whichSite, TrajectoryData, DataInformation, 16, 5);
        AnalyzeParallelogram(whichSite, TrajectoryData, DataInformation, 16, 2);
        AnalyzeParallelogram(whichSite, TrajectoryData, DataInformation, 16, 1);
        AnalyzeParallelogram(whichSite, TrajectoryData, DataInformation, 16, 0);
       
    elseif strcmp(whichSite, 'TRJ_11')

        AnalyzeParallelogram(whichSite, TrajectoryData, DataInformation, 15, 60);
        AnalyzeParallelogram(whichSite, TrajectoryData, DataInformation, 15, 40);
        AnalyzeParallelogram(whichSite, TrajectoryData, DataInformation, 15, 30);
        AnalyzeParallelogram(whichSite, TrajectoryData, DataInformation, 15, 20);
        AnalyzeParallelogram(whichSite, TrajectoryData, DataInformation, 15, 10);
        AnalyzeParallelogram(whichSite, TrajectoryData, DataInformation, 15, 5);

    end

    

end
































