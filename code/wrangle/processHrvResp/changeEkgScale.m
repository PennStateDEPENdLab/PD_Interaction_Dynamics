function changeEkgScale(x)
%
%
%

global EKG;

if x < 0 
    EKG.plot.widthTime = round(EKG.plot.widthTime/2); 
else
    EKG.plot.widthTime = min(EKG.plot.widthTime*2,EKG.plot.maxTime); 
end
EKG.plot.incrLR = (EKG.plot.endTime-EKG.plot.startTime);  % 1% of plot width
drawEkgPlot;
drawIbiPlot;

