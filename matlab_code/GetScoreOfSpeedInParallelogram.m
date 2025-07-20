function [CV, NAE, SCORE] = GetScoreOfSpeedInParallelogram(Config, aCandidateParallelogram, givenSpeed)

    AllSpeed = aCandidateParallelogram{1,2}(:,4);

    %% Metric 1: Coefficient of Variance
    stdSpeed = std(AllSpeed);
    meanSpeed = mean(AllSpeed);
    CV = stdSpeed/meanSpeed;  

    
    %% Metric 2: NAE
    epsilon = 1e-3;  % small constant to avoid divide-by-zero
    AllSpeed = AllSpeed(:);  % ensure column vector

    numerators = abs(AllSpeed - givenSpeed);
    denominators = max([abs(AllSpeed), abs(givenSpeed) * ones(size(AllSpeed)), epsilon * ones(size(AllSpeed))], [], 2);

    NAE = mean(numerators ./ denominators);


    %% Metric 3: score
    CV_max =1; NAE_max= 1;
    CV_norm  = CV / CV_max;
    NAE_norm = NAE / NAE_max;

    SCORE = Config.wCV * CV_norm + Config.wNAE * NAE_norm;
        
end