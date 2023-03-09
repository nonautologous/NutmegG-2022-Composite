function Active_sbeam_file = nut_convert_nm4_beam_to_Active_beam(nm4_sbeam_file)
% function CTFpseudoF_sbeam_file = nut_convert_nm4_beam_to_Active_beam(s_beam)
%
% Converts newer nm4+ beam variables (timepts, srate, etc.) back to older
% beam structure (beam.timepts, beam.srate, etc.).
% Also converts s to beam.s where beam.s is CTF pseudo F ratio.
% AMF 8/7/2015

load(nm4_sbeam_file)

%beam.timepts=timepts;
%beam.timewindow=timewindow;
%beam.srate=srate;
%beam.bands=bands; %old bands = [12 30] nm4.1 = [12,30]
%beam.s = beam.s{1}-beam.s{3};
beam.s = nut_convert_nm4_s_to_Active_nc(beam.s); 
%beam.voxels=voxels;
%beam.voxelsize=voxelsize;
%beam.params=params;
%beam.coreg=coreg;

[parthstr,fname,ext] = fileparts(nm4_sbeam_file);
Active_sbeam_file = [fname '_Active_nc' ext];
save(Active_sbeam_file, 'beam')



