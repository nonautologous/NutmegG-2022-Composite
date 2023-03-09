function Fsummary=nut_find_same_voxels_iterate(VOI_matfile, s_beam_file, subject_id, k, d)
%function Fsummary=nut_find_same_voxels_iterate(VOI_matfile, s_beam_file, subject_id, k, d)
% VOIvoxels = variable stored in voxel file made using Nutmeg VOI tool
% beam = variable stored in s_beam... file
% timewin = number of time window used as in time-freq plot (1 will be
%       earliest time window, 2 next etc.)
% freqbin = number of frequency bin used as in time-freq plot (1 will be
%       lowest frequency bin, 2 next etc.)
% k is the same size as beam.voxel. The index # of k corresponds to the
% voxel number in beam.voxel. The value of k(i) corresponds to a voxel in
% the VOI with distance d(i) from the kth voxel in the beam.voxel. Does
% that make sense?

load(VOI_matfile);
nut_timef_viewer(s_beam_file);
load(s_beam_file);

voxelsize = beam.voxelsize;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Uncomment this section if you are not using k & d as inputs
% Voxels in VOIvoxels will likely have a different (higher) resolution
% (smaller voxel) size than those in beam.voxels.  Here the VOIvoxels are
% converted to match the coordinate resolution of beam.voxels and duplicate
% voxels are removed (uniquevoxels=...).  Then dsearchn is used to find 
% matching voxel coordinates within a certain distance and to return the indeces. 
for ii = 1:3
    voxels(:,ii) = voxelsize(ii)*round(VOIvoxels(:,ii)/voxelsize(ii));
end

uniquevoxels = unique(voxels,'rows');

[k d] = dsearchn(uniquevoxels,beam.voxels);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for timewin = 1:size(beam.s{1},2) %iterate over time windows, earliest first
    for freqbin = 1:size(beam.s{1},3) %iterate over frequency bins, lowest first

for ii = 1:size(k,1)
    if d(ii) <= 10
        voxel_number(ii) = k(ii); %k(ii) is the index number of the VOI
       
    elseif d(ii) > 10
        voxel_number(ii) = 0;
    end
end

voxel_mask(1:size(k,1)) = 0;

for ii = 1:size(k,1)
    if voxel_number(ii) ~= 0
        voxel_mask(ii) = 1;
    end
end

voxel_mask = voxel_mask';
timewin;
freqbin;
masked_beam = voxel_mask.*beam.s{1}(:,timewin,freqbin);



%To test your output....[OLD, for freq 1 and timewin 6 only]
%beam.s{1}(:,1,1)=voxel_mask.*beam.s{1}(:,1,1);
%save testbeam.mat beam

%create Fsummary variable.  Must ignore the zeros or else you get
%the max=0 if the max in the VOI is less than zero.
Fsummary.averageF(timewin,freqbin) = sum(masked_beam)/sum(voxel_mask);
Fsummary.maxF(timewin,freqbin)=max(nonzeros(masked_beam));
Fsummary.minF(timewin,freqbin)=min(nonzeros(masked_beam));

%There are two ways of computing the average F value and I compare the
%difference with testdiff.  This should be negligible.  I need to
%double-check how many voxels within the VOI actually have a value of zero.
%testdiff=mean(nonzeros(masked_beam))-Fsummary.averageF(timewin,freqbin);
%sizemasked_beam=size(nonzeros(masked_beam))
%nonzeromasked_beam=nnz(masked_beam)
%sizevoxel_mask=sum(voxel_mask)

%Create new beam file restricted to VOI
voi_beam(:,timewin,freqbin)=masked_beam;
voi_mask(:,timewin,freqbin)=voxel_mask;

voxel_mask=0;

    end
end

filename=['Fsummary_' subject_id '_' VOI_matfile]

save(filename, 'Fsummary')

%Create s_beam based on VOI....
beam.s{1}=voi_beam;
beamname=['s_beamtf_' subject_id '_' VOI_matfile]
save(beamname, 'beam');

beam.s{1}=voi_mask;
voxelmask_beamname=['s_beamtf_' subject_id '_voimask' VOI_matfile]
save(voxelmask_beamname, 'beam');
