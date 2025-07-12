% Change to REQUIRED FORMAT of AllPoints: ID, Time, Position, Speed (km/h)
function Edie_FD(TrajectoryData, DataInformation, WaveSpeed, figID, style, whichPart)
   
    %% Time-space diagram of trajectories
    Config.TimeStart = DataInformation.TimeStart;
    Config.TimeEnd = DataInformation.TimeEnd;
    
    Config.PositionStart = DataInformation.PositionStart;
    Config.PositionEnd = DataInformation.PositionEnd;

    Config.MaxColorBar = DataInformation.MaxColorBar;
    Config.MaxSpeed = DataInformation.MaxSpeed;

    PlotAllTrajectory(Config, TrajectoryData); % speed: 0~100 km/h
    

    %% Edie's
    %%%%% Setting
    Config.Parallelogram.Lw = 100;  % long edge (meter)
    Config.Parallelogram.w = - WaveSpeed/3.6; % wave speed (m/s)
    Config.Parallelogram.H = 5;  % distance between two long edges
    Config.Parallelogram.area = Config.Parallelogram.Lw * Config.Parallelogram.H; % area of the parallelogram

    Config.NumberOfSelectedParallelogram = 100;
    Config.MinNumberOfSelectedParallelogram_Speed = 10;
    Config.MinNumberOfPointsInParallelogram = 10;
    Config.wCV = 0.5;
    Config.wNAE = 0.5;    

    Config.col.corners = 1;
    Config.col.points = 2;
    Config.col.givenSpeed = 3;
    Config.col.CV = 4;
    Config.col.NAE = 5;
    Config.col.SCORE = 6;
    Config.col.total = 7;
    Config.col.q = 8;
    Config.col.k = 9;
    Config.col.v = 10;

    
    %%%%% 
    vQK = [];
    SelectedParallelogram_All = [];
    

    for givenSpeed = 0:5:Config.MaxSpeed % km/h

        tStart = tic; 

        fprintf('speed= %d', givenSpeed);

        %% get information of a parallelogram
        center_initial.x = 0; center_initial.y = 0;
        [corners_initial, extents_initial, T_inv] = GetParallelogram(Config, center_initial, givenSpeed);
        Config.Parallelogram.InsideTrajectory_Time = corners_initial(4,1) - corners_initial(1,1);
        Config.Parallelogram.InsideTrajectory_Distance = corners_initial(4,2) - corners_initial(1,2);
               

        %%        
        CandidateCenters = SelectCandidateCenters(TrajectoryData, givenSpeed);

        if isempty(CandidateCenters)
            fprintf(' [0]\n');
            continue;
        end


        %% get all condidate parallelograms
        nCandidates = size(CandidateCenters, 1);
        CandidateParallelogram_Speed = [];
        k = 0;

        for i = 1:nCandidates
    
            center.x = CandidateCenters(i, 2);
            center.y = CandidateCenters(i, 3);
            corners  = GetParallelogram(Config, center, givenSpeed);
    
            % Condition 1
            if all(corners(:,1) > Config.TimeStart) && all(corners(:,1) <= Config.TimeEnd) && all(corners(:,2) > Config.PositionStart) && all(corners(:,2) <= Config.PositionEnd)
    
                % Condition 2
                Flag_NoOverlap1 = IsOutsideAllParallelograms(corners, CandidateParallelogram_Speed);
                Flag_NoOverlap2 = IsOutsideAllParallelograms(corners, SelectedParallelogram_All);
                
                if Flag_NoOverlap1 && Flag_NoOverlap2

                    k = k + 1;
                    aCandidateParallelogram = MatchPoints(center, corners, extents_initial, T_inv, TrajectoryData); 
                    aCandidateParallelogram{1,3} = givenSpeed;

                    if isempty(CandidateParallelogram_Speed)
                        CandidateParallelogram_Speed = cell(1,6);
                        CandidateParallelogram_Speed(1, 1:3) = aCandidateParallelogram;
                    else
                        CandidateParallelogram_Speed(k, 1:3) = aCandidateParallelogram;
                    end                   
                    % PlotParallelogram_UniColor(CandidateParallelogram);
                end                                
            end           

        end        

        if isempty(CandidateParallelogram_Speed)
            fprintf(' [0]\n');
            continue;
        end        


        %% Remove outlier parallelogam with extreme high or low number of points inside
        % CandidateParallelogram_Speed = RemoveOutlierParallelogram(CandidateParallelogram_Speed);


        %% Evaluate CandidateParallelogram by adding scores
        for i = 1:1:size(CandidateParallelogram_Speed, 1)

            aCandidateParallelogram = CandidateParallelogram_Speed(i,:);
            
            nAllSpeed = size(aCandidateParallelogram{1,2}(:,4),1);
        
            if nAllSpeed > Config.MinNumberOfPointsInParallelogram

                [CV, NAE, SCORE] = GetScoreOfSpeedInParallelogram(Config, aCandidateParallelogram, givenSpeed);
                
                aCandidateParallelogram{1, Config.col.CV} = CV;
                aCandidateParallelogram{1, Config.col.NAE} = NAE;
                aCandidateParallelogram{1, Config.col.SCORE} = SCORE;

                CandidateParallelogram_Speed(i,:) = aCandidateParallelogram;
            
            end       
        end


        %% Select parallelogrms
        scores = cell2mat(CandidateParallelogram_Speed(:, Config.col.SCORE));  % n×1 数值向量
        
        [~, sortedIdx] = sort(scores, 'ascend');
        
        topN = min(Config.NumberOfSelectedParallelogram, length(sortedIdx));
        topIdx = sortedIdx(1:topN);
        
        SelectedParallelogram_Speed = CandidateParallelogram_Speed(topIdx, :);

        if ~isempty(SelectedParallelogram_Speed)
            if size(SelectedParallelogram_Speed,1) < Config.MinNumberOfSelectedParallelogram_Speed
                SelectedParallelogram_Speed =[];
                fprintf(' [0]\n');
                continue;
            end
        end
   

        %% calculate statistics for data points inside the parallelogram
        SelectedParallelogram_Speed= GetTotalTravelTimeAndDistance(Config, SelectedParallelogram_Speed);
                     
        sum_q = 0;
        sum_k = 0;
        sum_n = size(SelectedParallelogram_Speed,1);

        for r=1:1:sum_n
            
            sum_q = sum_q + SelectedParallelogram_Speed{r,Config.col.q};
            sum_k = sum_k + SelectedParallelogram_Speed{r,Config.col.k};

        end
        
        Q = sum_q / sum_n;
        K = sum_k / sum_n;
           
        if isempty(vQK)
            vQK = [givenSpeed Q K];
        else
            vQK = [vQK; [givenSpeed Q K]];
        end


        %% save
        if isempty(SelectedParallelogram_All)
            SelectedParallelogram_All = SelectedParallelogram_Speed;
        else
            SelectedParallelogram_All = [SelectedParallelogram_All; SelectedParallelogram_Speed];
        end

        elapsedTime = toc(tStart);     

        fprintf(' [%d/%d], time= %.fs\n', size(SelectedParallelogram_Speed,1), size(CandidateParallelogram_Speed,1), elapsedTime);

    end    
    
    fprintf('\n');

    %% plot parallelogram
    PlotParallelogram(SelectedParallelogram_All);
   

    %% plot part
    PartSetting.x = 500; PartSetting.y =400; PartSetting.w = 200; PartSetting.h = 400;  PartSetting.whichPart= '1';  
    rectangle('Position', [PartSetting.x, PartSetting.y, PartSetting.w, PartSetting.h], ...
              'EdgeColor', 'w', ...
              'LineWidth', 4, ...
              'FaceColor', 'none');
    text(PartSetting.x + 15, PartSetting.y + PartSetting.h - 10, 'A', ...
         'Color', 'w', ...
         'FontSize', 25, ...
         'FontWeight', 'bold', ...
         'VerticalAlignment', 'top', ...
         'HorizontalAlignment', 'left');    

    if whichPart == 1
        PlotPart(PartSetting); 
        return;
    end    

    
    PartSetting.x = 2600; PartSetting.y = 800; PartSetting.w = 200; PartSetting.h = 400; PartSetting.whichPart= '2';    
    rectangle('Position', [PartSetting.x, PartSetting.y, PartSetting.w, PartSetting.h], ...
              'EdgeColor', 'w', ...
              'LineWidth', 4, ...
              'FaceColor', 'none');
    text(PartSetting.x + 15, PartSetting.y + PartSetting.h - 10, 'B', ...
         'Color', 'w', ...
         'FontSize', 25, ...
         'FontWeight', 'bold', ...
         'VerticalAlignment', 'top', ...
         'HorizontalAlignment', 'left');        
        
    if whichPart == 2
        PlotPart(PartSetting); 
        return;
    end    
   
 

    %% plot inside time-space diagram  
    axes('Position', [0.13 0.55 0.15 0.35]);  % [left bottom width height]           
    PlotFundamentalDiagram(Config, SelectedParallelogram_All, vQK, style, 0);



    %% plot seperate q-k relatioin
    figure(figID);    
    PlotFundamentalDiagram(Config, SelectedParallelogram_All, vQK, style, 1);
    set(gcf,'Position',[800,400,500,400]);   

end




function PlotFundamentalDiagram(Config, SelectedParallelogram_All, vQK, style, flagLabel)

    %%
    for r = 1:size(SelectedParallelogram_All,1)
        
        aParallelogram = SelectedParallelogram_All(r,:);
        
        x = aParallelogram{1, Config.col.k};
        y = aParallelogram{1, Config.col.q};
    
        % Add small random jitter
        numPts = numel(x);
        
        % Jitter magnitude depends on how many points (scaled for visibility)
        jitter_scale = 0.2 + 0.01 * min(numPts, 1000);  % limit growth
        
        x_jittered = x + randn(size(x)) * jitter_scale;
        y_jittered = y + randn(size(y)) * jitter_scale;
    
        % Plot with jitter
        plot(x_jittered, y_jittered, 'k.', 'MarkerSize', 5); hold on;
    end    
    
    
    %%
    plot(vQK(:,3), vQK(:,2), style, 'MarkerSize', 30); hold on;

    
    %%
    xlim([0 150])
    ylim([0 2500])

    xticks(0:25:150); 

    if flagLabel==1
        xlabel('Density (veh/km)');
        ylabel('Flow (veh/h)');      
    end

    grid on;
    set(gca, 'FontSize', 18);
    box on;
        
end




function PlotPart(PS)

    fig = gcf;             % Use current figure
    ax = gca;              % Use current axes

    % Delete colorbar if exists
    cb = findall(fig, 'Type', 'ColorBar');
    if ~isempty(cb)
        delete(cb);

        % Adjust axes position
        axPos = get(ax, 'Position');
        axPos(1) = axPos(1) + 0.02;
        axPos(3) = axPos(3) + 0.01;
        set(ax, 'Position', axPos);
    end

    % Remove x/y labels
    xlabel(ax, '');
    ylabel(ax, '');

    % Set zoomed-in view
    xlim(ax, [PS.x, PS.x + PS.w]);
    ylim(ax, [PS.y, PS.y + PS.h]);
    xticks(ax, PS.x:40:PS.x + PS.w);
    yticks(ax, PS.y:100:PS.y + PS.h);

    % Adjust figure size
    set(fig, 'Position', [50, 400, 500, 400]);

    rectangle(ax, 'Position', [PS.x PS.y PS.w PS.h], 'EdgeColor', 'k', 'LineWidth', 1, 'LineStyle', '-');
    
end





