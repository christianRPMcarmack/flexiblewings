function garyfyFigure(fh,opts)
% function garyfyFigure(fh,opts)
%
% garyfyFigure() modifies the thickness of the plot and legend
% lines as well as the text sizes for the axes labels, tick marks and the
% plot title for the desired plot without modifying MATLAB defaults. It can
% be used for any MATLAB plot, with or without subplots, regardless of how
% it is generated.
% 
% Inputs: 
% -fh: (optional,default=gcf) A numerical vector containing figure handles or
% the string 'all', describing the figures to be Gary-fied. 'all' option
% Gary-fies all currently open figures.
% -opts: (optional) A structure obtained from garyfyFigureOptions() 
% containing some of the figure parameters. If omitted, the default options
% structure from the garyfyFigureOptions() is used.
%
% Sample Use:
%   randomSystem=rss(2,2,2);
%   bodemag(randomSystem);
%   garyfyFigure(gcf);
%
% Updates: 
% - added font weight and line width
% AAO 09/14/2011 -Initial coding
%% Count Number of Figures                                           %% NEW - if the input is ''all'' the number of figures is replaced with vector of number of characters
if ischar(fh) && strcmp(fh,'all')                                    %% 
    nfigs = get(0,'Children');                                       %% 
    nfigs = length(nfigs);                                           %% 
    fh = linspace(1,nfigs,nfigs);                                    %% 
end
%%
if nargin<2; 
    opts=garyfyFigureOptions(); 
end
if nargin<1; 
    fh=gcf; 
end;

if ischar(fh) && strcmp(fh,'all')
    % potentially there are multiple figures to be "gary-fied"
    % call this function recursively
    figHandles = findall(0,'Type','figure');
    for k=1:numel(figHandles); garyfyFigure(figHandles(k),opts); end
    return;
elseif isnumeric(fh) && isvector(fh) && ~isscalar(fh)  
    for k=1:numel(fh); garyfyFigure(fh(k),opts); end
    return;
elseif isnumeric(fh) && isscalar(fh)
    % just a single call to this function, keep moving forward
else
   error('parameter fh should either be: ''all'' or a numerical vector of figure handles'); 
end    
% % % % % % %% Modify the tick markers
% % % % % % h = findall(fh,'Type','TickMark');
% % % % % % set(get(h),'fontWeight',opts.TickMarkFontWeight); %% NEW - added font weight
%% Modify line width and axes limits
% keyboard
% h = findall(fh,'Type','axes','Visible','on');
fhh = get(fh);
h = findall(fhh.Children,'Type','Axes','Visible','on');
% set(h,'LineWidth',opts.LineWidth);
set(h,'FontSize',opts.TickMarkFontSize);
set(h,'FontWeight',opts.TickMarkFontWeight);                         %% NEW - added font weight
for k=1:numel(h)
    h2=findall(h(k),'Type','Line');
    set(h2,'LineWidth',opts.LineWidth);  % modify line width
    set(h2,'MarkerSize',opts.MarkerSize);  % modify marker size
    
%     keyboard
%     % find the 'visible' data in the figure and adjust y axes limits
%     % based on these data
%     cxlim=get(h(k),'XLim'); % x axis limits of the current (sub)plot
%     ymin=Inf;
%     ymax=-Inf;
%     for k2=1:numel(h2);
%         xdata=get(h2(k2),'XData');
%         ydata=get(h2(k2),'YData');
%         idx=xdata>=cxlim(1) & xdata<=cxlim(2);
%         ymintemp=min(ydata(idx)); 
%         ymaxtemp=max(ydata(idx));
%         if ymintemp<ymin; ymin=ymintemp; end
%         if ymaxtemp>ymax; ymax=ymaxtemp; end
%     end
%     set(h(k),'YLim',[ymin-abs(ymin)/20 ymax+abs(ymax)/20]);
end

% h = findall(fh,'Type','Line');
% for k=1:numel(h)
%     h(k).LineWidth = 2;
% end


%% Modify X/Y/ZLabels and figure title both for visible and invisible axes
% This is required since since some function (for instance, bode() and
% bodemag()) functions rely on invisible handles to place multiple titles.
h = findall(fh,'Type','axes');
for k=1:numel(h)
    axisFields=get(h(k));
    if isfield(axisFields,'YLabel')
       set(get(h(k),'ZLabel'),'FontSize',opts.AxesLabelFontSize);
       set(get(h(k),'YLabel'),'FontSize',opts.AxesLabelFontSize); 
       set(get(h(k),'XLabel'),'FontSize',opts.AxesLabelFontSize);
       set(get(h(k),'Title'),'FontSize',opts.AxesLabelFontSize);  
       % Add font weight as well
       set(get(h(k),'ZLabel'),'FontWeight',opts.AxesLabelFontWeight);%% NEW
       set(get(h(k),'YLabel'),'FontWeight',opts.AxesLabelFontWeight);%% NEW 
       set(get(h(k),'XLabel'),'FontWeight',opts.AxesLabelFontWeight);%% NEW
       set(get(h(k),'Title'),'FontWeight',opts.TitleFontWeight);     %% NEW

    end
end    
%% Modify the legend(s)
% lh = findall(fh,'Type','axes','Tag','legend','Visible','on'); 
% set(lh,'Location',opts.LegendLocation); % modify the location of the legend
% elh = findall(lh,'Type','hggroup'); % handles to the lines in the legend
% tlh = findall(lh,'Type','text'); % handles to the text in the legend
% tlh = findall(lh,'FontSize');
% set(tlh,'FontSize',opts.LegendFontSize);
% set(cell2mat(get(elh,'Children')),'LineWidth',opts.LineWidth);  % LineWidth for lines in the legend

%compatible with Matlab 2015
lh = findall(fh,'Type','Legend');
if ~isempty(lh)
    lh.Location = opts.LegendLocation;
    lh.FontSize = opts.LegendFontSize;
    lh.FontWeight = opts.LegendFontWeight;
    % lh.LineWidth = opts.LineWidth;
end
%% EDIT THIS TO SAVE AS .PNG FILES
% SavePNG(fh);
end