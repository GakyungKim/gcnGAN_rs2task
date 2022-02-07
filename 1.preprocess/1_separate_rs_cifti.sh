#!/bin/bash

WB_COMMAND=/usr/bin/wb_command #path to binary for wb_command
HCP_DIR=/home/connectome/bettybetty3k/0.myResearch/GANBERT/data #path to directory containing HCP cifti timeseries
SUBJECT_PATH=/home/connectome/bettybetty3k/0.myResearch/GANBERT #path to HCP subject IDs
OUTPUT_DIR=/home/connectome/bettybetty3k/0.myResearch/GANBERT/output #path to OUTdir

SUBJECT=$SUBJECT_PATH/sublist_toy10.txt
while read -r SUBJECT;
do
    echo $SUBJECT
    #for SESSION in rfMRI_REST1_LR rfMRI_REST1_RL rfMRI_REST2_LR rfMRI_REST2_RL;
    for SESSION in rfMRI_REST1_LR rfMRI_REST1_RL;
    do
        SUBJ_DIR=$HCP_DIR/$SUBJECT/
        SUBJ_OUT_DIR=$OUTPUT_DIR/$SUBJECT/

        mkdir -p $SUBJ_OUT_DIR

        # input
        CIFTI_FILE=$SUBJ_DIR/MNINonLinear/Results/$SESSION/${SESSION}_Atlas_MSMAll_hp2000_clean.dtseries.nii

        # output
        LH_CIFTI_FILE=$SUBJ_OUT_DIR/${SESSION}_Atlas_MSMAll_hp2000_clean.L.func.gii
        RH_CIFTI_FILE=$SUBJ_OUT_DIR/${SESSION}_Atlas_MSMAll_hp2000_clean.R.func.gii
        SUBCORTICAL_FILE=$SUBJ_OUT_DIR/${SESSION}_Atlas_MSMAll_hp2000_clean.subcortical.nii.gz

        if [ -f "$CIFTI_FILE" ] && [ ! -f "$LH_CIFTI_FILE" ]; then
            echo "  $SESSION"
            $WB_COMMAND -cifti-separate  $CIFTI_FILE COLUMN -metric CORTEX_LEFT $LH_CIFTI_FILE -metric CORTEX_RIGHT $RH_CIFTI_FILE -volume-all $SUBCORTICAL_FILE
        fi
    done
done < $SUBJECT
