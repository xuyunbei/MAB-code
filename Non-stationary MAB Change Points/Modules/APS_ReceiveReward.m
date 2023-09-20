function [w, gainAPS] = APS_ReceiveReward(w, p,reward, K, gamma, ArmChosen, gainAPS)
    if((reward ==0) + (reward ==1) ~= 1)
        error('Reward must be either 0 or 1');
    end
    gainAPS = [gainAPS reward];
    w_pre=w(ArmChosen);
    if (reward==1)                
        w(ArmChosen) = (1-exp(-gamma))/(1-exp(-gamma/w_pre));
    else
        w(ArmChosen) = (exp(gamma)-1)/(exp(gamma/w_pre)-1);
    end
    for i=1:K
        if (i~=ArmChosen)
            w(i) = w(i)*(1-w(ArmChosen))/(1-w_pre);
        end
    end
    c=0.001;
    w = (1-c)*w/sum(w)+c/K;
end