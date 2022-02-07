import argparse
import os
import pandas as pd
import re
import shutil
import nibabel as nib
import numpy as np
import pickle
from glob import glob
parser = argparse.ArgumentParser(description='')
parser.add_argument('--file_path', dest='path_prep', type=str, help='destination of original nii.gz files')
parser.add_argument('--mask_path', dest='path_mask', type=str, help='destination of mask nii.gz files')
parser.add_argument('--output_path', dest='path_output', type=str, help='destination of output files')
#parser.add_argument('--csv_file', dest='csv_file', type=str, help='destination of csv file')
#parser.add_argument('--mask', dest='mask', default="N", help='destination of csv file')
args = parser.parse_args()
def get_list(dirName):
    # create a list of file and sub directories 
    # names in the given directory 
    listOfFile = os.listdir(dirName)
    allFiles = list()
    # Iterate over all the entries
    for entry in listOfFile:
        # Create full path
        fullPath = os.path.join(dirName, entry)
        # If entry is a directory then get the list of files in this directory 
        if os.path.isdir(fullPath):
            allFiles = allFiles + get_list(fullPath)
        else:
            allFiles.append(fullPath)
    allFiles.sort()
    return allFiles
def main():
    path_prep = args.path_prep
    path_mask = args.path_mask
    list_prep = get_list(path_prep)
    list_mask = [re.sub(path_prep,path_mask,p) for p in list_prep]
    if os.path.isdir(args.path_output) is False:
        os.mkdir(args.path_output)
    if os.path.isdir(os.path.join(args.path_output,"case/")) is False:
        os.mkdir(os.path.join(args.path_output,"case/"))
    if os.path.isdir(os.path.join(args.path_output,"control/")) is False:
        os.mkdir(os.path.join(args.path_output,"control/"))
    for i in range(len(list_prep)):
        mask = list_mask[i]
        prep = list_prep[i]
        try:
            mask = nib.load(mask).dataobj[...]
            prep = nib.load(prep).dataobj[...]
            final = np.multiply(mask,prep)
            np.save(re.sub(path_prep,args.path_output,list_prep[i]).split(".")[0], final)
        except:
            print("*** No Mask: " + list_prep[i])
if __name__ == "__main__":
    main()
