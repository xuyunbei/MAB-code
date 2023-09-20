addpath('Modules/');   
addpath('Algorithms/');  
%--------------------------------------------------------------------------------------------------------
%%                                            Define the environment
%-------------------------------------------------------------------------------------------------------

BernoulliMeansMatrix = [0.9 0.9 0.9 0.9 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.3 0.3 0.3 0.3;...
                        0.2 0.2 0.2 0.2 0.5 0.5 0.5 0.5 0.9 0.9 0.9 0.9 0.3 0.3 0.3 0.3; ...
                        0.1 0.1 0.1 0.1 0.9 0.9 0.9 0.9 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2;...
                        0.3 0.3 0.3 0.3 0.5 0.5 0.5 0.5 0.4 0.4 0.4 0.4 0.4 0.4 0.4 0.4];
Horizon = 4000; %Overall number of interaction with the environment
environment= constructBernoulliMeansMatrix(BernoulliMeansMatrix, Horizon); % environment = Matrix of size Horizon x NbrArms
batchSize = 1000;
%---------------------------------------------------------------
%%               Running options
%--------------------------------------------------------------
NbrRuns = 100;

MatrixgainEXP3     = [];
MatrixgainAPS      = [];

%----------------------------------------------------------
%%           Launching the adversarial bandits
%---------------------------------------------------------------
for run = 1:NbrRuns;
    display(run)
    gainEXP3 = Exp3(environment, 0.5);
    gainAPS = APS(environment, 0.5);

    
    % ---------Result storage----------------------------
    
    MatrixgainEXP3           = [MatrixgainEXP3; gainEXP3];
    MatrixgainAPS            = [MatrixgainAPS; gainAPS];


end
%---------------------------------------------------------------------------------------------------
%%                                            PLOTTING THE RESULTS
%--------------------------------------------------------------------------------------------------           

plottingNonStationaryRegret(environment, MatrixgainAPS,     [1 0 0], 0, 2);
plottingNonStationaryRegret(environment, MatrixgainEXP3,    [0 1 0], 1, 2);



legend('APS','EXP3')

grid on;

