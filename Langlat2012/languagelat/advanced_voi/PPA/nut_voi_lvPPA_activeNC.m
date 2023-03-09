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

nut_mni2languagevoi_lvPPA(s_beam_file_nm4) %Create MNI-based VOIs using rivets.MNIdb
fprintf('\nDone nut_mni2languagevoi_lvPPA (created VOIs)\n')
fprintf('\n(now creating VOIed s_beams and power estimates)\n')

%not creating VOIed s_beams and masks
nut_find_same_voxels_iterate('VOI_Left_lvPPA.mat',s_beam_file_Active_nc,subject_id)
fprintf('\nDone creating Fsummary for VOI_Left_lvPPA\n')

