function Fsummary=nut_voi_verbgenlat(s_beam_file, subject_id,wadaresult)
%function Fsummary=nut_voi_verbgenlat(s_beam_file, subject_id,wadaresult)

nut_mni2languagevoi(s_beam_file)
fprintf('\nDone nut_mni2languagevoi (created VOIs)\n')
fprintf('\nDone nut_mni2languagevoi (now creating VOIed s_beams...)\n')

%not creating VOIed s_beams and masks
nut_find_same_voxels_iterate('VOI_Left_1.mat',s_beam_file,subject_id)
fprintf('\nDone creating Fsummary for VOI_Left_1\n')
nut_find_same_voxels_iterate('VOI_Left_2.mat',s_beam_file,subject_id)
fprintf('\nDone creating Fsummary for VOI_Left_2\n')

nut_find_same_voxels_iterate('VOI_Right_1.mat',s_beam_file,subject_id)
fprintf('\nDone creating Fsummary for VOI_Right_1\n')
nut_find_same_voxels_iterate('VOI_Right_2.mat',s_beam_file,subject_id)
fprintf('\nDone creating Fsummary for VOI_Right_2\n')

nut_load_Fsummary

nut_voi_LI_working(wadaresult)
fprintf('\nDone calculating LIs\n')


fprintf('\nUse nut_plot_voi to display average F values.\n')