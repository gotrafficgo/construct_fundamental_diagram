% Change to REQUIRED FORMAT of AllPoints: ID, Time, Position, Speed (km/h)
function fig = AnalyzeParallelogram(whichSite, TrajectoryData, DataInformation, WaveSpeed, givenSpeed)
   
    %% Time-space diagram of trajectories
    Config.TimeStart = DataInformation.TimeStart;
    Config.TimeEnd = DataInformation.TimeEnd;
    
    Config.PositionStart = DataInformation.PositionStart;
    Config.PositionEnd = DataInformation.PositionEnd;

    Config.MaxColorBar = DataInformation.MaxColorBar;
    Config.MaxSpeed = DataInformation.MaxSpeed;

    if givenSpeed == 0 || givenSpeed == 60
        PlotAllTrajectory(Config, TrajectoryData); % speed: 0~100 km/h
        title(DataInformation.figTitle, 'FontSize', 15, 'Interpreter', 'none');
    end


    %% Edie's
    %%%%% Setting
    Config.Parallelogram.Lw = 100;  % long edge (meter)
    Config.Parallelogram.w = - WaveSpeed/3.6; % wave speed (m/s)
    Config.Parallelogram.H = 5;  % distance between two long edges
    Config.Parallelogram.area = Config.Parallelogram.Lw * Config.Parallelogram.H; % area of the parallelogram

    Config.wCV = 0.5;
    Config.wNAE = 0.5;



    %%    
    fprintf('speed= %d\n', givenSpeed);

    %% get information of a parallelogram
    center_initial.x = 0; center_initial.y = 0;
    [corners_initial, extents_initial, T_inv] = GetParallelogram(Config, center_initial, givenSpeed);
    Config.Parallelogram.InsideTrajectory_Time = corners_initial(4,1) - corners_initial(1,1);
    Config.Parallelogram.InsideTrajectory_Distance = corners_initial(4,2) - corners_initial(1,2);
           

    %%        
    CandidateCenters = SelectCandidateCenters(TrajectoryData, givenSpeed);


    %% select qualified parallelograms
    nCandidates = size(CandidateCenters, 1);
    SelectedParallelogram_Speed = {};

    AllCandidateParallelogram = {};
    k=0;
    for i = 1:nCandidates

        center.x = CandidateCenters(i, 2);
        center.y = CandidateCenters(i, 3);
        corners  = GetParallelogram(Config, center, givenSpeed);

        if all(corners(:,1) > Config.TimeStart) && all(corners(:,1) <= Config.TimeEnd) && all(corners(:,2) > Config.PositionStart) && all(corners(:,2) <= Config.PositionEnd)

            Flag_NoOverlap2 = IsOutsideAllParallelograms(corners, SelectedParallelogram_Speed);            
            if Flag_NoOverlap2 
                
                CandidateParallelogram = MatchPoints(center, corners, extents_initial, T_inv, TrajectoryData); 
                [CV, NAE, SCORE] = GetScoreOfSpeedInParallelogram(Config, CandidateParallelogram, givenSpeed);
                if givenSpeed == 0
                    PlotParallelogram_UniColor(CandidateParallelogram);
                end

                k=k+1;
                AllCandidateParallelogram{k,1} = [center.x center.y];
                AllCandidateParallelogram{k,2} = corners;
                AllCandidateParallelogram{k,3} = CandidateParallelogram;
                AllCandidateParallelogram{k,4} = CV;
                AllCandidateParallelogram{k,5} = NAE;                
                AllCandidateParallelogram{k,6} = SCORE;    

            end     
            
        end           

    end




    %%
    fig = figure;
    
    if isempty(AllCandidateParallelogram)
    
        text(2.5, 0.8, 'I got nothing', ...
            'FontSize', 50, ...
            'FontWeight', 'bold');        
    
    else
        CV_all = cell2mat(AllCandidateParallelogram(:,4));
        NAE_all = cell2mat(AllCandidateParallelogram(:,5));
        SCORE_all = cell2mat(AllCandidateParallelogram(:,6));
        
        CV_all    = CV_all(:);
        SCORE_all = SCORE_all(:);
        NAE_all   = NAE_all(:);
    
        % 排序
        [SCORE_sorted, sort_idx] = sort(SCORE_all);
        CV = CV_all(sort_idx);
        NAE = NAE_all(sort_idx);
        
        x = 1:length(CV);
        
        % 主图
        plot(x, NAE, 'o', 'Color', 'b'); hold on;
        plot(x, CV, 'o', 'Color', 'r'); hold on;
        plot(x, SCORE_sorted, '.-', 'Color', 'k'); hold on;    
    
        legend('NAE', 'CV', 'Score', 'Location', 'northwest', 'box', 'off');
    
        xlim([0 500]);
        ylim([0 2]);
        xlabel('Candidate Parallelogram');
        ylabel('Value');
        set(gca, 'FontSize', 25);
        grid on;
    
        %% inset figure
        if givenSpeed >=10
            ax1 = gca;  
            ax2 = axes('Position',[0.5 0.5 0.35 0.35]);  
            box on; hold on;
        
            plot(x, NAE, 'o', 'Color', 'b');
            plot(x, CV, 'o', 'Color', 'r');
            plot(x, SCORE_sorted, '.-', 'Color', 'k');
            grid on;
        
            xlim([0 100]);
            xticks(0:25:100);  
    
            if strcmp(whichSite, 'TRJ_11') && givenSpeed ==60
                ylim([0 0.03]);
                yticks(0:0.01:0.03);                  
            end
    
            if strcmp(whichSite, 'TRJ_11') && givenSpeed ==40
                ylim([0 0.04]);
                yticks(0:0.01:0.04);                  
            end            
    
            if strcmp(whichSite, 'TRJ_11') && givenSpeed ==30
                ylim([0 0.06]);
                yticks(0:0.02:0.06);                  
            end      
    
            if strcmp(whichSite, 'TRJ_11') && givenSpeed ==20
                ylim([0 0.1]);
                yticks(0:0.05:0.1);                  
            end       

            if strcmp(whichSite, 'TRJ_11') && givenSpeed ==10
                ylim([0 0.25]);
                yticks(0:0.05:0.25);                  
            end                         
    

            %%%%
            if strcmp(whichSite, 'US101') && givenSpeed ==30
                ylim([0 0.12]);
                yticks(0:0.05:0.1);                  
            end
    
            if strcmp(whichSite, 'US101') && givenSpeed ==10
                ylim([0 0.3]);
                yticks(0:0.1:0.3);  
            end            
    
        
            set(gca, 'FontSize', 20);
        end
    end

 


end








    

