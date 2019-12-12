.PHONY: all

all: prep_data eval

.PHONY: prep_data
prep_data:
	sh scripts/command_prep_data.sh

.PHONY: eval
eval:
	CUDA_VISIBLE_DEVICES=0 sh scripts/command_test_v1.sh

.PHONY: set_pseudo_lidar

set_pseudo_lidar:
	sudo rm -f /home/rs3871/pseudo_lidar/KITTI/object/training/velodyne
	sudo ln -s /home/rs3871/pseudo_lidar/KITTI/object/training/gan_pseudo_lidar_epoch_$(epoch) /home/rs3871/pseudo_lidar/KITTI/object/training/velodyne
	    
.PHONY: set_real_lidar

set_real_lidar:
	sudo rm -f /home/rs3871/pseudo_lidar/KITTI/object/training/velodyne
	sudo ln -s /home/rs3871/pseudo_lidar/KITTI/object/training/original_velodyne /home/rs3871/pseudo_lidar/KITTI/object/training/velodyne
