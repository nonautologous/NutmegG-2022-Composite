function fcm_useroi(roifile)
% fcm_useroi(roifile)

global fuse
R=load(roifile);
fuse.roi=length(R);
