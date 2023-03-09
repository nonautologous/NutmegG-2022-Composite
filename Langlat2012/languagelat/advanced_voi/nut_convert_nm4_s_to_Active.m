function CTFpseudoF_s = nut_convert_nm4_s_to_Active_nc(s)
%function CTFpseudoF_s = nut_convert_nm4_s_to_CTFpseudoF(s)

% Converts nutmeg4.1+ tfbf output s variable to CTF pseudo F
% Taken from nutmeg4.1 code nut_results_viewer, line 1380
% s{1} = active power
% s{2} = control power
% s{3} = noise power
% 
% AMF 8/7/2015
%
% changed a bit so output would be a cell array to match input
% CTFpseudoF_s{1} will have dimensions of (timepts,timewinds,freqbins)
% Code for converting to CTF psuedo F ratio was adapted from
% nut_results_viewer.
% AMF 8/11/2015
   
%ratio_s{1} = zeros(size(s{1},1),size(s{1},2),size(s{1},3));
CTFpseudoF_s{1} = zeros(size(s{1},1),size(s{1},2),size(s{1},3));

if (ndims(s{1}) < 4 && size(s,2) ==3)
    ratio_s = (s{1} - s{3})./(s{2} - s{3}); %Create ratio
    for timewin = 1:size(s{1},2) %iterate over time windows, earliest first
        for freqbin = 1:size(s{1},3)
            selectpos = find(ratio_s(:,timewin,freqbin)>=1);
            selectneg = find(ratio_s(:,timewin,freqbin)<1 & ratio_s(:,timewin,freqbin)>0);
            CTFpseudoF_s{1}(selectpos,timewin,freqbin) = ratio_s(selectpos,timewin,freqbin) - 1;
            CTFpseudoF_s{1}(selectneg,timewin,freqbin) = 1-(1./ratio_s(selectneg,timewin,freqbin));
        end
    end
else
    text = sprintf('s is the wrong size to convert to CTF pseudo F \rndims(s{1}) < 4 AND size(s,2) == 3 for this to work');
    disp(text)
end
