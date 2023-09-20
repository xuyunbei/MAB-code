% gamma: exploration rate (Default value = 0.05)
%% Outputs:
% gainAPS: vector of observations for each time step

function [gainAPS, ArmsPlayed] = APS(environment, Horizon, gamma)


K = length(environment); % Nbr Arms

if nargin == 2;
    gamma = 0.05; % Exploration Rate
end

%---------------------------------------------------------------------------------------------------
%%                                            INITIALIZATION
%--------------------------------------------------------------------------------------------------

[w, gainAPS, ArmsPlayed] = APS_Initialize(K); % Initialize the vector weight w

%---------------------------------------------------------------------------------------------------
%%                                            INTERACTION
%--------------------------------------------------------------------------------------------------

for t = 1:Horizon
    [ArmToPlay, p] = APS_RecommendArm(w, gamma);
    reward = rand() < environment(ArmToPlay);
    [w, gainAPS, ArmsPlayed] = APS_ReceiveReward(w, p, reward, K, gamma, ArmToPlay, gainAPS, ArmsPlayed);
end


            