
% AllLoopData
% LoopData
% LoopData_Interval

function Loop_FD(TrajectoryData, DataInformation, figID, style)

    %% Time-space diagram of trajectories
    Config.TimeStart = DataInformation.TimeStart;
    Config.TimeEnd = DataInformation.TimeEnd;
    
    Config.PositionStart = DataInformation.PositionStart;
    Config.PositionEnd = DataInformation.PositionEnd;

    Config.MaxColorBar = DataInformation.MaxColorBar;
    Config.MaxSpeed = DataInformation.MaxSpeed;

    PlotAllTrajectory(Config, TrajectoryData); % speed: 0~100 km/h
    title(DataInformation.figTitle, 'FontSize', 15, 'Interpreter', 'none');


    %%
    LoopGap = 100; % m
    timeInterval = 30; % s

        

    %% match crossing vehicles
    LoopLocationList = LoopGap : LoopGap : Config.PositionEnd-LoopGap;
    numLocations = length(LoopLocationList);
    
    Data_AllLoop = cell(numLocations, 2);
    
    for i = 1:numLocations
        loc = LoopLocationList(i);
        Data_Loop = ExtractLoopData(TrajectoryData, loc, Config.TimeStart, Config.TimeEnd, timeInterval);
    
        Data_AllLoop{i, 1} = loc;
        Data_AllLoop{i, 2} = Data_Loop;
    end



    %% calculate qkv
    for loc_i = 1:1:size(Data_AllLoop,1)
    
        Data_Loop = Data_AllLoop{loc_i, 2};

        for interval_i = 1:1:size(Data_Loop,1)
            
            Data_LoopInterval = Data_Loop{interval_i, 2};
            numberOfSpeed     = size(Data_LoopInterval,1);

            q = numberOfSpeed/timeInterval; % veh/s
            k = GetDensityFromLoop(Data_LoopInterval, timeInterval); % veh/m
            v = mean(Data_LoopInterval); %m/s

            q = 3600*q;
            k = 1000*k;
            v = 3.6*v;

            Data_Loop{interval_i, 3} = q;
            Data_Loop{interval_i, 4} = k;
            Data_Loop{interval_i, 5} = v;

        end

        Data_AllLoop{loc_i, 2} = Data_Loop;

    end



    %% plot qkv
    QKV =[];
    
    for loc_i = 1:1:size(Data_AllLoop,1)
    
        Data_Loop = Data_AllLoop{loc_i, 2};


        if isempty(QKV)
            QKV.Q = cell2mat(Data_Loop(:, 3));
            QKV.K = cell2mat(Data_Loop(:, 4));
            QKV.V = cell2mat(Data_Loop(:, 5));
        else        
            QKV.Q = [QKV.Q; cell2mat(Data_Loop(:, 3))];
            QKV.K = [QKV.K; cell2mat(Data_Loop(:, 4))];
            QKV.V = [QKV.V; cell2mat(Data_Loop(:, 5))];
        end             

    end    

    % Minimum number of points required per bin
    minPointsPerBin = 5;
    QKV = GetAvgQKV(QKV, minPointsPerBin);
    

    %% plot inside time-space diagram
    PlotLoop(Config, LoopLocationList);

    axes('Position', [0.13 0.55 0.15 0.35]);  % [left bottom width height]    
    PlotFundamentalDiagram(QKV, style, 0);



    %% plot seperate q-k relatioin
    figure(figID);    
    PlotFundamentalDiagram(QKV, style, 1);
    set(gcf,'Position',[800,400,500,400]);    

end



function PlotFundamentalDiagram(QKV, style, flagLabel)

    plot(QKV.K, QKV.Q, 'k.', 'MarkerSize', 5); hold on;

    plot(QKV.AvgK, QKV.AvgQ, style, 'MarkerSize', 30); hold on;
    
    %%
    xlim([0 150])
    ylim([0 2500])

    xticks(0:25:150); 
    
    if flagLabel==1
        xlabel('Density (veh/km)');
        ylabel('Flow (veh/h)');      
    end

    grid on;
    set(gca, 'FontSize', 12);
    box on;
        
end




function QKV = GetAvgQKV(QKV, minPointsPerBin)
    % GetAvgQKV computes the average K, Q, and V values within bins of K.
    % The result is stored in QKV.AvgK, AvgQ, and AvgV.
    % Only bins with at least 5 data points are considered.

    % Extract input data
    K = QKV.K;
    Q = QKV.Q;
    V = QKV.V;

    % Define bin edges for K
    edges = 0:5:150;
    numBins = length(edges) - 1;

    % Initialize output vectors
    AvgK = NaN(numBins, 1);  % Average K value in each bin
    AvgQ = NaN(numBins, 1);  % Average Q value in each bin
    AvgV = NaN(numBins, 1);  % Average V value in each bin

    % Loop through each bin
    for i = 1:numBins
        % Find data points that fall into the current bin
        inBin = (K >= edges(i)) & (K < edges(i+1));
        numPoints = sum(inBin);

        % Compute averages only if enough data points are available
        if numPoints >= minPointsPerBin
            AvgK(i) = mean(K(inBin));
            AvgQ(i) = mean(Q(inBin));
            AvgV(i) = mean(V(inBin));
        end
    end

    % Store results in output struct
    QKV.AvgK = AvgK;
    QKV.AvgQ = AvgQ;
    QKV.AvgV = AvgV;
end









