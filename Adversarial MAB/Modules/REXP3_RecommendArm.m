function [ArmToPlay, p, w] = REXP3_RecommendArm(w, gamma, t, batchSize)
    K = length(w);
    if t/batchSize - floor(t/batchSize) == 0
        w =  ones(1,K)/K;
    end
    c = 0;
    p = (1-c)*w/sum(w)+c/K;
    Proba = cumsum(p);
    ArmToPlay = Proba > rand();
    ArmToPlay = find(ArmToPlay == 1,1,'first');
end