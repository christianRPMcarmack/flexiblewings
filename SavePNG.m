%% SavePNG.m
% 
% Inputs: figure(s) which to save 
% Outputs: saves figures
%
% Created: 5-23-2017
% Authors: Christian Carmack
%
% NOTE: Matlab will not open these .pngs you must use file explorer
function SavePNG(nf)
% 'all' input is all figures
    if ischar(nf) && strcmp(nf,'all')   % if the input is 'all' it goes through each and saves each                                 %% 
        nfigs = get(0,'Children');                                       %% 
        nfigs = length(nfigs);                                           %% 
        nf = linspace(1,nfigs,nfigs);                                    %% 
        
        for i=1:nfigs
            fileNameNum = ['PNGFigure' num2str(i) '.png'];
            saveas(i,fileNameNum)
        end
        
% [1,2...] input is vector
    elseif numel(nf)>1
            for i=1:numel(nf)
                fileNameNum = ['PNGFigure' num2str(nf(i)) '.png'];
                saveas(nf(i),fileNameNum)
            end
% '1' input is specific figure
    elseif ~ischar(nf) && numel(nf)==1% if not it simply saves the specified figure
            fileNameNum = ['PNGFigure' num2str(nf) '.png'];
            saveas(nf,fileNameNum)

    end