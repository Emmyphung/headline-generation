#!/usr/bin/env python
# coding: utf-8
#
# This script reads .json files containing news urls and scrape news' content.
# 


from data_processing import *
import time

def main(args):
    data_dir = args[1]
    outfile_dir = args[2]
    
    cwd = os.getcwd()
    # data_dir = os.path.join(cwd, dataname)
    print(data_dir)
    start_time = time.time()
    #Load train_data, dev_data, train_dev_data, test_data
    df = Processor().process(data_dir)
    
    # outfile_dir = os.path.join(cwd, outname)
    df.to_csv(outfile_dir, encoding='utf-8', index=True)
    print('The code takes {0} seconds'.format(time.time() - start_time))
    
if __name__ == '__main__': 
    sys.exit(main(sys.argv))
       

