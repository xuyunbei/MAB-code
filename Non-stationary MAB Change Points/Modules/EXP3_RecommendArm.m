function [ArmToPlay, p] = EXP3_RecommendArm(w, gamma)
    K = length(w);
    c=0;
    p = (1-c)*w/sum(w) + c/K;
    Proba = cumsum(p);
    ArmToPlay = Proba > rand();
    ArmToPlay = find(ArmToPlay == 1,1,'first');
end