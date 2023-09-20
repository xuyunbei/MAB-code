addpath('Modules/');   
addpath('Algorithms/');  
%----------------------------------------------------------
%%              Define the environment
%----------------------------------------------------------
environment = [0.9 0.9 0.9 0.9 0.5, 0.5, 0.5, 0.5, 0.3, 0.3 0.3, 0.3, 0.2, 0.2 0.2, 0.2];
Horizon = 2000; %Overall number of interaction with the environment

%--------------------------------------------------------------
%%               Running options
%--------------------------------------------------------------
NbrRuns = 100;

MatrixArmsPlayedAPS      = [];
MatrixArmsPlayedTS       = [];
MatrixArmsPlayedUCB1     = [];
 
%----------------------------------------------------------
%%                Launching the stochastic bandits
%----------------------------------------------------------
for run = 1:NbrRuns;
    display(run)
    [~, ArmsPlayedAPS] = APS(environment, Horizon, 0.5); 
    [~, ArmsPlayedTS] = ThompsonSampling(environment, Horizon, 0.5, 1);
    [~, ArmsPlayedUCB1] = UCB1(environment, Horizon);
    
    % ---------Result storage----------------------------
    
    MatrixArmsPlayedAPS      = [MatrixArmsPlayedAPS; ArmsPlayedAPS];
    MatrixArmsPlayedTS       = [MatrixArmsPlayedTS; ArmsPlayedTS];
    MatrixArmsPlayedUCB1     = [MatrixArmsPlayedUCB1; ArmsPlayedUCB1];

end
%-----------------------------------------------------------
%%             Plotting the results
%-----------------------------------------------------------

plottingStochasticRegret(environment, MatrixArmsPlayedAPS,     [1 0 0], 0, 2);
plottingStochasticRegret(environment, MatrixArmsPlayedTS,      [0 0 1], 1, 2);
plottingStochasticRegret(environment, MatrixArmsPlayedUCB1,    [0 0.3 0], 1, 2);
legend('APS','TS','UCB 1')
grid on;