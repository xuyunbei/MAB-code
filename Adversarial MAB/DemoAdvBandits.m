addpath('Modules/');   
addpath('Algorithms/');  
%--------------------------------------------------------------------------------------------------------
%%                                            Define the environment
%-------------------------------------------------------------------------------------------------------

Horizon = 2000; %Overall number of interaction with the environment
NbrArms = 16;
RGB = imread('JacksonPollock.jpg'); 
IMG = rgb2gray(RGB); 
M = IMG(50*[1:16], [11:2010]);
environment= reshape(rescale(M), Horizon, NbrArms); % environment = Matrix of size Horizon x NbrArms
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
    gainEXP3 = Exp3(environment, 5); 
    gainAPS = APS(environment, 1); 
    
    % ---------Result storage----------------------------
    
    MatrixgainEXP3           = [MatrixgainEXP3; gainEXP3];
    MatrixgainAPS            = [MatrixgainAPS; gainAPS];

end
%---------------------------------------------------------------------------------------------------
%%                                            PLOTTING THE RESULTS
%--------------------------------------------------------------------------------------------------           

plottingAdversarialRegret(environment, MatrixgainAPS,  [1 0 0], 0, 2); 
plottingAdversarialRegret(environment, MatrixgainEXP3, [0 1 0], 1, 2); 
legend('APS','EXP3')

grid on;
