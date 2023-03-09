function Fsummary=nut_voi_verbgenlat(s_beam_file_nm4,subject_id,wadaresult)
%function Fsummary=nut_voi_verbgenlat(s_beam_file,subject_id,wadaresult)
%
% 8/11/2015 Updated to use nutmeg4+ s_beamtf files created using tfbf
% response results should have "response" in the resulting s_beamtf file
% stim results should have "stim" in the resulting s_beamtf file
% Results are converted back to have the structure of old s_beam files,
% such that beam.s exists and contains beam.s{1} which is the CTF pseudo-F
% ratio.

load(s_beam_file_nm4)

[pathstr,fname,ext]   = fileparts(s_beam_file_nm4);
s_beam_spatnorm_file  = [fname '_spatnorm' ext];
%new_s_beam_file          = [fname '_CTFpseudoF' ext];
%new_s_beam_spatnorm_file = [fname '_CTFpseudoF_spatnorm' ext];

if ( exist('beam','var') == 0)  % if beam structure does not exist, as in nutmeg 4.1
    disp('s_beam in nutmeg4 format; converting and writing CTFpseudoF s_beam file')
    s_beam_file_CTFpseudoF  = nut_convert_nm4_beam_to_CTFpseudoF_beam(s_beam_file_nm4); % convert new beam to old beam
    nut_convert_nm4_beam_to_CTFpseudoF_beam(s_beam_spatnorm_file); % convert new beam to old beam
    s_beam_file_nm4         = char(s_beam_file_nm4);
 %   s_beam_file             = s_beam_file_CTFpseudoF;
else
    error('s_beam may be in old format; use original language lat code; beam structure found.')
end

nut_mni2languagevoi(s_beam_file_nm4) %Create MNI-based VOIs using rivets.MNIdb
fprintf('\nDone nut_mni2languagevoi (created VOIs)\n')
fprintf('\nDone nut_mni2languagevoi (now creating VOIed s_beams...)\n')

%not creating VOIed s_beams and masks
nut_find_same_voxels_iterate('VOI_Left_1.mat',s_beam_file_CTFpseudoF,subject_id)
fprintf('\nDone creating Fsummary for VOI_Left_1\n')
nut_find_same_voxels_iterate('VOI_Left_2.mat',s_beam_file_CTFpseudoF,subject_id)
fprintf('\nDone creating Fsummary for VOI_Left_2\n')

nut_find_same_voxels_iterate('VOI_Right_1.mat',s_beam_file_CTFpseudoF,subject_id)
fprintf('\nDone creating Fsummary for VOI_Right_1\n')
nut_find_same_voxels_iterate('VOI_Right_2.mat',s_beam_file_CTFpseudoF,subject_id)
fprintf('\nDone creating Fsummary for VOI_Right_2\n')

nut_load_Fsummary

nut_voi_LI_working(wadaresult)
fprintf('\nDone calculating LIs\n')


fprintf('\nUse nut_plot_voi to display average F values.\n')