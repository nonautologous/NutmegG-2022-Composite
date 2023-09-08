% fcm_set_Limage   2nd part of connectivity map analysis [in MATLAB].
%
% Usage: cd to the subjects directory, then simply type: fcm_set_Limage
%



% Import or load source time series
%----------------------------------
tic
if ~exist('RestingState_Virtual_L_1-20Hz.mat','file')
    disp('Importing source time series...')
    ctf=ctf_read('RestingState_Virtual_L.ds','sam');

    goodchannels=find(any(ctf.data));   %(:,:,1)
    V=ctf.data(:,goodchannels,:);
    voxels=zeros(length(goodchannels),3);
    index=ctf.sensor.index.sam(goodchannels);
    for k=1:length(goodchannels)
        voxels(k,1)=ctf.sensor.info(index(k)).coil(1).position.x;
        voxels(k,2)=ctf.sensor.info(index(k)).coil(1).position.y;
        voxels(k,3)=ctf.sensor.info(index(k)).coil(1).position.z;
    end
    voxels=voxels*10;
    lab=ctf.sensor.label(goodchannels);
    t=ctf.setup.time_sec;
    clear ctf
    save RestingState_Virtual_L_1-20Hz.mat V t voxels
    !rm -r RestingState_Virtual_L.ds
else
    disp('Loading source time series...')
    load RestingState_Virtual_L_1-20Hz.mat
end
clear V

% Define individual alpha band
%-----------------------------
if ~exist('alpharange.mat','file')
    fprintf('\n\n\nDefinition of individual alpha range.\n\n')
    d=dir('RestingState_Sensor_*.ds');
    if length(d)>1
        disp('Which file would you like to use for sensor data?')
        for k=1:length(d)
            fprintf('%d  %s\n',k,d(k).name)
        end
        sel=input('Select number: ');
    else
        sel=1;
    end
    disp('Importing sensor data...')
    ctf=ctf_read(d(sel).name,'o');      % load occipital channels
    D=ctf.data; td=ctf.setup.time_sec; clear ctf
    fsd=round(1/(td(2)-td(1)));
    disp('Filtering sensor data...')
    D=nut_filter2(D,'firls','bp',200,1,50,fsd,1);
    
    disp('Calculating power spectrum of sensor data...')
    for k=1:size(D,2)
        [Pv(:,k),fPv]=pwelch(D(:,k),2*fsd,fsd,2^nextpow2(fsd/2),fsd);      % Power Spectrogram
    end
    f=find(fPv<=20);
    Pv=Pv(f,:);  fPv=fPv(f); clear f
    figure
    answ='No';
    while ~strcmp(answ,'Yes')
        cla
        plot(fPv,mean(10.*log10(Pv),2),'b-x')
        title('Select LOWER bound of individual alpha range','fontsize',14,'fontweight','bold')
        pos=ginput(1);
        frqlim(1)=floor(pos(1));
        line([frqlim(1) frqlim(1)],get(gca,'ylim'),'color','r')
        title('Select UPPER bound of individual alpha range','fontsize',14,'fontweight','bold')
        pos=ginput(1);
        frqlim(2)=ceil(pos(1));
        line([frqlim(2) frqlim(2)],get(gca,'ylim'),'color','r')
        answ=questdlg('Would you like to continue with these alpha frequency bounds?','Alpha Selection','Yes','No, let me do it again','Yes');
    end
    save alpharange frqlim
    clear Pv fPv D td fsd d f k answ pos sel
    close(gcf)
else
    disp('Loading individual alpha range defined previously')
    load alpharange
end


% Define or load tumor voxel indices
%-----------------------------------
if ~exist('tumorvoxels.mat','file') 
    nutmeg
    global nuts
    happy='No'; while ~strcmp(happy,'Yes')
        if ~exist('coreg.mat','file')
            nuts.coreg=nut_CoregistrationTool(nuts.coreg);
            coreg=nuts.coreg;
            save coreg coreg
            clear coreg
        else
            load coreg
            nuts.coreg=coreg; clear coreg
            nut_refresh_image;
        end

        hm=msgbox(sprintf('Instructions:\n1. Place the mouse cursor at the center of the tumor.\n2. Select tumor voxels with nutmeg (menu "Manual VOI" --> "Select VOI").\n3. Click the Ok button below only after you are done with steps 1 and 2!!'));
        waitfor(hm)

        happy=questdlg('Are you happy with these tumor voxel selections?','fcm_set_Limage','Yes','No, let me do it again','Yes');
    end, clear happy
    
    VOIvoxels=nuts.VOIvoxels;
    save tumorvoxels VOIvoxels
    nut_close;
else
    disp('Loading tumor region defined previously.')
    load tumorvoxels
end

% This is a strange but fast way of finding tumor voxels, works only for 8mm
% voxelsize!
if isfield(VOIvoxels,'MEGvoxels')
    TV=unique(floor(VOIvoxels.MEGvoxels/4),'rows');
elseif isfield(VOIvoxels,'VOIvoxels')
    TV=unique(floor(VOIvoxels.VOIvoxels/4),'rows');
else 
    TV=unique(floor(VOIvoxels/4),'rows');
end
rvoxels=round(voxels);

f=find(~rem(TV(:,1),2) | ~rem(TV(:,2),2) | ~rem(TV(:,3),2));
TV=TV(f,:)*4;

tuv=find(ismember(rvoxels,TV,'rows'));
clear TV

% Define connections between voxel pairs for L-image
%---------------------------------------------------
docon=true;
if exist('comps','dir')
    answer=questdlg('A folder named "comps" with connection definitions already exists in the current directory. What do you want to do with it?', ...
                       'fcm_set_Limage', ...
                       'Overwrite','Use existing','Overwrite');
    docon=strcmp(answer,'Overwrite');
    if docon
        !rm -r comps
    end
end

if docon
    jump=4;
    lim=tuv';

    for k=1:3
        dum{k}=unique(rvoxels(:,k));
        beg(k)=rem(length(dum{k}),jump); if beg(k)==0, beg(k)=jump; end
        beg(k)=1+floor(beg(k)/2);
    end
    grid=find(ismember(rvoxels(:,1),[dum{1}(beg(1):jump:end)]) & ismember(rvoxels(:,2),[dum{2}(beg(2):jump:end)]) & ismember(rvoxels(:,3),[dum{3}(beg(3):jump:end)]))';
    clear dum beg

    nonselgrid  = setdiff(grid,lim);
    selgrid     = intersect(lim,grid);
    selnongrid  = setdiff(lim,selgrid);
    num_sel         = length(lim);
    num_nonselgrid  = length(nonselgrid);
    num_selgrid     = length(selgrid);
    num_selnongrid  = num_sel-num_selgrid;
    num_grid        = length(grid);

    %ncomps=num_sel*num_nonselgrid + num_selgrid*num_selnongrid + (num_selgrid*(num_selgrid-1))/2;
    ncomps=num_sel*num_nonselgrid + num_selgrid*num_selnongrid + num_selgrid*(num_selgrid-1);
    comps=zeros(ncomps,2);

    currstart=1;
    for cc=selgrid
        %curr2 = [nonselgrid setdiff(selgrid,cc)]';
        %currlength=length(curr2);
        currend=currstart+num_grid-2;
        comps(currstart:currend,:)=[cc*ones(num_grid-1,1) setdiff(grid,cc)'];
        currstart=currend+1;
    end
    for cc=selnongrid
        %curr2 = [nonselgrid selgrid]';
        %currlength=length(curr2);
        currend=currstart+num_grid-1;
        comps(currstart:currend,:)=[cc*ones(num_grid,1) grid'];
        currstart=currend+1;
    end
    comps=sortrows(comps);

    vox2comp=unique(comps(:));
    %num_vox2comp=length(vox2comp);

    cocomps=zeros(size(comps));
    for k=vox2comp'
        f = find(comps(:)==k);
        c = find(ismember( rvoxels , rvoxels(k,:).*[1 -1 1] , 'rows' ));
        if ~isempty(c)
            cocomps(f)=c;
        else
            cocomps(f)=NaN;
        end
    end

    c2del=find(any(isnan(cocomps),2));
    comps(c2del,:)=[];
    cocomps(c2del,:)=[];

    ncomps=size(comps,1);
    step=ceil(ncomps/9);
    index=1:step;

    mkdir comps
    cd comps
    for k=1:9
        CI=comps(index,:);
        CC=cocomps(index,:);
        eval(sprintf('save -ascii CI%d.txt CI',k))
        eval(sprintf('save -ascii CC%d.txt CC',k))
        index=index+step;
        index=index(find(index<=ncomps));
    end
    cd ..

    fprintf('\nDefined %d connections between %d tumor voxels\nand a whole-brain grid of %d voxels.\n\n',size(comps,1),num_sel,num_grid)    
else
    fprintf('\nUsing connections defined in folder "comps".\n\n')
end


% Determine if local or Qsub
%-----------------
if exist('alpharange.mat','file')
    alpha=load("alpharange.mat")
    a1=alpha.frqlim(1)
    a2=alpha.frqlim(2)
else
    a1=7;a2=12
end

sel=menu('The next step is calculating the imaginary coherence for all defined connections. How would you like to run your qsub jobs?', ...
    'Qsub (preferred)', ...
    'Local', ...
    'Cancel');
switch sel
    case 1
        unix( sprintf( 'qLimage_64 RestingState_Virtual_L_1-20Hz.mat %d %d 2 1 %d\n',frqlim,2^nextpow2( 0.5/(t(2)-t(1)) ) ) );
        fprintf('\nYour qsub jobs were submitted. Wait until they are done, then type:\nfcm_get_Limage\n')
    case 2
        for q=1:2
            qq=["CC" "CI"]
            for i=1:9
                runimcoh('RestingState_Virtual_L_1-20Hz.mat',sprintf('comps/%s%d.txt',qq(q),i),'b',a1,a2,2,1,512)
            end
        end
end
toc