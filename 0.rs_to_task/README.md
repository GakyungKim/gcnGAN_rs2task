# Dataset
- lab server node1 / node2 / master
  -  working directory: **/scratch/GANBERT/data/**
      -  ABCD
          -  anat
              -  t1_preprocessed
              -  t1_mask
              -  preprocessed_masked
          -  func
              -  abcd-fmriprep-rs
              -  abcd-fmriprep-task

# 0.command
- not yet (in the future, I will use this folder for keep-slurm,... data management)

# 0.data_download
- **1.HCP1200**
  - **sublist_hcp1200.txt**: subject list for HCP1200_Development
  - **download_hcp1200.sh**: command for HCP1200 sublist download
- **2.ABCD**
  - **scp_task_fMRI_ahn2cha.sh**: command for scp ABCD task fMRI from Ahn lab to Cha lab

# 1.sublist
- **example.py**: Task fMRI data is not ready -> instead, I included one example file path for the reference

# 2.preprocessing (ABCD)
- **1.masking.py**: skull-stripping process
- **2.get_data_path.py**: get data path of rs fMRI & task fMRI

# 3.demo
- **1.ABCD_PCA_site.R**: PCA by site info (ABCD)

# 4.myTavor: Tavor et al replication code
- **<1> Feature Creation**
    -  **1.do_group_pca_fmri.m**: run incremental group PCA on resting data to feed into group ICA
    -  **2.rfmri_feature_extraction.m**: create resting FMRI features
    -  **3.struct_feature_extraction.m**: create structural features
    -  **4.dmri_get_features.m**
 - **<2> Training and Predictions**
    -  **5.run_all_predictions.m**: train piecewise GLMs and make LOO(leave-one-out) predictions

# 5.image_trans
- **1.load_data.py**: load image and phenotypic data

# ActPred-master.zip
- Original Tavor et al code
