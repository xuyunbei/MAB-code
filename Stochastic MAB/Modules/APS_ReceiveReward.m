function [w, gainAPS, ArmsPlayed] = APS_ReceiveReward(w, p,reward, K, gamma, ArmChosen, gainAPS, ArmsPlayed)
    if((reward ==0) + (reward ==1) ~= 1)
        error('Reward must be either 0 or 1');
    end
    gainAPS = [gainAPS reward];
    ArmsPlayed = [ArmsPlayed ArmChosen];
    w_pre=w(ArmChosen);
    if (reward==1)                
        w(ArmChosen) = (1-exp(-gamma))/(1-exp(-gamma/w_pre));
    else
        w(ArmChosen) = (exp(gamma)-1)/(exp(gamma/w_pre)-1);
    end
    for i=1:K
        if (i~=ArmChosen)
            w(i) = max(w(i)*(1-w(ArmChosen))/(1-w_pre),0.001);
        end
    end
end