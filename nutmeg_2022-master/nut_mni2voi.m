function VOIvoxels=nut_mni2voi(s_beam,MNIlabelindex1,MNIlabelindex2)
%function nut_mni2voi(s_beam,MNIlabelindex1,MNIlabelindex2)
% Find the appropriate MNI tag and check the index values:
%rivets.MNIdb.cNames{MNIlabelindex1}(MNIlabelindex2)

load(s_beam)
global rivets
data=rivets.MNIdb.data;
coords=rivets.MNIdb.coords;
cNames=rivets.MNIdb.cNames;

MNIlabel_index=find(data(:,MNIlabelindex1) == MNIlabelindex2);
VOIcoords_mni=coords(MNIlabel_index,:);
VOIcoords_mri=nut_mni2mri(VOIcoords_mni);
VOIcoords_meg=nut_mri2meg(VOIcoords_mri);

VOIvoxels=single(VOIcoords_meg);
%save voxelsfromMNIlabel.mat VOIvoxels
