
%% Inputs: 
% environment: Matrix of size Horizon x NbrArms
% gamma: exploration rate (Default value = 0.05)
%% Outputs:
% gainAPS: vector of observations for each time step

function [gainAPS, ArmsPlayed] = APS(environment, gamma)


[Horizon, NbrArms] = size(environment);

if nargin == 1;
    gamma = 0.05; % Exploration Rate
end

%---------------------------------------------------------------------------------------------------
%%                                            INITIALIZATION
%--------------------------------------------------------------------------------------------------

[w, gainAPS] = EXP3_Initialize(NbrArms); % Initialize the vector weight w
ArmsPlayed = [];
%---------------------------------------------------------------------------------------------------
%%                                            INTERACTION
%--------------------------------------------------------------------------------------------------

for t = 1:Horizon
    [ArmToPlay, p] = EXP3_RecommendArm(w, gamma);
    reward = rand() < environment(t,ArmToPlay);
    [w, gainAPS, ArmsPlayed] = APS_ReceiveReward(w, p, reward, NbrArms, gamma, ArmToPlay, gainAPS, ArmsPlayed);
end


            