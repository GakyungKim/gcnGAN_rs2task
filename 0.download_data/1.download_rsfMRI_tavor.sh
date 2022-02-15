#!/bin/bash
  
subject=sublist_hcp1200.txt

while read -r subject;
do
        ### rsfMRI
        aws s3 cp s3://hcp-openaccess/HCP_1200/${subject}/MNINonLinear/Results/rfMRI_REST1_LR/rfMRI_REST1_LR_Atlas_hp2000_clean.dtseries.nii data/${subject}/MNINonLinear/Results/rfMRI_REST1_LR
        aws s3 cp s3://hcp-openaccess/HCP_1200/${subject}/MNINonLinear/Results/rfMRI_REST1_RL/rfMRI_REST1_RL_Atlas_hp2000_clean.dtseries.nii data/${subject}/MNINonLinear/Results/rfMRI_REST1_RL

        aws s3 cp s3://hcp-openaccess/HCP_1200/${subject}/MNINonLinear/Results/rfMRI_REST2_LR/rfMRI_REST2_LR_Atlas_hp2000_clean.dtseries.nii data/${subject}/MNINonLinear/Results/rfMRI_REST2_LR
        aws s3 cp s3://hcp-openaccess/HCP_1200/${subject}/MNINonLinear/Results/rfMRI_REST2_RL/rfMRI_REST2_RL_Atlas_hp2000_clean.dtseries.nii data/${subject}/MNINonLinear/Results/rfMRI_REST2_RL
done < $subject
