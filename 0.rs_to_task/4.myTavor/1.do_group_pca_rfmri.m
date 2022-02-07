%% Group Incremental PCA (Smith et al. 2014, PMC4289914)
%  Run PCA on 200 subjects (HCP release Q1+2+3)

%%
% S.Jbabdi 04/2016
% Kakyeong Kim 09/2021

%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [Input/Output] TO-BE-EDITED: Replace the below with your own
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
datadir='/Users/bettybetty3k/Desktop/GAN/datadir/toy_HCP1200'; 
%datadir='/Users/bettybetty3k/Desktop/GAN/datadir'; %just for 100206
outdir='/Users/bettybetty3k/Desktop/GAN/outdir';
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('/Users/bettybetty3k/Desktop/GAN/code/myTavor/extras','/Users/bettybetty3k/Desktop/GAN/code/myTavor/extras/CIFTIMatlabReaderWriter');
%unix(['mkdir -p ' outdir]); %%mkdir: /Users/bettybetty3k/Library/Mobile: Permission denied

sub_file = 'subjects_10_v2.txt';
subjects = textread(sub_file, '%s'); %subjects = textread('./extras/subjects_10_v2.txt','%s'); %% read subject ID (current folder; myTavor)
sessions = {'1' 'LR';'1' 'RL';
    '2' 'LR';'2' 'RL'}; %% session information
%%
% Keep components
dPCAint=1200;
dPCA=1000;
%%ㅌ
% Loop over sessions and subjects
W= [] ;
for sess = 1:1
    a=sessions{sess,1};
    b=sessions{sess,2};
       
    for s=1:length(subjects)
        subj=subjects{s};
        disp(subj); %display subj list
        subjdir = [datadir '/' subj '/fMRI' ]; 
        %subjdir=[datadir '/' subj '/MNINonLinear/Results/' ]; % for 100206
        fname=[subjdir '/rfMRI_REST' a '_' b '/rfMRI_REST' a '_' b '_Atlas_hp2000_clean.dtseries.nii'];
        %fname=[subjdir '/rfMRI_REST' a '_' b '/rfMRI_REST' a '_' b fname'_Atlas_hp2000_clean.dtseries.nii'];
        %e.g.)HCP-S900: 105923\MNINonLinear\Result\rfMRI_REST1_LR\rfMRI_REST1_LR_Atlas_hp2000_clean.dtseries.nii
        
        % read and demean data
        disp('read data');
        [cifti,BM]=open_wbfile(deblank(fname));  %deblank; rm the trailing blanks from the end of a chr % Assumes workbench is installed
        grot=demean(double(cifti.cdata)'); clear cifti.cdata;   %double; default numeric types %demean; Removes the Average or mean value.
        %grot=demean(double(fname));
        
        % noise variance normalisation
        grot = variance_normalise(grot); %variance_normalise; (( % yn = variance_normalise(y) % y is TxN ))
        % concat
        W=[W; demean(grot)]; clear grot;
        % PCA reduce W to dPCAint eigenvectors
        disp(['do PCA ' num2str(size(W,1)) 'x' num2str(size(W,2))]);
        [uu,dd]=eigs(W*W',min(dPCAint,size(W,1)-1));  W=uu'*W; clear uu;
    end
    
end
data=W(1:dPCA,:)';
%%
% Save group PCA results
dt=open_wbfile('/Users/bettybetty3k/Desktop/GAN/code/myTavor/extras/CIFTIMatlabReaderWriter/example.dtseries.nii');
dt.cdata=data;
ciftisave(dt,[outdir '/GROUP_PCA_10_RFMRI.dtseries.nii']);

