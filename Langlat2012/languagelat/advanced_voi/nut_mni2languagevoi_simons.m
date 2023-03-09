function VOIvoxels=nut_mni2languagevoi_simons(s_beam_file_nm4)
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

load(s_beam_file_nm4)

beam.timepts=timepts;
beam.timewindow=timewindow;
beam.srate=srate;
beam.bands=bands; %old bands = [12 30] nm4.1 = [12,30]
beam.s = s; %use beam.s not beam.s{1} because nut_convert_nm4_s_to_CTFpseudoF has output of s{1}
beam.voxels=voxels;
beam.voxelsize=voxelsize;
%beam.params=params; eh?
beam.coreg=coreg;

[parthstr,fname,ext] = fileparts(s_beam_file_nm4);
GWMX_sbeam_file = [fname '_GWMX' ext];
save(GWMX_sbeam_file, 'beam')

nut_results_viewer(s_beam_file_nm4) %nut_timef_viewer no longer exists in nm4.1
global rivets

%Create VOI's (coordinates) for left MOG (31) and IOG (20) and
%for VOI_Left_1.mat which includes both gyri.

VOIvoxels_LPoCG=nut_mni2voi(s_beam_file_nm4,3,41);
VOIvoxels=VOIvoxels_LPoCG;
save VOIvoxels_LPoCG.mat VOIvoxels
clear VOIvoxels;

%VOIvoxels_GML=nut_mni2voi(s_beam_file_nm4,4,5);
%VOIvoxels=VOIvoxels_GML;
%save VOIvoxels_GML.mat VOIvoxels
%clear VOIvoxels;

%VOIvoxels_GMC=nut_mni2voi(s_beam_file_nm4,4,6);
%VOIvoxels=VOIvoxels_GMC;
%save VOIvoxels_GMC.mat VOIvoxels
%clear VOIvoxels;

%VOIvoxels_GMR=nut_mni2voi(s_beam_file_nm4,4,7);
%VOIvoxels=VOIvoxels_GMR;
%save VOIvoxels_GMR.mat VOIvoxels
%clear VOIvoxels;

%VOIvoxels_WML=nut_mni2voi(s_beam_file_nm4,4,8);
%VOIvoxels=VOIvoxels_WML;
%save VOIvoxels_WML.mat VOIvoxels
%clear VOIvoxels;

%VOIvoxels_WMC=nut_mni2voi(s_beam_file_nm4,4,9);
%VOIvoxels=VOIvoxels_WMC;
%save VOIvoxels_WMC.mat VOIvoxels
%clear VOIvoxels;

%VOIvoxels_WMR=nut_mni2voi(s_beam_file_nm4,4,10);
%VOIvoxels=VOIvoxels_WMR;
%save VOIvoxels_WMR.mat VOIvoxels
%clear VOIvoxels;

%VOIvoxels=[VOIvoxels_GML;VOIvoxels_GMC;VOIvoxels_GMR;VOIvoxels_WML;VOIvoxels_WMC;VOIvoxels_WMR];
VOIvoxels=[VOIvoxels_LPoCG];

save VOI_GWMX.mat VOIvoxels
clear VOIvoxels;

nut_find_same_voxels_iterate('VOI_GWMX.mat',GWMX_sbeam_file,'GWMX')
