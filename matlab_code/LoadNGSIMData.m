function [TrajectoryData, DataInformation] = LoadNGSIMData(whichSite, whichPeriod, whichLane)

    root = '/Users/hezhengbing-2023/Library/CloudStorage/OneDrive-Personal/Research/Edie/matlab/TrajectoryData/NGSIM/';
    filePath = fullfile(root, whichSite, whichPeriod, [whichLane '.csv']);

    TrajectoryData = readtable(filePath);    
    TrajectoryData = table2array(TrajectoryData);
    
    DataInformation.figTitle= ['NGSIM: ' whichSite ' , ' whichPeriod ' , ' whichLane];
    

    DataInformation.TimeStart = min(TrajectoryData(:,2));
    DataInformation.TimeEnd   = max(TrajectoryData(:,2));
    if strcmp(whichSite, 'I80')
        DataInformation.TimeStart = DataInformation.TimeStart + 200;
        DataInformation.TimeEnd = DataInformation.TimeEnd - 200;
    elseif strcmp(whichSite, 'US101')
        DataInformation.TimeStart = DataInformation.TimeStart + 100;
        DataInformation.TimeEnd = DataInformation.TimeEnd - 100;
    end


    DataInformation.PositionStart = min(TrajectoryData(:,3));
    DataInformation.PositionEnd   = max(TrajectoryData(:,3));    
    if strcmp(whichSite, 'I80')
        DataInformation.PositionStart = DataInformation.PositionStart + 50;
        DataInformation.PositionEnd = DataInformation.PositionEnd - 50;
    elseif strcmp(whichSite, 'US101')
        DataInformation.PositionStart = DataInformation.PositionStart + 50;
        DataInformation.PositionEnd = DataInformation.PositionEnd - 50;
    end

        
    DataInformation.MaxColorBar = 60;    
    DataInformation.MaxSpeed = 60;  

end


