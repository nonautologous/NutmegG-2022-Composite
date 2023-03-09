function CTFpseudoF_sbeam_file = nut_convert_nm4_beam_to_CTFpseudoF_beam(nm4_sbeam_file)
% function CTFpseudoF_sbeam_file = nut_convert_nm4_beam_to_CTFpseudoF_beam(s_beam)
%
% Converts newer nm4+ beam variables (timepts, srate, etc.) back to older
% beam structure (beam.timepts, beam.srate, etc.).
% Also converts s to beam.s where beam.s is CTF pseudo F ratio.
% AMF 8/7/2015

load(nm4_sbeam_file)

beam.timepts=timepts;
beam.timewindow=timewindow;
beam.srate=srate;
beam.bands=bands; %old bands = [12 30] nm4.1 = [12,30]
beam.s = nut_convert_nm4_s_to_CTFpseudoF(s); %use beam.s not beam.s{1} because nut_convert_nm4_s_to_CTFpseudoF has output of s{1}
beam.voxels=voxels;
beam.voxelsize=voxelsize;
beam.params=params;
beam.coreg=coreg;

[parthstr,fname,ext] = fileparts(nm4_sbeam_file);
CTFpseudoF_sbeam_file = [fname '_CTFpseudoF' ext];
save(CTFpseudoF_sbeam_file, 'beam')
