#/bin/bash
sudo /home/hqh2101/anaconda3/envs/robot-learning/bin/python \ 
kitti/prepare_data.py --gen_val --gen_train --gen_val_rgb_detection --lidar_dir $(2)
