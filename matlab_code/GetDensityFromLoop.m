function density= GetDensityFromLoop(Speed_Interval, timeInterval)

    nonzeroSpeed = Speed_Interval(Speed_Interval ~= 0);
    totalInverseSum = sum(1 ./ nonzeroSpeed);

    density = totalInverseSum/timeInterval;

end