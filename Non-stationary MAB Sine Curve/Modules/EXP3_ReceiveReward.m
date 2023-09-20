function [w, gainEXP3, ArmsPlayed] = EXP3_ReceiveReward(w, p,reward, K, gamma, ArmChosen, gainEXP3, ArmsPlayed)
    if((reward <0) + (reward >1) ~= 0)
        error('Reward must be between 0 and 1');
    end
    gainEXP3 = [gainEXP3 reward];
    ArmsPlayed = [ArmsPlayed ArmChosen];
    reward = reward/p(ArmChosen);
    w(ArmChosen) = w(ArmChosen)*exp(gamma*reward/K);
    c=0.01;
    w = (1-c)*w/sum(w)+c/K*ones(1,K);  
end