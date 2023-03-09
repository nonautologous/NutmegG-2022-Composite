function nut_load_Fsummary
%function nut_load_Fsummary
%Load all "Fsummary... files
% 8/11/15 AMF compatible with nutmeg4+ analysis; no changes

%%%  RIGHT HEMISPHERE VOI  %%%%
% VOI1  (STG + Supramarginal Gyrus)
files=dir('Fsummary*Right_1.mat');

for i=1:length(files)
    eval(['load ' files(i).name ' -mat']);
    Fsummary.name=files(i).name;
    fsummary_right_voi1(i)=Fsummary;
end
Fsummary=fsummary_right_voi1;
save fsummary_right_voi1.mat Fsummary

% VOI2   (IFG + MFG + precentral)
files=dir('Fsummary*Right_2.mat');

for i=1:length(files)
    eval(['load ' files(i).name ' -mat']);
    Fsummary.name=files(i).name;
    fsummary_right_voi2(i)=Fsummary;
end
Fsummary=fsummary_right_voi2;
save fsummary_right_voi2.mat Fsummary

%%%% LEFT HEMISPHERE VOI %%%%%%
% VOI1
files=dir('Fsummary*Left_1.mat');

for i=1:length(files)
    eval(['load ' files(i).name ' -mat']);
    Fsummary.name=files(i).name;
    fsummary_left_voi1(i)=Fsummary;
end
Fsummary=fsummary_left_voi1;
save fsummary_left_voi1.mat Fsummary

% VOI2
files=dir('Fsummary*Left_2.mat');

for i=1:length(files)
    eval(['load ' files(i).name ' -mat']);
    Fsummary.name=files(i).name;
    fsummary_left_voi2(i)=Fsummary;
end
Fsummary=fsummary_left_voi2;
save fsummary_left_voi2.mat Fsummary