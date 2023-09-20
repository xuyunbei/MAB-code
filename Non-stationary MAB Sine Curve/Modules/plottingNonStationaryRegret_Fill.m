function plottingNonStationaryRegret_Fill(environment,Matrixgain,Matrixgain_2, col, holding)

[NbrRuns,Horizon] = size(Matrixgain);

regret = [];
regret_2 = [];

for run = 1:NbrRuns;
    regret = [regret; cumsum(max(environment'))- cumsum(Matrixgain(run,:))]; %best strategy in hindsight
    regret_2 = [regret_2; cumsum(max(environment'))- cumsum(Matrixgain_2(run,:))];
end
if holding == 0
   figure; 
   grid on
else
    hold on
end
curve = mean(regret,1);
curve_2 = mean(regret_2,1);
x = 1:Horizon;
h = plot(x,curve,'Color',col, 'LineWidth',2);
% the following line skip the name of the previous plot from the legend
h.Annotation.LegendInformation.IconDisplayStyle = 'off';
hold on;
h_2 = plot(x,curve_2, 'Color', col, 'LineWidth',2);
% the following line skip the name of the previous plot from the legend
h_2.Annotation.LegendInformation.IconDisplayStyle = 'off';
x_2 = [1:Horizon, fliplr(x)];
inBetween = [curve, fliplr(curve_2)];
fill(x_2, inBetween, col, 'FaceAlpha', 0.5)
xlabel('Time Step')
ylabel('Expected Regret')
set(gca,'FontSize',14,'fontWeight',...
    'bold', 'fontName','caladea')
