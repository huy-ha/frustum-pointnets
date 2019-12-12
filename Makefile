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

.PHONY: generate_disparity_training

generate_disparity_training:
	sudo /home/hqh2101/anaconda3/envs/robot-learning/bin/python ~/rahul_pl/psmnet/submission.py --loadmodel ~/rahul_pl/psmnet/kitti_3d/disp_discriminator/high_adversarial_from_104_epoch/finetune_$(epoch).tar --datapath ~/rahul_pl/KITTI/object/training/ --save_path ~/rahul_pl/KITTI/object/training/predict_disparity_epoch_$(epoch) --start_idx $(start)

.PHONY: disp_2_lidar

disp_2_lidar: 
	sudo /home/hqh2101/anaconda3/envs/robot-learning/bin/python ~/rahul_pl/preprocessing/generate_lidar.py --calib_dir ~/rahul_pl/KITTI/object/training/calib/ --save_dir ~/rahul_pl/KITTI/object/training/gan_pseudo_lidar_epoch_$(epoch) --disparity_dir ~/rahul_pl/KITTI/object/training/predict_disparity_epoch_$(epoch) --max_high 1 --start_idx $(start)
