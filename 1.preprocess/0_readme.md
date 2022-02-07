### 1_separate_rs_cifti.sh
- example code with 1 subject
  - $WB_COMMAND -cifti-separate  $CIFTI_FILE COLUMN -metric CORTEX_LEFT $LH_CIFTI_FILE -metric CORTEX_RIGHT $RH_CIFTI_FILE -volume-all $SUBCORTICAL_FILE
```/usr/bin/wb_command -cifti-separate /home/connectome/bettybetty3k/0.myResearch/GANBERT/data/100206/MNINonLinear/Results/rfMRI_REST1_LR/rfMRI_REST1_LR_Atlas_MSMAll_hp2000_clean.dtseries.nii - metric CORTEX_LEFT /home/connectome/bettybetty3k/0.myResearch/GANBERT/output/rfMRI_REST1_LR_Atlas_MSMAll_hp2000_clean.L.func.gii -metric CORTEX_RIGHT /home/connectome/bettybetty3k/0.myResearch/GANBERT/output/rfMRI_REST1_LR_Atlas_MSMAll_hp2000_clean.R.func.gii -volume-all /home/connectome/bettybetty3k/0.myResearch/GANBERT/output/rfMRI_REST1_LR_Atlas_MSMAll_hp2000_clean.subcortical.nii.gz```

### 2_compute_rs_fingerprint.py
```python3 2_compute_rs_fingerprint.py --input_dir /home/connectome/bettybetty3k/0.myResearch/GANBERT/data --subj_ids /home/connectome/bettybetty3k/0.myResearch/GANBERT --node_ts_dir /home/connectome/bettybetty3k/0.myResearch/GANBERT/data --output_dir /home/connectome/bettybetty3k/0.myResearch/GANBERT/output --num_ics 50 --num_samples 8```
