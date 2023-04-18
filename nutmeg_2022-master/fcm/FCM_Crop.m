function FCM_Crop

global st

if ~isfield(st,'fig') || ~isfield(st,'vp')
    errordlg('No SPM figure or coordinates to snap') ,return
end

% parse figures and select only SPM
SelFig=st.fig
rect=getrect(SelFig)

voxl=split(st.vp.String,' ');
voxl(3)
ca=input('C#','s')
formacomp='%s.imcoh.vx.%s.jpg'
imageData=screencapture(SelFig,rect)
formacomp=compose(formacomp,ca)
saveloc=compose(formacomp,cell2mat(voxl(3))
imwrite(imageData,saveloc)

% Increment and update SPM figure for the new slice
Loc=st.vp.String='38.1 47.5 30.4'
Locs=split(st.vp.String,' ');