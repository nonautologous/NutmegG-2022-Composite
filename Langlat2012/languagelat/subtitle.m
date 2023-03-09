function [ax, h] = subtitle(text)
%
% Centers a title over a group of subplots.
%Returns a handle to the title and the handle to the axis
% [ax,h]=subtitle(text)
%   returns handles to both the axis and the title
% ax=subtitle(text0
%   returns a handle to the axis only.

%ax=axes('Units','Normal','Position',[0.075 0.075 0.85 0.85],'Visible','off');
ax=axes('Units','Normal','Position',[0.09 0.09 0.85 0.85],'Visible','off');
set(get(ax,'Title'),'Visible','on')
title(text);

if (nargout <2)
    return
end

h=get(ax,'Title');