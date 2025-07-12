function AllParallelogram = GetTotalTravelTimeAndDistance(Config, AllParallelogram)

    for r = 1:1:size(AllParallelogram, 1)

        allPoints = AllParallelogram{r,2};

        % the number of the vehicles inside the parallelogram
        unique_vals = unique(allPoints(:, 1));  % [1; 2; 3]
        num_unique = numel(unique_vals);  
    
        % 
        TotalTime     = num_unique * Config.Parallelogram.InsideTrajectory_Time;      % second
        TotalDistance = num_unique * Config.Parallelogram.InsideTrajectory_Distance;  % meter
        TotalVehicle_Number = num_unique;  

        % area: sec * meter
        q = TotalDistance/Config.Parallelogram.area; %veh/s
        k = TotalTime/Config.Parallelogram.area;     %veh/m
        v = q/k; %m/s

        q = q*3600;
        k = k*1000;
        v = v*3.6;

        AllParallelogram{r, Config.col.total} = [TotalTime TotalDistance TotalVehicle_Number];
        AllParallelogram{r, Config.col.q} = q;
        AllParallelogram{r, Config.col.k} = k;
        AllParallelogram{r, Config.col.v} = v;
                
    end


end