addpath('Modules/');   
addpath('Algorithms/');  
%--------------------------------------------------------------------------------------------------------
%%                                            Define the environment
%-------------------------------------------------------------------------------------------------------

Horizon = 4000; %Overall number of interaction with the environment
NbrArms = 4;
environment = zeros(Horizon,NbrArms);  
for k = 1:NbrArms;
    sinevect=(1/2).*(ones(1,Horizon)+sin([pi/NbrArms*(k-1):4*pi/(Horizon-1):4*pi+pi/NbrArms*(k-1)]));
    environment(:,k) = sinevect';
end


%---------------------------------------------------------------
%---------------------------------------------------------------
%%               Running options
%--------------------------------------------------------------
NbrRuns = 100;

MatrixgainEXP3     = [];
MatrixgainAPS      = [];
MatrixgainTS       = [];
MatrixgainUCB      = [];
%----------------------------------------------------------
%%           Launching the adversarial bandits
%---------------------------------------------------------------
for run = 1:NbrRuns;
    display(run)
    [gainEXP3, ArmsPlayedEXP3] = Exp3(environment, 1); 
    [gainAPS, ArmsPlayedAPS] = APS(environment, 0.2);     
    [gainTS, ArmsPlayedTS] = ThompsonSampling(environment, 10,1);  
    [gainUCB, ArmsPlayedUCB] = UCB1(environment);  
   
    % ---------Result storage----------------------------
    
    MatrixgainEXP3           = [MatrixgainEXP3; gainEXP3];
    MatrixgainAPS            = [MatrixgainAPS; gainAPS]; 
    MatrixgainTS             = [MatrixgainTS; gainTS];
    MatrixgainUCB            = [MatrixgainUCB; gainUCB];
end
%---------------------------------------------------------------------------------------------------
%%                                            PLOTTING THE RESULTS
%--------------------------------------------------------------------------------------------------           

plottingNonStationaryRegret(environment, MatrixgainAPS,    [1 0 0],0,2);
plottingNonStationaryRegret(environment, MatrixgainEXP3,   [0 1 0],1,2);
plottingNonStationaryRegret(environment, MatrixgainTS,     [0 0 1],1,2);
plottingNonStationaryRegret(environment, MatrixgainUCB,    [0 0.3 0],1,2);


%%                                           PLOTTING DYNAMIC REGRET
%--------------------------------------------------------------------------------------------------           
legend('APS','EXP3','TS', 'UCB1')
grid on;
bestarm=ones(1,Horizon);
for t=1:Horizon
    bestarm(t)=PickingMaxIndexArm(environment(t,:));
end
