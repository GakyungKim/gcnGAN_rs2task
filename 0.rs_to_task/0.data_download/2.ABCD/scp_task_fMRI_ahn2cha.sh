## 1st trial
rsync -zarv -e 'ssh -p 7777' kimhj9502@ccsl1.snu.ac.kr:/data3/ABCD2/fmriprep-task/ /scratch/bigdata/ABCD

## 2nd trial (--ignore-existing)
rsync -zarv --ignore-existing --size-only -e 'ssh -p 7777' kimhj9502@ccsl1.snu.ac.kr:/data3/ABCD2/fmriprep-task/ /scratch/bigdata/ABCD
