function [TrajectoryData, DataInformation] = LoadZenTrafficData(whichSite, whichLane, whichData)

    root = '/Users/hezhengbing-2023/Library/CloudStorage/OneDrive-Personal/Research/Edie/matlab/TrajectoryData/ZenTrafficData/';
    filePath = fullfile(root, whichSite, whichLane, [whichData '.csv']);

    TrajectoryData = readtable(filePath);    
    TrajectoryData = table2array(TrajectoryData);
    
    DataInformation.figTitle= ['ZenTrafficData: ' whichSite ' , ' whichLane ' , ' whichData];
    DataInformation.TimeStart = 1;
    DataInformation.TimeEnd = floor(3500);
    
    DataInformation.PositionStart = 1;
    DataInformation.PositionEnd = floor(max(TrajectoryData(:,3)));

    DataInformation.MaxColorBar = 90;    
    DataInformation.MaxSpeed = 90;  

end




% % Define the root folder path
% 
% 
% % Extract the last 4 characters from the data name
% suffix = whichData(end-3:end);
% 
% % Construct full save path with .csv extension
% savePath = fullfile(root2, whichSite, whichLane, [suffix '.csv']);
% 
% % Save as CSV file (TrajectoryData must be a table or numeric array)
% TrajectoryData = array2table(TrajectoryData);  % 如果原本是 matrix
% 
% writetable(TrajectoryData, savePath);