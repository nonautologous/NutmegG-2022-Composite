function fcm_get_Limage
% fcm_get_Limage   3rd part of connectivity map analysis [in MATLAB].
%
% Usage: cd to the subjects directory, then simply type: fcm_get_Limage
%

% Load and assemble all jobs.
%---------------------------
disp('Loading all jobs...')
ICI.coh=[];
ICI.comps=[];
ICC.coh=[];
ICC.comps=[];

cd imcoh

for k=1:9
    load(sprintf('II%d.mat',k));
    if ~isfield(IC,'coh') || isempty(IC.coh)
        error('Something went wrong with your fcm jobs.')
    end
    ICI.coh=cat(2,ICI.coh,IC.coh);
    ICI.comps=cat(1,ICI.comps,IC.comps);
    load(sprintf('IC%d.mat',k));
    if ~isfield(IC,'coh') || isempty(IC.coh)
        error('Something went wrong with your fcm jobs.')
    end
    ICC.coh=cat(2,ICC.coh,IC.coh);
    ICC.comps=cat(1,ICC.comps,IC.comps);
end


ICI.frq=IC.frq;
ICC.frq=IC.frq;
ICI.time=IC.time;
ICC.time=IC.time;

cd ..
delete qL*.csh.o*.*

% Save
%-----
disp('Saving imaginary coherence of all connections...')
load RestingState_Virtual_L_1-20Hz.mat
save imcoh_Limage ICI ICC voxels
clear V


% Make s_beam file
%-----------------
disp('Creating L-image...')
isabs=true;
if isabs
    ICI.coh=atanh(abs(ICI.coh));
    ICC.coh=atanh(abs(ICC.coh));
else
    ICI.coh=(ICI.coh./abs(ICI.coh)).*atanh(abs(ICI.coh));
    ICC.coh=(ICC.coh./abs(ICC.coh)).*atanh(abs(ICC.coh));
end

CC=ICC.comps;
CI=ICC.coh;
TC=ICI.comps;
TI=ICI.coh;

tuv=unique(TC(:,1));
vvv=unique(TC(:,2));

TM=nan(length(tuv),length(vvv));
CM=nan(size(TM));
for v=1:length(tuv)
    f=find(TC(:,1)==tuv(v));
    c=find(ismember(vvv,TC(f,2)));
    TM(v,c)=TI(1,f);
    CM(v,c)=CI(1,f);
end

MM=TM-repmat(nanmean(CM,1),[length(tuv) 1]);
T=zeros(length(tuv),1);
p=zeros(length(tuv),1);

for v=1:length(tuv)
    %f=find(TC(:,1)==tuv(v));
    numconn=length(find(~isnan(MM(v,:))));
    T(v)=nanmean(MM(v,:),2) / ( nanstd(MM(v,:),[],2)/sqrt(numconn) );
    p(v) = 2*tcdf(-abs(T(v)), numconn-1);
end

global nuts
coreg=nuts.coreg
fd=(600/512)/2;

beam.timepts=mean(t)*1000;
beam.timewindow=[t(1) t(end)].*1000;
beam.bands=[ICI.frq(1)-fd ICI.frq(2)+fd];
beam.s{1}=T;
beam.voxels=voxels(tuv,:);
beam.voxelsize=[8 8 8];
beam.srate=1;       % does not matter but must be here
beam.coreg=coreg;

beam.ttestFDR.tail='both';
beam.ttestFDR.T=T;
beam.ttestFDR.p_uncorr = p;
beam.ttestFDR.FDR=0.1;
[dum,beam.ttestFDR.cutoff]=nut_FDR(p,[],beam.ttestFDR.FDR);

save s_beamtf_Limage beam
nutmeg
nut_timef_viewer s_beamtf_Limage

rmdir('imcoh','s');
rmdir('comps','s');

disp('Finished L-image analyses!')