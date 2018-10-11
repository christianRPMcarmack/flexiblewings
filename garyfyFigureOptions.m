function opts=garyfyFigureOptions()
% function opts=garyfyFigureOptions()
%
% Function that contains defaults plot options for the garyfyFigure()
% function. It cna also be called separately to return an options structure
% that can be later modified and used with garyfyFigure().
%
% The options structure contains the following fields:
% opts.TickMarkFontSize
% opts.TickMarkFontWeight                                            %% NEW - to change put ''bold'' or ''normal''
% opts.AxesLabelFontSize
% opts.AxesLabelFontWeight                                           %% NEW - to change put ''bold'' or ''normal''
% opts.TitleFontSize
% opts.TitleFontWeight                                               %% NEW - to change put ''bold'' or ''normal''
% opts.LegendFontSize
% opts.LegendFontWeight                                              %% NEW - to change put ''bold'' or ''normal''
% opts.LegendLocation
% opts.LineWidth
% opts.MarkerSize
%
% AAO 09/14/2011 -Initial coding

%% Tick Mark Options
opts.TickMarkFontSize=15;
opts.TickMarkFontWeight = 'bold';                                    %% NEW - to change put ''bold'' or ''normal''

%% Axes Options
opts.AxesLabelFontSize=15;                                 
opts.AxesLabelFontWeight='normal';                                   %% NEW - to change put ''bold'' or ''normal''

%% Title Options
opts.TitleFontSize=10;% added DKS 1/17
opts.TitleFontWeight = 'bold';                                       %% NEW - added title font weight
%% Legend Options
opts.LegendFontSize=12;
opts.LegendFontWeight='bold';                                        %% NEW - to change put ''bold'' or ''normal''
opts.LegendLocation = 'Best';

%% Plot Line and Marker Options
opts.LineWidth=2;
opts.MarkerSize=10;

end