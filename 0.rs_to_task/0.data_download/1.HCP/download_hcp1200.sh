#!/bin/bash
#$ -N download_hcp1200
#$ -q all.q
#$ -m ea
#$ -S /bin/bash
#$ -cwd
#$ -l h_vmem=10G
#$ -o ../tmp/log_$JOB_ID.output
#$ -e ../tmp/log_$JOB_ID.error

subject=sublist_hcp1200.txt

while read -r subject;
do
    mkdir -p data_hcp1200/$subject
    mkdir -p data_hcp1200/$subject/T1w
    mkdir -p data_hcp1200/$subject/Diffusion
    mkdir -p data_hcp1200/$subject/fMRI

    aws s3 cp \
        s3://hcp-openaccess/HCP_1200/$subject/T1w/T1w_acpc_dc_restore_1.25.nii.gz \
        data_hcp1200/$subject/T1w \
        --region ap-south-1

    aws s3 cp \
        s3://hcp-openaccess/HCP_1200/$subject/T1w/Diffusion \
        data_hcp1200/$subject/T1w/Diffusion \
        --recursive \
        --region ap-south-1

    aws s3 cp \
        s3://hcp-openaccess/HCP_1200/$subject/T1w/Results \
        data_hcp1200/$subject/fMRI \
        --recursive \
        --region ap-south-1

done < $subject
