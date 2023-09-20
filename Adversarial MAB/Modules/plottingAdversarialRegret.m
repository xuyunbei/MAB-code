function plottingAdversarialRegret(environment,Matrixgain,col, holding, width)

[NbrRuns,Horizon] = size(Matrixgain);

regret = [];

for run = 1:NbrRuns;
    regret = [regret; max(cumsum(environment)')- cumsum(Matrixgain(run,:))]; %best arm in hindsight
end
if holding == 0
   figure; 
   grid on
else
    hold on
end
plot(mean(regret,1),'Color',col, 'LineWidth',width);
xlabel('Time Step')
ylabel('Expected Regret')
set(gca,'FontSize',14,'fontWeight','bold','fontName','caladea')