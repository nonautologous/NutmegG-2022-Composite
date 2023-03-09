function VOIvoxels=nut_mni2languagevoi(s_beam)
%function VOIvoxels=nut_mni2languagevoi(s_beam)
%This program creates coordinates for each VOI used.
%VOI1 is for STG + Supramarginal Gyrus
%VOI2 is for Precentral, Middle and Inferior Frontal Gyri

nut_timef_viewer(s_beam)
global rivets

%Create VOI's (coordinates) for left STG and supramarginal gyrus and
%for VOI_Left_1.mat which includes both gyri.

VOIvoxels_LSTG=nut_mni2voi(s_beam,3,37);
rivets.MNIdb.cNames{3}(37)
VOIvoxels=VOIvoxels_LSTG;
save VOIvoxels_LSTG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels_LSupramarginal=nut_mni2voi(s_beam,3,50);
rivets.MNIdb.cNames{3}(50)
VOIvoxels=VOIvoxels_LSupramarginal;
save VOIvoxels_LSupramarginal.mat VOIvoxels
clear VOIvoxels;

VOIvoxels=[VOIvoxels_LSTG;VOIvoxels_LSupramarginal];
save VOI_Left_1.mat VOIvoxels
clear VOIvoxels;

%Create VOI's for right STG and supramarginal gyrus and
%for VOI_Right_1.mat which includes both gyri.

VOIvoxels_RSTG=nut_mni2voi(s_beam,3,38);
rivets.MNIdb.cNames{3}(38)
VOIvoxels=VOIvoxels_RSTG;
save VOIvoxels_RSTG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels_RSupramarginal=nut_mni2voi(s_beam,3,51);
rivets.MNIdb.cNames{3}(38)
VOIvoxels=VOIvoxels_RSupramarginal;
save VOIvoxels_RSupramarginal.mat VOIvoxels
clear VOIvoxels;

VOIvoxels=[VOIvoxels_RSTG;VOIvoxels_RSupramarginal];
save VOI_Right_1.mat VOIvoxels
clear VOIvoxels


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Create VOI's for left precentral gyrus, IFG and MFG
%for VOI_Left_2.mat which includes all 3 gyri.

VOIvoxels_LPrecentral=nut_mni2voi(s_beam,3,41);
rivets.MNIdb.cNames{3}(41)
VOIvoxels=VOIvoxels_LPrecentral;
save VOIvoxels_LPrecentral.mat VOIvoxels
clear VOIvoxels;

VOIvoxels_LIFG=nut_mni2voi(s_beam,3,43);
rivets.MNIdb.cNames{3}(43)
VOIvoxels=VOIvoxels_LIFG;
save VOIvoxels_LIFG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels_LMFG=nut_mni2voi(s_beam,3,62);
rivets.MNIdb.cNames{3}(62)
VOIvoxels=VOIvoxels_LMFG;
save VOIvoxels_LMFG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels=[VOIvoxels_LPrecentral; VOIvoxels_LIFG; VOIvoxels_LMFG];
save VOI_Left_2.mat VOIvoxels
clear VOIvoxels;

%Create VOI's for right precentral gyrus, IFG and MFG
%for VOI_Right_2.mat which includes all 3 gyri.

VOIvoxels_RPrecentral=nut_mni2voi(s_beam,3,42);
rivets.MNIdb.cNames{3}(42)
VOIvoxels=VOIvoxels_RPrecentral;
save VOIvoxels_RPrecentral.mat VOIvoxels
clear VOIvoxels;

VOIvoxels_RIFG=nut_mni2voi(s_beam,3,44);
rivets.MNIdb.cNames{3}(44)
VOIvoxels=VOIvoxels_RIFG;
save VOIvoxels_RIFG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels_RMFG=nut_mni2voi(s_beam,3,63);
rivets.MNIdb.cNames{3}(63)
VOIvoxels=VOIvoxels_RMFG;
save VOIvoxels_RMFG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels=[VOIvoxels_RPrecentral; VOIvoxels_RIFG; VOIvoxels_RMFG];
save VOI_Right_2.mat VOIvoxels
clear VOIvoxels;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Create VOI's for left and right STG and supramarginal gyrus,
%precentral gyrus, IFG and MFG
%for VOI_Left_All.mat which includes all 6 gyri.

VOIvoxels=[VOIvoxels_LSTG;VOIvoxels_LSupramarginal;VOIvoxels_LPrecentral; VOIvoxels_LIFG; VOIvoxels_LMFG];
save VOI_Left_All.mat VOIvoxels
clear VOIvoxels;

VOIvoxels=[VOIvoxels_RSTG;VOIvoxels_RSupramarginal;VOIvoxels_RPrecentral; VOIvoxels_RIFG; VOIvoxels_RMFG];
save VOI_Right_All.mat VOIvoxels
clear VOIvoxels;


