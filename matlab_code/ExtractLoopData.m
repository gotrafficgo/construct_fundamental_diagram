function LoopSpeedCell = ExtractLoopData(AllPoints, LoopLocation, startTime, endTime, timeInterval)

    % Generate time bins
    timeEdges = startTime:timeInterval:endTime;
    numBins = length(timeEdges) - 1;

    % Initialize output cell matrix
    LoopSpeedCell = cell(numBins, 2);
    for i = 1:numBins
        LoopSpeedCell{i, 1} = [timeEdges(i), timeEdges(i+1)];  % [start, end]
        LoopSpeedCell{i, 2} = [];  % Empty array to store speeds
    end

    % Get unique vehicle IDs
    vehIDs = unique(AllPoints(:,1));

    for i = 1:length(vehIDs)
        vehID = vehIDs(i);
        vehRows = AllPoints(AllPoints(:,1) == vehID, :);
        [~, sortIdx] = sort(vehRows(:,2));
        vehRows = vehRows(sortIdx, :);

        for j = 1:(size(vehRows, 1)-1)
            pos1 = vehRows(j, 3);
            pos2 = vehRows(j+1, 3);

            if pos1 < LoopLocation && pos2 >= LoopLocation
                t1 = vehRows(j, 2);
                t2 = vehRows(j+1, 2);
                delta_x = pos2 - pos1;
                delta_t = t2 - t1;

                if delta_x > 0 && delta_t > 0
                    % Estimate crossing time and speed
                    t_cross = t1 + (LoopLocation - pos1) / delta_x * delta_t;
                    speed = delta_x / delta_t;

                    % Locate which interval this t_cross falls into
                    binIdx = find(t_cross >= timeEdges(1:end-1) & t_cross < timeEdges(2:end), 1);
                    if ~isempty(binIdx)
                        LoopSpeedCell{binIdx, 2}(end+1, 1) = speed;
                    end
                end
            end
        end
    end
end

