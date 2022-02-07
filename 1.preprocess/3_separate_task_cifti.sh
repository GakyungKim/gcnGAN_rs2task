#!/bin/bash
WB_COMMAND=$1 #/usr/bin/wb_command
HCP_DIR=$2 #/home/connectome/bettybetty3k/0.myResearch/GANBERT/data
SUBJLIST=$3 #/home/connectome/bettybetty3k/0.myResearch/GANBERT
OUTPUT_DIR=$4 #/home/connectome/bettybetty3k/0.myResearch/GANBERT/output


declare -A TASK_COPEIDS=( ["LANGUAGE"]="1 2 3" ["RELATIONAL"]="1 2 3" ["SOCIAL"]="1 2 6" ["EMOTION"]="1 2 3" \
                          ["WM"]="1 2 3 4 5 6 7 8 9 10 11 15 16 17 18 19 20 21 22" \
                          ["MOTOR"]="1 2 3 4 5 6 7 8 9 10 11 12 13" \
                          ["GAMBLING"]="1 2 3" )
SUBJECT=sublist_toy10.txt

while read -r SUBJECT;
do
    echo $SUBJECT
    SUBJ_DIR=$HCP_DIR/$SUBJECT/

    for TASK in "${!TASK_COPEIDS[@]}";
    do
        declare -a COPEIDS="${TASK_COPEIDS[$TASK]}"
        for COPEID in $COPEIDS
        do
            SUBJ_OUT_DIR=$OUTPUT_DIR/$SUBJECT/$TASK/cope$COPEID.feat
            mkdir -p $SUBJ_OUT_DIR
            
            ## input
            CIFTI_FILE=$SUBJ_DIR/MNINonLinear/Results/tfMRI_$TASK/tfMRI_${TASK}_hp200_s2_level2_MSMAll.feat/GrayordinatesStats/cope${COPEID}.feat/zstat1.dtseries.nii

            ## output
            LH_NIFTI_FILE=$SUBJ_OUT_DIR/zstat1.L.func.gii
            RH_NIFTI_FILE=$SUBJ_OUT_DIR/zstat1.R.func.gii
            SUBCORTICAL_FILE=$SUBJ_OUT_DIR/zstat1.subcortical.nii.gz

            if [ -f "$CIFTI_FILE" ] && [ ! -f "$LH_NIFTI_FILE" ]; then
                $WB_COMMAND -cifti-separate  $CIFTI_FILE COLUMN -metric CORTEX_LEFT $LH_NIFTI_FILE -metric CORTEX_RIGHT $RH_NIFTI_FILE -volume-all $SUBCORTICAL_FILE
            fi
        done
    done
done < $SUBJLIST
