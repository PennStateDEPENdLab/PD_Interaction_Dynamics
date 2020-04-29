function initEkgControl


screen_size = get(0, 'ScreenSize');
screen_width = screen_size(3);
screen_height = screen_size(4);

% h0 = figure('Color',[0.92 0.86 0.78], ...
h0 = figure('Color',[0.84 0.8 0.73], ...
   'CloseRequestFcn','exitEkg', ...
   'MenuBar','none', ...
   'Name','EkgControl', ...
   'NumberTitle','off', ...
   'Position',[screen_width-358 screen_height-430 350 400], ...
   'Resize','off', ...
   'Tag','FigureEkgControl');
h1 = uicontrol('Parent',h0, ...
    'Callback','invertEkgData', ...
    'FontSize',10, ...
    'Position',[10 365 90 30], ...
    'String','Invert EKG', ...
    'Tag','PushbuttonEkgInvert');
% threshold control panel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ht1 = uipanel('Parent',h0, ...
    'BackgroundColor',[0.84 0.8 0.73], ...
    'Position',[0.029 0.700 0.257 0.200], ...
    'Title','Threshold', ...
    'Tag','ThresholdPanel');
h1 = uicontrol('Parent',ht1, ...
    'Callback','moveThreshold(1)', ...
    'FontSize',10, ...
    'Position',[2 34 40 30], ...
    'String','Up', ...
    'Tag','moveThresholdUp');
h1 = uicontrol('Parent',ht1, ...
    'Callback','moveThreshold(-1)', ...
    'FontSize',10, ...
    'Position',[44 34 40 30], ...
    'String','Down', ...
    'Tag','moveThresholdDown');
h1 = uicontrol('Parent',ht1, ...
    'Callback','findPeaks', ...
    'FontSize',10, ...
    'Position',[2 5 84 30], ...
    'String','Find Peaks', ...
    'Tag','PushbuttonFindPeaks');
% EKG plot control panel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hekg1 = uipanel('Parent',h0, ...
    'BackgroundColor',[0.84 0.8 0.73], ...
    'Position',[0.029 0.488 0.257 0.200], ...
    'Title','EKG Plot', ...
    'Tag','ThresholdPanel');
h1 = uicontrol('Parent',hekg1, ...
    'Callback','changeEkgScale(-1)', ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'Position',[2 34 40 30], ...
    'String','<-->', ...
    'Tag','PushbuttonSpreadPeaks');
h1 = uicontrol('Parent',hekg1, ...
    'Callback','changeEkgScale(1)', ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'Position',[44 34 40 30], ...
    'String','-><-', ...
    'Tag','PushbuttonSqueezePeaks');
h1 = uicontrol('Parent',hekg1, ...
    'Callback','moveEkgScale(-1)', ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'Position',[2 5 20 30], ...
    'String','<', ...
    'Tag','PushbuttonMoveLeft');
h1 = uicontrol('Parent',hekg1, ...
    'Callback','moveEkgScale(1)', ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'Position',[64 5 20 30], ...
    'String','>', ...
    'Tag','PushbuttonMoveRight');
% Peak control panel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hpeak1 = uipanel('Parent',h0, ...
    'BackgroundColor',[0.84 0.8 0.73], ...
    'Position',[0.029 0.200 0.257 0.275], ...
    'Title','Peaks', ...
    'Tag','PeaksPanel');
h1 = uicontrol('Parent',hpeak1, ...
    'Callback','addPeak(-1)', ...
    'FontSize',10, ...
    'Position',[2 67 84 30], ...
    'String','Add Left', ...
    'Tag','PushbuttonAddLeft');
h1 = uicontrol('Parent',hpeak1, ...
    'Callback','addPeak(1)', ...
    'FontSize',10, ...
    'Position',[2 36 84 30], ...
    'String','Add Right', ...
    'Tag','PushbuttonAddRight');
h1 = uicontrol('Parent',hpeak1, ...
    'Callback','deletePeak', ...
    'FontSize',10, ...
    'Position',[2 5 84 30], ...
    'String','Delete Peak', ...
    'Tag','PushbuttonDeletePeak');
% Move Peak control panel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hmvpeak1 = uipanel('Parent',h0, ...
    'BackgroundColor',[0.84 0.8 0.73], ...
    'Position',[0.343 0.700 0.257 0.200], ...
    'Title','Move Peak', ...
    'Tag','MovePeakPanel');
h1 = uicontrol('Parent',hmvpeak1, ...
    'Callback','movePeak(4)', ...
    'FontSize',10, ...
    'Position',[5 5 40 30], ...
    'String','Left', ...
    'Tag','PushbuttonLeft');
h1 = uicontrol('Parent',hmvpeak1, ...
    'Callback','movePeak(6)', ...
    'FontSize',10, ...
    'Position',[46 5 40 30], ...
    'String','Right', ...
    'Tag','PushbuttonRight');
h1 = uicontrol('Parent',hmvpeak1, ...
    'Callback','movePeak(8)', ...
    'FontSize',10, ...
    'Position',[5 36 40 30], ...
    'String','Up', ...
    'Tag','PushbuttonUp');
h1 = uicontrol('Parent',hmvpeak1, ...
    'Callback','movePeak(2)', ...
    'FontSize',10, ...
    'Position',[46 36 40 30], ...
    'String','Down', ...
    'Tag','PushbuttonDown');
% Move HF_lower control panel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hmvHFL1 = uipanel('Parent',h0, ...
    'BackgroundColor',[0.84 0.8 0.73], ...
    'Position',[0.343 0.573 0.257 0.120], ...
    'Title','Move HF_lower', ...
    'Tag','MoveHFLPanel');
h1 = uicontrol('Parent',hmvHFL1, ...
    'Callback','moveHF(1)', ...
    'FontSize',10, ...
    'Position',[5 5 40 30], ...
    'String','Down', ...
    'Tag','PushbuttonUp');
h1 = uicontrol('Parent',hmvHFL1, ...
    'Callback','moveHF(2)', ...
    'FontSize',10, ...
    'Position',[46 5 40 30], ...
    'String','Up', ...
    'Tag','PushbuttonDown');
% Move HF_upper control panel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hmvHFU1 = uipanel('Parent',h0, ...
    'BackgroundColor',[0.84 0.8 0.73], ...
    'Position',[0.343 0.451 0.257 0.120], ...
    'Title','Move HF_upper', ...
    'Tag','MoveHFLPanel');
h1 = uicontrol('Parent',hmvHFU1, ...
    'Callback','moveHF(3)', ...
    'FontSize',10, ...
    'Position',[5 5 40 30], ...
    'String','Down', ...
    'Tag','PushbuttonUp');
h1 = uicontrol('Parent',hmvHFU1, ...
    'Callback','moveHF(4)', ...
    'FontSize',10, ...
    'Position',[46 5 40 30], ...
    'String','Up', ...
    'Tag','PushbuttonDown');
% RSP panel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hmvRSP = uipanel('Parent',h0, ...
    'BackgroundColor',[0.84 0.8 0.73], ...
    'Position',[0.343 0.251 0.257 0.120], ...
    'Title','Respiratory', ...
    'Tag','Respiratory');
h1 = uicontrol('Parent',hmvRSP, ...
    'Callback','Resp', ...
    'FontSize',10, ...
    'Position',[5 5 40 30], ...
    'String','Plot', ...
    'Tag','PushbuttonResp');
% Save panel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hbg1 = uipanel('Parent',h0, ...
    'BackgroundColor',[0.84 0.8 0.73], ...
    'Position',[0.029 0.0025 0.583 0.129], ...
    'Title','Save', ...
    'Tag','SavePanel');
h1 = uicontrol('Parent',hbg1, ...
    'Callback','saveIbis', ...
    'FontSize',10, ...
    'Position',[4 5 90 30], ...
    'String','IBIs', ...
    'Tag','SaveIbisbutton');
h1 = uicontrol('Parent',hbg1, ...
    'Callback','saveIbiSpline', ...
    'FontSize',10, ...
    'Position',[106 5 90 30], ...
    'String','IBIspline', ...
    'Tag','SaveIbiSplinebutton');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hrv1 = uipanel('Parent',h0, ...
    'BackgroundColor',[0.84 0.8 0.73], ...
    'Position',[0.628 0.6025 0.357 0.385], ...
    'Title','HRV', ...
    'Tag','HrvPanel');
h1 = uicontrol('Parent',hrv1, ...
    'Style','edit', ...
    'FontSize',10, ...
    'Position',[55 103 60 30], ...
    'String','', ...
    'Tag','LfEditBox');
h1 = uicontrol('Parent',hrv1, ...
    'BackgroundColor',[0.84 0.8 0.73], ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'HorizontalAlignment','center', ...    
    'Position',[2 95 50 30], ...
    'String','LF:', ...
    'Style','text', ...
    'Tag','StaticTextLF');
h1 = uicontrol('Parent',hrv1, ...
    'Style','edit', ...
    'FontSize',10, ...
    'Position',[55 70 60 30], ...
    'String','', ...
    'Tag','HfEditBox');
h1 = uicontrol('Parent',hrv1, ...
    'BackgroundColor',[0.84 0.8 0.73], ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'HorizontalAlignment','center', ...    
    'Position',[2 64 50 30], ...
    'String','HF:', ...
    'Style','text', ...
    'Tag','StaticTextHF');
h1 = uicontrol('Parent',hrv1, ...
    'Style','edit', ...
    'FontSize',10, ...
    'Position',[55 37 60 30], ...
    'String','', ...
    'Tag','LfHfEditBox');
h1 = uicontrol('Parent',hrv1, ...
    'BackgroundColor',[0.84 0.8 0.73], ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'HorizontalAlignment','center', ...    
    'Position',[2 33 50 25], ...
    'String','LF/HF:', ...
    'Style','text', ...
    'Tag','StaticTextLFHF');
h1 = uicontrol('Parent',hrv1, ...
    'Style','edit', ...
    'FontSize',10, ...
    'Position',[55 4 60 30], ...
    'String','', ...
    'Tag','HrEditBox');
h1 = uicontrol('Parent',hrv1, ...
    'BackgroundColor',[0.84 0.8 0.73], ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'HorizontalAlignment','center', ...    
    'Position',[2 2 50 25], ...
    'String','HR:', ...
    'Style','text', ...
    'Tag','StaticTextHR');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h1 = uicontrol('Parent',h0, ...
    'Callback','exitHrv', ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'Position',[280 10 60 30], ...
    'String','Exit', ...
    'Tag','Exitbutton');

