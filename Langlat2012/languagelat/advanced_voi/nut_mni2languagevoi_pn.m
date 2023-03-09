function VOIvoxels=nut_mni2languagevoi_pn(s_beam_file_nm4)
%function VOIvoxels=nut_mni2languagevoi(s_beam)
%This program creates coordinates for each VOI used.
%VOI1 is for STG + Supramarginal Gyrus
%VOI2 is for Precentral, Middle and Inferior Frontal Gyri
%
%This program uses the rivets.MNIdb variable that is created when loading
%data into the nut_resuts_viewer GUI. Nutmeg 4.6 uses rivets.Taldb and this
%will have to be revised.
% AMF 8/11/2015
% Updated to use nut_results_viewer instead of nut_timef_viewer to be
% compatible with nutmeg 4.1+

nut_results_viewer(s_beam_file_nm4) %nut_timef_viewer no longer exists in nm4.1
global rivets

%Create VOI's (coordinates) for left MOG (31) and IOG (20) and
%for VOI_Left_1.mat which includes both gyri.

VOIvoxels_LIOG=nut_mni2voi(s_beam_file_nm4,3,20);
rivets.MNIdb.cNames{3}(20)
VOIvoxels=VOIvoxels_LIOG;
save VOIvoxels_LIOG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels_LMOG=nut_mni2voi(s_beam_file_nm4,3,31);
rivets.MNIdb.cNames{3}(31)
VOIvoxels=VOIvoxels_LMOG;
save VOIvoxels_LMOG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels=[VOIvoxels_LIOG;VOIvoxels_LMOG];
save VOI_Left_1.mat VOIvoxels
clear VOIvoxels;

%Create VOI's for right STG and supramarginal gyrus and
%for VOI_Right_1.mat which includes both gyri.

VOIvoxels_RIOG=nut_mni2voi(s_beam_file_nm4,3,21);
rivets.MNIdb.cNames{3}(21)
VOIvoxels=VOIvoxels_RIOG;
save VOIvoxels_RIOG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels_RMOG=nut_mni2voi(s_beam_file_nm4,3,32);
rivets.MNIdb.cNames{3}(32)
VOIvoxels=VOIvoxels_RMOG;
save VOIvoxels_RMOG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels=[VOIvoxels_RIOG;VOIvoxels_RMOG];
save VOI_Right_1.mat VOIvoxels
clear VOIvoxels


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Create VOI's for left precentral gyrus, MFG, IFG, postCG (67/69)
%for VOI_Left_2.mat which includes all 4 locs.

VOIvoxels_LPrecentral=nut_mni2voi(s_beam_file_nm4,3,41);
rivets.MNIdb.cNames{3}(41)
VOIvoxels=VOIvoxels_LPrecentral;
save VOIvoxels_LPrecentral.mat VOIvoxels
clear VOIvoxels;

VOIvoxels_LIFG=nut_mni2voi(s_beam_file_nm4,3,43);
rivets.MNIdb.cNames{3}(43)
VOIvoxels=VOIvoxels_LIFG;
save VOIvoxels_LIFG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels_LMFG=nut_mni2voi(s_beam_file_nm4,3,62);
rivets.MNIdb.cNames{3}(62)
VOIvoxels=VOIvoxels_LMFG;
save VOIvoxels_LMFG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels_LPostCG=nut_mni2voi(s_beam_file_nm4,3,67);
rivets.MNIdb.cNames{3}(67)
VOIvoxels=VOIvoxels_LPostCG;
save VOIvoxels_LPostCG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels=[VOIvoxels_LPrecentral; VOIvoxels_LIFG; VOIvoxels_LMFG; VOIvoxels_LPostCG];
save VOI_Left_2.mat VOIvoxels
clear VOIvoxels;

%Create VOI's for right precentral gyrus, IFG and MFG IPL SPL
%for VOI_Right_2.mat which includes all 5 gyri.

VOIvoxels_RPrecentral=nut_mni2voi(s_beam_file_nm4,3,42);
rivets.MNIdb.cNames{3}(42)
VOIvoxels=VOIvoxels_RPrecentral;
save VOIvoxels_RPrecentral.mat VOIvoxels
clear VOIvoxels;

VOIvoxels_RIFG=nut_mni2voi(s_beam_file_nm4,3,44);
rivets.MNIdb.cNames{3}(44)
VOIvoxels=VOIvoxels_RIFG;
save VOIvoxels_RIFG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels_RMFG=nut_mni2voi(s_beam_file_nm4,3,63);
rivets.MNIdb.cNames{3}(63)
VOIvoxels=VOIvoxels_RMFG;
save VOIvoxels_RMFG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels_RPostCG=nut_mni2voi(s_beam_file_nm4,3,69);
rivets.MNIdb.cNames{3}(69)
VOIvoxels=VOIvoxels_RPostCG;
save VOIvoxels_RPostCG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels=[VOIvoxels_RPrecentral; VOIvoxels_RIFG; VOIvoxels_RMFG; VOIvoxels_RPostCG];
save VOI_Right_2.mat VOIvoxels
clear VOIvoxels;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Create VOI's for left and right STG and supramarginal gyrus,
%precentral gyrus, IFG and MFG
%for VOI_Left_All.mat which includes all 6 gyri.

VOIvoxels=[VOIvoxels_LIOG;VOIvoxels_LMOG;VOIvoxels_LPrecentral; VOIvoxels_LIFG; VOIvoxels_LMFG; VOIvoxels_LPostCG];
save VOI_Left_All.mat VOIvoxels
clear VOIvoxels;

VOIvoxels=[VOIvoxels_RIOG;VOIvoxels_RMOG;VOIvoxels_RPrecentral; VOIvoxels_RIFG; VOIvoxels_RMFG; VOIvoxels_RPostCG];
save VOI_Right_All.mat VOIvoxels
clear VOIvoxels;


