## ========= load module ========= ##
import os
import sys
from pathlib import path
import numpy as np

## ========= set data path ========= ##
path_rs = Path(os.environ['SCRATCH']) / 'abcd-fmriprep-rs-untar'
path_task = Path(os.environ['SCRATCH']) / 'abcd-fmriprep-task'

path_out_rs = Path(os.environ['SCRATCH']) / 'abcd-fmriprep-out-rs'
path_out_task = Path(os.environ['SCRATCH']) / 'abcd-fmriprep-out-task'

path_cwd = Path.cwd()

## ========= rs image files ========= ##
cmds_rs = []
dirs_deri_rs = sorted(path_rs.glob('fmriprep-deri-*'))

for d in dirs_deri_rs:
    fns_fmri = sorted(d.glob('fmriprep/sub-*/ses-*/func/*_bold.nii.gz'))
    subj = d.name.replace('fmriprep-deri', 'sub')
    dir_out_rs = str(path_out_rs / subj)

    for fn_fmri in fns_fmri:
        cmds_rs.append(' '.join([CMD_CONV, str(fn_fmri), rs_dir_out, '\n']))

with open('./jobs.txt', 'w') as f:
    f.writelines(cmds_rs)

## ========= task image files ========= ##
cmds_task = []
dirs_deri_task = sorted(path_task.glob('fmriprep-deri-*'))

for d in dirs_deri_task:
    fns_fmri = sorted(d.glob('fmriprep/sub-*/ses-*/func/*_bold.nii.gz'))
    subj = d.name.replace('fmriprep-deri', 'sub')
    dir_out_task = str(path_out_task / subj)

    for fn_fmri in fns_fmri:
        cmds_task.append(' '.join([CMD_CONV, str(fn_fmri), rs_dir_out, '\n']))

with open('./jobs.txt', 'w') as f:
    f.writelines(cmds_task)
