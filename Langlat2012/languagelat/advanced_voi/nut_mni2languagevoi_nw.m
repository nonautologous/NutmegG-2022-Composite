function VOIvoxels=nut_mni2languagevoi_nw(s_beam_file_nm4)
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

%Create VOI's for left STG (37/38), ITG (22/23) and MTG (35/36) and
%for VOI_Left_1.mat which includes all gyri.

VOIvoxels_LSTG=nut_mni2voi(s_beam_file_nm4,3,37);
rivets.MNIdb.cNames{3}(37)
VOIvoxels=VOIvoxels_LSTG;
save VOIvoxels_LSTG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels_LITG=nut_mni2voi(s_beam_file_nm4,3,22);
rivets.MNIdb.cNames{3}(22)
VOIvoxels=VOIvoxels_LITG;
save VOIvoxels_LITG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels_LMTG=nut_mni2voi(s_beam_file_nm4,3,35);
rivets.MNIdb.cNames{3}(35)
VOIvoxels=VOIvoxels_LMTG;
save VOIvoxels_LMTG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels=[VOIvoxels_LSTG;VOIvoxels_LITG;VOIvoxels_LMTG];
save VOI_Left_1.mat VOIvoxels
clear VOIvoxels;

%Create VOI's for right STG (37/38), ITG (22/23) and MTG (35/36) and
%for VOI_Right_1.mat which includes all gyri.

VOIvoxels_RSTG=nut_mni2voi(s_beam_file_nm4,3,38);
rivets.MNIdb.cNames{3}(38)
VOIvoxels=VOIvoxels_RSTG;
save VOIvoxels_RSTG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels_RITG=nut_mni2voi(s_beam_file_nm4,3,23);
rivets.MNIdb.cNames{3}(23)
VOIvoxels=VOIvoxels_RITG;
save VOIvoxels_RITG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels_RMTG=nut_mni2voi(s_beam_file_nm4,3,36);
rivets.MNIdb.cNames{3}(36)
VOIvoxels=VOIvoxels_RMTG;
save VOIvoxels_RMTG.mat VOIvoxels
clear VOIvoxels;

VOIvoxels=[VOIvoxels_RSTG;VOIvoxels_RITG;VOIvoxels_RMTG];
save VOI_Right_1.mat VOIvoxels
clear VOIvoxels;


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

%Create VOI's for right precentral gyrus, MFG, IFG, postCG (67/69)
%for VOI_Right_2.mat which includes all gyri.

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

VOIvoxels=[VOIvoxels_LSTG;VOIvoxels_LITG;VOIvoxels_LMTG;VOIvoxels_LPrecentral; VOIvoxels_LIFG; VOIvoxels_LMFG; VOIvoxels_LPostCG];
save VOI_Left_All.mat VOIvoxels
clear VOIvoxels;

VOIvoxels=[VOIvoxels_RSTG;VOIvoxels_RITG;VOIvoxels_RMTG;VOIvoxels_RPrecentral; VOIvoxels_RIFG; VOIvoxels_RMFG; VOIvoxels_RPostCG];
save VOI_Right_All.mat VOIvoxels
clear VOIvoxels;


