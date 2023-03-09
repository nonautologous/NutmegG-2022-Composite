function [stimLIaverageVOI1, responseLIaverageVOI2, meanLI, LI1, LI2]=nut_plot_voi_nwr_diff_beta(subject_id,  wadaresult)
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
s_beam_response=['s_beamtf_session_nwr_response_firls200_SAMcn_SAM_all.mat'];
s_beam_stim=['s_beamtf_session_nwr_stim_firls200_SAMcn_SAM_all.mat'];

fsummaryVOI1_filename = (['fsummary_allLI_VOI1_' wadaresult 'wada.mat']);
fsummaryVOI2_filename = (['fsummary_allLI_VOI2_' wadaresult 'wada.mat']);
%s_beam_stim='s_beamtf_verbgen2stim.mat';

filenameVOI1Left=[strF subject_id str1L];
filenameVOI2Left=[strF subject_id str2L];
filenameVOI1Right=[strF subject_id str1R];
filenameVOI2Right=[strF subject_id str2R];

%cd Fsummary-response/left
cd response
VOI1LeftResponse=load(filenameVOI1Left);
VOI2LeftResponse=load(filenameVOI2Left);
VOI1RightResponse=load(filenameVOI1Right);
VOI2RightResponse=load(filenameVOI2Right);
beam_response=load(s_beam_response);
timepts_resp = [beam_response.timepts];
index_resp = find(timepts_resp >= -350 & timepts_resp <= -150); %Significant time pts for VOI2/response-locked/NWR
timepts_resp(index_resp)

% %cd ../../Fsummary-stim/left
cd ../stim
VOI1LeftStim=load(filenameVOI1Left);
VOI2LeftStim=load(filenameVOI2Left);
VOI1RightStim=load(filenameVOI1Right);
VOI2RightStim=load(filenameVOI2Right);
beam_stim=load(s_beam_stim);
timepts_stim = [beam_stim.timepts];
index_stim = find(timepts_stim >= 650 & timepts_stim <= 850); %Significant time pts for VOI1/stim-locked/NWR
timepts_stim(index_stim)

cd ../

%% Scaling Plots

VOI1Left = [VOI1LeftStim.Fsummary.averageF; VOI1LeftResponse.Fsummary.averageF];
VOI2Left = [VOI2LeftStim.Fsummary.averageF; VOI2LeftResponse.Fsummary.averageF];

VOI1Right = [VOI1RightStim.Fsummary.averageF; VOI1RightResponse.Fsummary.averageF];
VOI2Right = [VOI2RightStim.Fsummary.averageF; VOI2RightResponse.Fsummary.averageF];

VOI1Diff = VOI1Right - VOI1Left;
VOI2Diff = VOI2Right - VOI2Left;

% fsummary1 = load(fsummaryVOI1_filename);
% LI1 = fsummary1.Fsummary.LI
% fsummary2 = load(fsummaryVOI2_filename);
% LI2 = fsummary2.Fsummary.LI
% 
% % 
% % %Create y axis line
% for j=1:size(VOI1Right,2)
%      for ii=1:size(VOI1Right,1)
%          yaxisline(ii,j) = 0;
%      end
%  end
% 
% index_resp = find(timepts_resp >= -350 & timepts_resp <= -150) %find index_resp for time points for NWR,VOI1 (-350,-250,-150)
% responseLIaverageVOI2   = mean(LI2(index_resp));
% % stimLIaverageVOI1       = mean(LI1(6:8,1));
% %combinedLIaverage       = mean([stimLIaverageVOI1 responseLIaverageVOI2]);

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

boxtime_stim = [timepts_stim(index_stim)];
boxtime_resp = [timepts_resp(index_resp)];
boxval  = [ymin(1) ymax(1)];

%%

%Figure of beta band only for VOI1, VOI2 and LI.
figure1=figure(14)

%% STIM %%

cd stim

VOI1Left = [VOI1LeftStim.Fsummary.averageF];
VOI2Left = [VOI2LeftStim.Fsummary.averageF];

VOI1Right = [VOI1RightStim.Fsummary.averageF];
VOI2Right = [VOI2RightStim.Fsummary.averageF];

VOI1Diff = VOI1Right - VOI1Left;
VOI2Diff = VOI2Right - VOI2Left;

fsummary1 = load(fsummaryVOI1_filename);
LI1 = fsummary1.Fsummary.LI
fsummary2 = load(fsummaryVOI2_filename);
LI2 = fsummary2.Fsummary.LI

% 
% %Create y axis line
for j=1:size(VOI1Right,2)
     for ii=1:size(VOI1Right,1)
         yaxisline(ii,j) = 0;
     end
 end

stimLIaverageVOI1   = mean(LI1(index_stim));
%combinedLIaverage       = mean([stimLIaverageVOI1 responseLIaverageVOI2]);

hold on
for ii=1
    %VOI1
    subplot(4,2,1)
   
    plot(timepts_stim,VOI1Left(:,ii),'b')
    hold on
    plot(timepts_stim,VOI1Right(:,ii),'m')
    hold on
    
    %VOI1 significant time points (stimulus) (650,750,850 ms)
    plot([boxtime_stim(1) boxtime_stim(1)],boxval(1:2),'y-')
    plot([boxtime_stim(end) boxtime_stim(end)],boxval(1:2),'y-')
    
    xlabel('Time (msec)')
    ylabel('Ave F value')
    axis([min(timepts_stim(:,1)) max(timepts_stim(:,1)) ymin(ii) ymax(ii)]);
    titlestring=['Average F, ' subject_id ', ' num2str(beam_stim.bands(1)) '-' num2str(beam_stim.bands(2)) ' Hz, VOI1'];
    title(titlestring)
   legend('L (stimulus)','R (stimulus)','Location','Northwest')  
   hold on
   plot(timepts_stim,yaxisline(:,ii),'k--')
    hold on
   
    %VOI2
    subplot(4,2,3)
   
    plot(timepts_stim, VOI2Left(:,ii),'b')
    hold on
    plot(timepts_stim,VOI2Right(:,ii),'m')
    hold on
    
    
    xlabel('Time (msec)')
    ylabel('Ave F value')
    axis([min(timepts_stim(:,1)) max(timepts_stim(:,1)) ymin(ii) ymax(ii)]);
    titlestring=['Average F, ' subject_id ', ' num2str(beam_stim.bands(1)) '-' num2str(beam_stim.bands(2)) ' Hz, VOI2'];
    title(titlestring)
    legend('L (stimulus)','R (stimulus)','Location','Northwest')   
    
    plot(timepts_stim,yaxisline(:,ii),'k--')
    hold on
   
    %LI 
    subplot(4,2,5)
    plot(timepts_stim,LI1(:,ii),'bo-')
    hold on
    plot(timepts_stim,LI2(:,ii),'mo-')
    hold on
    
    
    hold on
    plot(timepts_stim(index_stim),LI1(index_stim),'y*')
    
    plot(timepts_stim,yaxisline(:,ii),'k-')
    hold on

    xlabel('Time (msec)')
    ylabel('Laterality Index')
    axis([min(timepts_stim(:,1)) max(timepts_stim(:,1)) -1 1]);
     titlestring=['Laterality Index, ' subject_id ', ' num2str(beam_stim.bands(1)) '-' num2str(beam_stim.bands(2)) ' Hz;'...
        ' LI (stim) = ' num2str(stimLIaverageVOI1,3) ];
    title(titlestring)
   legend('VOI1 (stimulus)','VOI2 (stimulus)','Location','Southwest')  
   
   % Difference in F-values (Right - Left)
    subplot(4,2,7)
    plot(timepts_stim,VOI1Diff(:,ii),'bo-')
    hold on
    
    plot(timepts_stim,VOI2Diff(:,ii),'mo-')

    hold on
    plot(timepts_stim(index_stim),VOI1Diff(index_stim,ii),'y*')
    
    plot(timepts_stim,yaxisline(:,ii),'k-')
    hold on

    xlabel('Time (msec)')
    ylabel('Pseudo-F Value')
    axis([min(timepts_stim(:,1)) max(timepts_stim(:,1)) ydiffmin(ii) ydiffmax(ii)]);
    titlestring=['Difference in VOI Average F-val (Right-Left), ' subject_id ', ' num2str(beam_stim.bands(1)) '-' num2str(beam_stim.bands(2)) ' Hz'];
    title(titlestring)
   legend('VOI1 (stimulus)','VOI2 (stimulus)','Location','Southwest')  
   
   
end


cd ../response

%% RESPONSE %%
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
% %Create y axis line
for j=1:size(VOI1Right,2)
     for ii=1:size(VOI1Right,1)
         yaxisline(ii,j) = 0;
     end
 end

index_resp = find(timepts_resp >= -350 & timepts_resp <= -150) %find index_resp for time points for NWR,VOI1 (-350,-250,-150)
responseLIaverageVOI2   = mean(LI2(index_resp));
% stimLIaverageVOI1       = mean(LI1(6:8,1));


hold on
for ii=1
    %VOI1
    subplot(4,2,2)
   
    plot(timepts_resp,VOI1Left(:,ii),'b')
    hold on
    plot(timepts_resp,VOI1Right(:,ii),'m')
    hold on
    
    xlabel('Time (msec)')
    ylabel('Ave F value')
    axis([min(timepts_resp(:,1)) max(timepts_resp(:,1)) ymin(ii) ymax(ii)]);
    titlestring=['Average F, ' subject_id ', ' num2str(beam_response.bands(1)) '-' num2str(beam_response.bands(2)) ' Hz, VOI1'];
    title(titlestring)
   legend('L (response)','R (response)','Location','Northwest')  
   hold on
   plot(timepts_resp,yaxisline(:,ii),'k--')
    hold on
   
    %VOI2
    subplot(4,2,4)
   
    plot(timepts_resp, VOI2Left(:,ii),'b')
    hold on
    plot(timepts_resp,VOI2Right(:,ii),'m')
    hold on
    
    %VOI2 significant time points (response)
    plot([boxtime_resp(1) boxtime_resp(1)],boxval(1:2),'y-')
    plot([boxtime_resp(end) boxtime_resp(end)],boxval(1:2),'y-')
    
    xlabel('Time (msec)')
    ylabel('Ave F value')
    axis([min(timepts_resp(:,1)) max(timepts_resp(:,1)) ymin(ii) ymax(ii)]);
    titlestring=['Average F, ' subject_id ', ' num2str(beam_response.bands(1)) '-' num2str(beam_response.bands(2)) ' Hz, VOI2'];
    title(titlestring)
    legend('L (response)','R (response)','Location','Northwest')   
    
    plot(timepts_resp,yaxisline(:,ii),'k--')
    hold on
   
    %LI 
    subplot(4,2,6)
    plot(timepts_resp,LI1(:,ii),'bo-')
    hold on
    plot(timepts_resp,LI2(:,ii),'mo-')
    hold on
    
    
    hold on
    plot(timepts_resp(index_resp),LI2(index_resp),'y*')
    
    plot(timepts_resp,yaxisline(:,ii),'k-')
    hold on

    xlabel('Time (msec)')
    ylabel('Laterality Index')
    axis([min(timepts_resp(:,1)) max(timepts_resp(:,1)) -1 1]);
     titlestring=['Laterality Index, ' subject_id ', ' num2str(beam_response.bands(1)) '-' num2str(beam_response.bands(2)) ' Hz;'...
        ' LI (response) = ' num2str(responseLIaverageVOI2,3) ];
    title(titlestring)
   legend('VOI1 (response)','VOI2 (response)','Location','Southwest')  
   
   % Difference in F-values (Right - Left)
    subplot(4,2,8)
    plot(timepts_resp,VOI1Diff(:,ii),'bo-')
    hold on
    
    plot(timepts_resp,VOI2Diff(:,ii),'mo-')

    hold on
    plot(timepts_resp(index_resp),VOI2Diff(index_resp,ii),'y*')
    
    plot(timepts_resp,yaxisline(:,ii),'k-')
    hold on

    xlabel('Time (msec)')
    ylabel('Pseudo-F Value')
    axis([min(timepts_resp(:,1)) max(timepts_resp(:,1)) ydiffmin(ii) ydiffmax(ii)]);
    titlestring=['Difference in VOI Average F-val (Right-Left), ' subject_id ', ' num2str(beam_response.bands(1)) '-' num2str(beam_response.bands(2)) ' Hz'];
    title(titlestring)
   legend('VOI1 (response)','VOI2 (response)','Location','Southwest')  
   
   
end

cd ../

combinedLIaverage       = mean([stimLIaverageVOI1 responseLIaverageVOI2]);
figuretitlestring = (['Nonword Repetition: LI(VOI1) Stim = ' num2str(stimLIaverageVOI1,3) ', LI(VOI2) Response = ' ...
    num2str(responseLIaverageVOI2,3) ', Mean LI = ' num2str(combinedLIaverage,3) ]);
%setBold(figuretitlestring, 'true');
ax = subtitle(figuretitlestring)

