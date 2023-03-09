function nut_voi_combineRightLeftVOI(subject_id)
%function nut_voi_combineRightLeftVOI(subject_id)


%Combine right and left hemispheres for each VOI.

filenameL1 = [ 's_beamtf_' subject_id '_VOI_Left_1.mat' ];
filenameL2 = [ 's_beamtf_' subject_id '_VOI_Left_2.mat' ];
filenameR1 = [ 's_beamtf_' subject_id '_VOI_Right_1.mat' ];
filenameR2 = [ 's_beamtf_' subject_id '_VOI_Right_2.mat' ];

beamL1 = load(filenameL1);
beamL2 = load(filenameL2);
beamR1 = load(filenameR1);
beamR2 = load(filenameR2);

%Combine VOI beam.s{1} for right and left VOI1
new1=beamL1;
new1.beam.s{1} = beamL1.beam.s{1} + beamR1.beam.s{1};

%Combine VOI beam.s{1} for right and left VOI2
new2=beamL2;
new2.beam.s{1} = beamL2.beam.s{1} + beamR2.beam.s{1};


%Save new combined beams.
beam = new1.beam;
beamname1 = ['s_beamtf_' subject_id '_VOI1' ];
save(beamname1, 'beam');

beam = new2.beam;
beamname2 = ['s_beamtf_' subject_id '_VOI2' ];
save(beamname2, 'beam');

fprintf('\nCreated %s and %s.\n',beamname1,beamname2)