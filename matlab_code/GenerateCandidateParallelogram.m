function QualifiedCandidateParallelogram = GenerateCandidateParallelogram(Config, givenSpeed, SelectedParallelogram_All, SelectedParallelogram_Speed, CandidateCenters)

    nCandidates = size(CandidateCenters, 1);
    QualifiedCandidateParallelogram = {}; 
    idx = 0;

    for i = 1:nCandidates

        center.x = CandidateCenters(i, 1);
        center.y = CandidateCenters(i, 2);
        corners = GetParallelogram(Config, center, givenSpeed);

        % Condition 1: Within the bounds of the time-space diagram
        if all(corners(:,1) > 0) && all(corners(:,1) <= Config.TimeMax) && all(corners(:,2) > 0) && all(corners(:,2) <= Config.RoadLength)

            % Condition 2: No overlap with existing parallelograms
            noOverlap1 = IsOutsideAllParallelograms(corners, SelectedParallelogram_All);
            noOverlap2 = IsOutsideAllParallelograms(corners, SelectedParallelogram_Speed);
            noOverlap3 = IsOutsideAllParallelograms(corners, QualifiedCandidateParallelogram);

            if noOverlap1 && noOverlap2 && noOverlap3
                idx = idx + 1;
                QualifiedCandidateParallelogram{idx, 1} = corners;
            end
        end
        
    end
end


