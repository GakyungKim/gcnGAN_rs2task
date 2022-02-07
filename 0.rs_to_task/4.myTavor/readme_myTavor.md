-- These Matlab scripts can be used to produce the results from Tavor et al. Science 2016

-- Dependencies:
   - Matlab (we used 2014a but it should all work with previous versions)
   - FSL 5 (www.fmrib.ox.ac.uk/fsl)
   - Workbench (www.humanconnectome.org)
   - FastICA toolbox (http://research.ics.aalto.fi/ica/fastica)
   - Graph_toolbox (https://github.com/gpeyre)
   
-- It is assumed that FSL and Workbench can be called from matlab using the unix() command

-- Scripts:
   -- Feature creation

      do_group_pca_rfmri.m : run incremental group PCA on resting data to feed into group ICA

      rfmri_feature_extraction.m  : create resting FMRI features

      struct_feature_extraction.m : create structural features


   -- Training and predictions

      run_all_predictions.m : train piecewise GLMs and make LOO predictions
      
## 0. set environment
- Workbench
- Caret: http://brainvis.wustl.edu/wiki/index.php/Caret:Download
```
apt-get install caret

brew install caret
```
- iCloud issues: https://kr.mathworks.com/matlabcentral/answers/449900-use-files-from-icloud-drive-on-matlab

## 1.do_group_pca_rfmri.m
- What is incremental PCA? (https://hgmin1159.github.io/dimension/mf4/)
  - PCA (Principal Component Analysis)
    -  행렬 분해 통해 가장 많은 분산을 가지는 축을 찾는 방법
  -  Incremental PCA
      -   PCA 단점에 대응하기 위해, 모든 데이터를 한 번에 분석하는 것이 아니라 Batch Size 만큼 조금씩 분석해가며 목표로 하는 Singular Vector를 찾아냄.
- cf) https://github.com/ColeLab/actflowmapping
