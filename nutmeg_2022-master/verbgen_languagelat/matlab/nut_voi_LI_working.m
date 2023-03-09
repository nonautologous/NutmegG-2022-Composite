function nut_voi_LI_working(wadaresults)
%function nut_voi_LI_working(wadaresults)

voi1_right=load('fsummary_right_voi1.mat');
voi1_left=load('fsummary_left_voi1.mat');

voi2_right=load('fsummary_right_voi2.mat');
voi2_left=load('fsummary_left_voi2.mat');


nn = size(voi1_right.Fsummary,2);

clear Fsummary

%%%%%%%%%%%%%%%%%
%Finding LI after averaging F values first. OBSOLETE AND NOT USED.
% for n=1:nn
%     beta1L(:,n)=voi1_left.Fsummary(n).averageF(:,1);  %left is for left hemi, VOI1
%     beta1R(:,n)=voi1_right.Fsummary(n).averageF(:,1);
%     beta2L(:,n)=voi2_left.Fsummary(n).averageF(:,1);
%     beta2R(:,n)=voi2_right.Fsummary(n).averageF(:,1);
% end
% WRONG TIME POINTS BELOW
% beta1L=[beta1L(1:4,:); beta1L(6:7,:)];  %These values must be changed if significant time windows change. %
% beta1R=[beta1R(1:4,:); beta1R(6:7,:)];
% beta2L=[beta2L(1:8,:)];
% beta2R=[beta2R(1:8,:)];
% 
% mbeta1L=mean(beta1L);
% mbeta1R=mean(beta1R);
% mbeta2L=mean(beta2L);
% mbeta2R=mean(beta2R);
% 
% for i=1:nn
%     LI_VOI1(i)=(mbeta1R(i)-mbeta1L(i))/(abs(mbeta1R(i))+abs(mbeta1L(i)));
%     LI_VOI2(i)=(mbeta2R(i)-mbeta2L(i))/(abs(mbeta2R(i))+abs(mbeta2L(i)));
% end

%%%%%END OF OBSOLETE AND NOT USED

% Finding LI at each time point:
for ii = 1:nn
    LI = (voi1_right.Fsummary(ii).averageF - voi1_left.Fsummary(ii).averageF) ./ ...
                (abs(voi1_left.Fsummary(ii).averageF) + abs(voi1_right.Fsummary(ii).averageF))
    Fsummary(ii).LI = LI;
    Fsummary(ii).name = voi1_left.Fsummary(ii).name;
   % Fsummary(ii).LI_VOI1=LI_VOI1(ii); %saves LI for significant time points
end

fOut=sprintf('fsummary_allLI_VOI1_%swada.mat',wadaresults)
save(fOut, 'Fsummary')



clear Fsummary
clear LI

for ii = 1:nn
    LI = (voi2_right.Fsummary(ii).averageF - voi2_left.Fsummary(ii).averageF) ./ ...
                (abs(voi2_left.Fsummary(ii).averageF) + abs(voi2_right.Fsummary(ii).averageF))
    Fsummary(ii).LI = LI;
    Fsummary(ii).name = voi2_left.Fsummary(ii).name;
   % Fsummary(ii).LI_VOI2=LI_VOI2(ii);
end

fOut=sprintf('fsummary_allLI_VOI2_%swada.mat',wadaresults)
save(fOut, 'Fsummary')


%fOut=sprintf('LI_beta_VOI1time123467_VOI2time12345678')
%save(fOut, 'beta1L' 'beta1R' 'beta2L' 'beta2R' 'mbeta1L' 'mbeta1R' 'mbeta2L' 'mbeta2R')




