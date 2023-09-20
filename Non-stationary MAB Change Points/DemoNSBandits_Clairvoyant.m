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

MatrixgainAPS      = [];
MatrixgainREXP3    = []; 
%MatrixgainRAPS     = [];
MatrixgainRTS      = [];
MatrixgainRUCB1     = [];

%----------------------------------------------------------
%%           Launching the adversarial bandits
%---------------------------------------------------------------
for run = 1:NbrRuns;
    display(run)
    gainAPS = APS(environment, 0.5);
    gainREXP3 = RExp3(environment, batchSize, 0.5);
    %gainRAPS = RAPS(environment, batchSize, 0.5);
    c=1;
    gainRTS = [ThompsonSampling(BernoulliMeansMatrix(1,:), batchSize, c, 1) ThompsonSampling(BernoulliMeansMatrix(2,:), batchSize, c, 1) ThompsonSampling(BernoulliMeansMatrix(3,:), batchSize, c, 1) ThompsonSampling(BernoulliMeansMatrix(4,:), batchSize, c, 1)];
    gainRUCB1 = [UCB1(BernoulliMeansMatrix(1,:), batchSize) UCB1(BernoulliMeansMatrix(2,:), batchSize) UCB1(BernoulliMeansMatrix(3,:), batchSize) UCB1(BernoulliMeansMatrix(4,:), batchSize)];
    
    % ---------Result storage----------------------------
    
    MatrixgainAPS            = [MatrixgainAPS; gainAPS];
    MatrixgainREXP3          = [MatrixgainREXP3; gainREXP3];
    %MatrixgainRAPS           = [MatrixgainRAPS; gainRAPS];
    MatrixgainRTS            = [MatrixgainRTS; gainRTS];
    MatrixgainRUCB1          = [MatrixgainRUCB1; gainRUCB1];

end

%---------------------------------------------------------------------------------------------------
%%                                            PLOTTING THE RESULTS
%--------------------------------------------------------------------------------------------------           

plottingNonStationaryRegret(environment, MatrixgainAPS,     [1 0 0],0,4);
%plottingNonStationaryRegret(environment, MatrixgainRAPS,    [250/255, 128/255, 114/255],1,2);
plottingNonStationaryRegret(environment, MatrixgainRUCB1,   [0, 0.3, 0],1,2);
plottingNonStationaryRegret(environment, MatrixgainRTS,     [0 0 1],1,2);
plottingNonStationaryRegret(environment, MatrixgainREXP3,   [0, 1, 0],1,2);

         

legend('APS','Restarted UCB1','Restarted TS', 'Restarted EXP3')

grid on;
