function CandidateParallelogram_Speed = RemoveOutlierParallelogram(CandidateParallelogram_Speed)

    % Assume CandidateParallelogram_Speed is a cell array with N rows
    % Column 2 of each row contains a matrix of points
    
    N = size(CandidateParallelogram_Speed, 1);  % Total number of candidates
    
    % Step 1: Extract the number of points (rows) in the 2nd column for each row
    point_counts = zeros(N,1);  % Preallocate array
    for i = 1:N
        point_counts(i) = size(CandidateParallelogram_Speed{i,2}, 1);  % Count rows of data in column 2
    end
    
    % Step 2: Use IQR method to detect outliers in point counts
    Q1 = prctile(point_counts, 25);  % 25th percentile
    Q3 = prctile(point_counts, 75);  % 75th percentile
    IQR_val = Q3 - Q1;               % Interquartile range
    
    lower_bound = Q1 - 1.5 * IQR_val;  % Lower threshold for outliers
    upper_bound = Q3 + 1.5 * IQR_val;  % Upper threshold for outliers
    
    % Find indices of outliers (rows where point count is outside bounds)
    outlier_idx = find(point_counts < lower_bound | point_counts > upper_bound);
    
    % Step 3: Remove outlier rows from the original cell array
    CandidateParallelogram_Speed(outlier_idx, :) = [];
    
    % Optional: display how many outliers were removed
    fprintf(', %d outliers\n', length(outlier_idx));

end

