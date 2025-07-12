function CandidateCenters = SelectCandidateCenters(TrajectoryData, givenSpeed)
    
    % Initialize speed tolerance
    ToleranceSpeed = 0;
    
    % Maximum tolerance threshold (to avoid infinite loop)
    maxTolerance = 5;

    stepOfChangeTolerance = 1;
    
    % Initialize number of candidate points
    CandidateCenters = [];
    
    % Gradually increase tolerance until enough candidates are found
    while ToleranceSpeed <= maxTolerance
        selectedRows = abs(TrajectoryData(:,4) - givenSpeed) <= ToleranceSpeed;
        CandidateCenters = TrajectoryData(selectedRows, :);
        numCandidates = size(CandidateCenters, 1);
        
        if numCandidates >= 1000
            break;
        end
        
        % Increase tolerance step (adjustable)
        ToleranceSpeed = ToleranceSpeed + stepOfChangeTolerance;
    end
    
    % Output result (optional)
    % fprintf('Final tolerance: %.2f, Candidate count: %d\n', ToleranceSpeed, numCandidates);
    
    % ******** [sensitivity analysis] *********
    % Shuffle the order of CandidateCenters 
    numCandidates = size(CandidateCenters, 1);           % Number of candidate rows
    randomOrder = randperm(numCandidates);               % Generate a random permutation
    CandidateCenters = CandidateCenters(randomOrder, :); % Reorder rows randomly     

end