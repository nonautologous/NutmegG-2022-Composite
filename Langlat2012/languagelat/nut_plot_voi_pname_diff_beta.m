function [responseLIaverageVOI2, LI2]=nut_plot_voi_pname_diff_beta(subject_id, wadaresult)
%[stimLIaverageVOI1, responseLIaverageVOI2, combinedLIaverage, LI1, LI2]=nut_plot_voi_responsestim_diff_beta(subject_id)

%create a directory with 2 subdirectories "response" and "stim"
%in "stim" directory, ln -s to the Fsummary files and to the s_beam stim
%file
%do similarly in the "response" directory
%then run this program from the higher directory, using the subject
%initials/ID that is part of the Fsummary file.  There should be 4 Fsummary
%files for each complete verb gen analysis: 2 for each VOI (left and
%right).
%Or just run "verbgen_plotdir Name_ClinSpeech...03-audverbgen.ds" in patient
%directory.

% Takes filenames and assigns each part to a string
strF='Fsummary_';
str1L='_VOI_Left_1.mat';
str2L='_VOI_Left_2.mat';
str1R='_VOI_Right_1.mat';
str2R='_VOI_Right_2.mat';
s_beam_response=['s_beamtf_session_pn_response_firls200_SAMcn_SAM_all.mat'];
fsummaryVOI1_filename = (['fsummary_allLI_VOI1_' wadaresult 'wada.mat']);
fsummaryVOI2_filename = (['fsummary_allLI_VOI2_' wadaresult 'wada.mat']);
%s_beam_stim='s_beamtf_verbgen2stim.mat';

filenameVOI1Left=[strF subject_id str1L];
filenameVOI2Left=[strF subject_id str2L];
filenameVOI1Right=[strF subject_id str1R];
filenameVOI2Right=[strF subject_id str2R];

%cd Fsummary-response/left
%cd response
VOI1LeftResponse=load(filenameVOI1Left);
VOI2LeftResponse=load(filenameVOI2Left);
VOI1RightResponse=load(filenameVOI1Right);
VOI2RightResponse=load(filenameVOI2Right);
beam_response=load(s_beam_response);

% %cd ../../Fsummary-stim/left
% cd ../stim
% VOI1LeftStim=load(filenameVOI1Left);
% VOI2LeftStim=load(filenameVOI2Left);
% VOI1RightStim=load(filenameVOI1Right);
% VOI2RightStim=load(filenameVOI2Right);
% beam_stim=load(s_beam_stim);
% 
% cd ../..
%cd ../
load(s_beam_response);
time = [beam_response.timepts];

VOI1Left = [VOI1LeftResponse.Fsummary.averageF];
VOI2Left = [VOI2LeftResponse.Fsummary.averageF];

VOI1Right = [VOI1RightResponse.Fsummary.averageF];
VOI2Right = [VOI2RightResponse.Fsummary.averageF];

VOI1Diff = VOI1Right - VOI1Left;
VOI2Diff = VOI2Right - VOI2Left;

fsummary1 = load(fsummaryVOI1_filename);
LI1 = fsummary1.Fsummary.LI
fsummary2 = load(fsummaryVOI2_filename);
LI2 = fsummary2.Fsummary.LI

% 
% %Calculate LI
for j=1:size(VOI1Right,2)
     for ii=1:size(VOI1Right,1)
%         LI1(ii,j) = (VOI1Right(ii,j) - VOI1Left(ii,j)) ./ ...
%                 (abs(VOI1Left(ii,j)) + abs(VOI1Right(ii,j)));
%         LI2(ii,j) = (VOI2Right(ii,j) - VOI2Left(ii,j)) ./ ...
%                 (abs(VOI2Left(ii,j)) + abs(VOI2Right(ii,j))); 
         yaxisline(ii,j) = 0;
     end
 end


index = find(timepts >= -450 & timepts <= -250)
responseLIaverageVOI2   = mean(LI2(index));
% stimLIaverageVOI1       = mean(LI1(6:8,1));
%combinedLIaverage       = mean([stimLIaverageVOI1 responseLIaverageVOI2]);

% set y axis max and min for Faverage plots, using minimum value in beta
% band.
for j = 1:size(VOI1Left,2)
    y1 = abs(max([ abs(min(VOI1Left(:,j))) abs(min(VOI1Right(:,j))) abs(max(VOI1Left(:,j))) abs(max(VOI1Right(:,j))) ]));
    y2 = abs(max([ abs(min(VOI2Left(:,j))) abs(min(VOI2Right(:,j))) abs(max(VOI2Left(:,j))) abs(max(VOI2Right(:,j))) ]));
    y = max([y1 y2]) + 0.1;
    ymin(j) = -1*y;
    ymax(j) =    y; %#ok<AGROW>
end

for j = 1:size(VOI1Diff,2)
    ydiff1 = abs(max([ abs(min(VOI1Diff(:,j))) abs(min(VOI1Diff(:,j))) abs(max(VOI1Diff(:,j))) abs(max(VOI1Diff(:,j))) ]));
    ydiff2 = abs(max([ abs(min(VOI2Diff(:,j))) abs(min(VOI2Diff(:,j))) abs(max(VOI2Diff(:,j))) abs(max(VOI2Diff(:,j))) ]));
    ydiff = max([ydiff1 ydiff2]) + 0.1;
    ydiffmin(j) = -1*ydiff;
    ydiffmax(j) =    ydiff; 
end

for j = 1:size(VOI1Left,2)
    y = abs(max([ abs(min(VOI1Left(:,j))) abs(min(VOI1Right(:,j))) abs(max(VOI1Left(:,j))) abs(max(VOI1Right(:,j))) ]));
    ymin1(j) = -1*y - 0.1;
    ymax1(j) =    y + 0.1;
end

for j = 1:size(VOI1Left,2)
    y = abs(max([ abs(min(VOI2Left(:,j))) abs(min(VOI2Right(:,j))) abs(max(VOI2Left(:,j))) abs(max(VOI2Right(:,j))) ]));
    ymin2(j) = -1*y - 0.1;
    ymax2(j) =    y + 0.1;
end

boxtime = [timepts(index)];
boxval  = [ymin(1) ymax(1)];


%Figure of beta band only for VOI1, VOI2 and LI.
figure1=figure(14)

hold on
for ii=1
    %VOI1
    subplot(4,1,1)
   
    plot(time,VOI1Left(:,ii),'b')
    hold on
    plot(time,VOI1Right(:,ii),'m')
    hold on
   
    
%     %VOI1 significant time points (stim)
%     plot(boxtime(1:2),boxval(1:2),'y-')
%     plot(boxtime(3:4),boxval(1:2),'y-')
%     
    xlabel('Time (msec)')
    ylabel('Ave F value')
    axis([min(time(:,1)) max(time(:,1)) ymin(ii) ymax(ii)]);
    %axis([min(time(:,1)) max(time(:,1)) ymin(ii) 1.5]);
    %titlestring=[t2 ', ' num2str(beam.bands(ii,1)) '-' num2str(beam.bands(ii,2)) ' Hz, ' t3 '_' t6];
    titlestring=['Average F, ' subject_id ', ' num2str(beam_response.bands(1)) '-' num2str(beam_response.bands(2)) ' Hz, VOI1, Picture Naming'];
    title(titlestring)
   legend('L (response)','R (response)','Location','Northwest')  
   hold on
   plot(time,yaxisline(:,ii),'k--')
    hold on
   
    %VOI2
    subplot(4,1,2)
   
    plot(time, VOI2Left(:,ii),'b')
    hold on
    plot(time,VOI2Right(:,ii),'m')
    hold on
    
    
    %VOI2 significant time points (response)
    plot([boxtime(1) boxtime(1)],boxval(1:2),'y-')
    plot([boxtime(end) boxtime(end)],boxval(1:2),'y-')
    
    xlabel('Time (msec)')
    ylabel('Ave F value')
    axis([min(time(:,1)) max(time(:,1)) ymin(ii) ymax(ii)]);
    %titlestring=[t2 ', ' num2str(beam.bands(ii,1)) '-' num2str(beam.bands(ii,2)) ' Hz, ' t3 '_' t6];
    titlestring=['Average F, ' subject_id ', ' num2str(beam_response.bands(1)) '-' num2str(beam_response.bands(2)) ' Hz, VOI2, Picture Naming'];
    title(titlestring)
    legend('L (response)','R (response)','Location','Northwest')   
    
    plot(time,yaxisline(:,ii),'k--')
    hold on
   
    %LI 
    subplot(4,1,3)
    plot(time,LI1(:,ii),'bo-')
    hold on
    plot(time,LI2(:,ii),'mo-')
    hold on
    
    
    hold on
    plot(time(index),LI2(index),'y*')
%     hold on
%     plot(time(9:11),LI2(9:11,ii),'y*')
    
    plot(time,yaxisline(:,ii),'k-')
    hold on
%     plot(time(9:22),yaxisline(9:22,ii),'k-')
%     hold on
%     %VOI1 significant time points (stim)
%     plot(boxtime(1:2),boxval(1:2),'y-')
%     plot(boxtime(3:4),boxval(1:2),'y-')
%     %VOI2 significant time points (response)
%     plot(boxtime(5:6),boxval(1:2),'y-')
%     plot(boxtime(7:8),boxval(1:2),'y-')

    xlabel('Time (msec)')
    ylabel('Laterality Index')
    axis([min(time(:,1)) max(time(:,1)) -1 1]);
    %titlestring=[t2 ', ' num2str(beam.bands(ii,1)) '-' num2str(beam.bands(ii,2)) ' Hz, ' t3 '_' t6];
    titlestring=['Picture Naming Laterality Index, ' subject_id ', ' num2str(beam_response.bands(1)) '-' num2str(beam_response.bands(2)) ' Hz;'...
        ' LI (response) = ' num2str(responseLIaverageVOI2,3) ];
    title(titlestring)
   legend('VOI1 (response)','VOI2 (response)','Location','Southwest')  
   
   % Difference in F-values (Right - Left)
    subplot(4,1,4)
    plot(time,VOI1Diff(:,ii),'bo-')
    hold on
    
    plot(time,VOI2Diff(:,ii),'mo-')

    hold on
    plot(time(index),VOI2Diff(index,ii),'y*')
    
    plot(time,yaxisline(:,ii),'k-')
    hold on

    xlabel('Time (msec)')
    ylabel('Pseudo-F Value')
    axis([min(time(:,1)) max(time(:,1)) ydiffmin(ii) ydiffmax(ii)]);
    titlestring=['Picture Naming Difference in VOI Average F-val (Right-Left), ' subject_id ', ' num2str(beam_response.bands(1)) '-' num2str(beam_response.bands(2)) ' Hz'];
    title(titlestring)
   legend('VOI1 (response)','VOI2 (response)','Location','Southwest')  
   
   
end
