function [TrajectoryData, DataInformation] = LoadZenTrafficData(root, whichSite, whichLane, whichData)
       
    filePath = fullfile(root, 'trajectory_data', 'ZenTrafficData', whichSite, whichLane, [whichData '.csv']);

    TrajectoryData = readtable(filePath);    
    TrajectoryData = table2array(TrajectoryData);
    
    DataInformation.dataset = 'ZenTrafficData';
    DataInformation.site = whichSite;
    DataInformation.lane = whichLane;
    DataInformation.data = whichData;

    DataInformation.TimeStart = 1;
    DataInformation.TimeEnd = floor(3500);
    
    DataInformation.PositionStart = 1;
    DataInformation.PositionEnd = floor(max(TrajectoryData(:,3)));

    DataInformation.MaxColorBar = 90;    
    DataInformation.MaxSpeed = 90;  

end


