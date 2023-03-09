function Fsummary=nut_voi_lvPPA_activeNC(s_beam_file_nm4,subject_id)
%function Fsummary=nut_voi_verbgenlat(s_beam_file,subject_id,wadaresult)
%
% 8/11/2015 Updated to use nutmeg4+ s_beamtf files created using tfbf
% response results should have "response" in the resulting s_beamtf file
% stim results should have "stim" in the resulting s_beamtf file
% Results are converted back to have the structure of old s_beam files,
% such that beam.s exists and contains beam.s{1} which is the CTF pseudo-F
% ratio.

s_beam_file_Active_nc  = nut_convert_nm4_beam_to_Active_beam_nc(s_beam_file_nm4); % convert new beam to old beam

load(s_beam_file_nm4)

nut_mni2languagevoi_PPA(s_beam_file_nm4) %Create MNI-based VOIs using rivets.MNIdb
fprintf('\nDone nut_mni2languagevoi_PPA (created VOIs)\n')
fprintf('\n(now creating VOIed s_beams and power estimates)\n')

%now creating VOIed s_beams and masks -- lvPPA
nut_find_same_voxels_iterate('VOIvoxels_Lang.mat',s_beam_file_Active_nc,'Lang')
nut_find_same_voxels_iterate('VOIvoxels_Lmt.mat',s_beam_file_Active_nc,'Lmt')
nut_find_same_voxels_iterate('VOIvoxels_Lmo.mat',s_beam_file_Active_nc,'Lmo')
nut_find_same_voxels_iterate('VOIvoxels_Lsmg.mat',s_beam_file_Active_nc,'Lsmg')
%nfvPPA
nut_find_same_voxels_iterate('VOIvoxels_Lifg.mat',s_beam_file_Active_nc,'Lifg')
nut_find_same_voxels_iterate('VOIvoxels_Log.mat',s_beam_file_Active_nc,'Log')
%svPPA
nut_find_same_voxels_iterate('VOIvoxels_Lstg.mat',s_beam_file_Active_nc,'Lstg')
nut_find_same_voxels_iterate('VOIvoxels_Lmtg.mat',s_beam_file_Active_nc,'Lmtg')

fprintf('\nDone creating Fsummary for all PPA VOIs\n')

