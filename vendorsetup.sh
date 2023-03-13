#!/bin/bash
# This file is generated for Xiaomi 12X (psyche)
# bash this file in device/xiaomi/psyche to SuperiorOS bringup

if [[ -d build ]];then
	script_mode='ANDROID_SETUP'
elif [[ -f BoardConfig.mk ]];then
	script_mode='DT_BRINGUP'
else
	script_mode='SKIP_EXIT'
fi

psyche_more_end_info(){
	cat<<EOF
	here you're on the way, eg: lunch
EOF
}

git_check_dir(){
	if [[ ! -d $3 ]];then
		mkdir -p $(dirname $3)
		git clone --depth=1 $1 -b $2 $3
	else
		echo -e "\033[1;32m=>\033[0m Found $3"
	fi
}

psyche_deps(){
	# use git_check_dir to setup dependencies
	git_check_dir https://github.com//LineageOS/android_hardware_xiaomi lineage-20 hardware/xiaomi
	git_check_dir https://github.com/stuartore/android_device_xiaomi_psyche $1 device/xiaomi/psyche
	git_check_dir https://gitlab.com/stuartore/android_vendor_xiaomi_psyche thirteen vendor/xiaomi/psyche
	git_check_dir https://gitlab.com/stuartore/vendor_xiaomi_psyche-firmware thirteen vendor/xiaomi-firmware/psyche
	git_check_dir https://github.com/VoidUI-Devices/kernel_xiaomi_sm8250.git aosp-13 kernel/xiaomi/void-aosp-sm8250

	# you can also use xiaomi_sm8250_devs kernel
	#git_check_dir https://github.com/xiaomi-sm8250-devs/android_kernel_xiaomi_sm8250.git lineage-20 kernel/xiaomi/devs-sm8250

	# clang
	git_check_dir https://github.com/EmanuelCN/zyc_clang-14.git master prebuilts/clang/host/linux-x86/ZyC-clang

	# other
	echo 'include $(call all-subdir-makefiles)' > vendor/xiaomi-firmware/Android.mk
	
	# type info when exit
	if [[ -d hardware/xiaomi ]] && [[ -d device/xiaomi/psyche ]] && [[ -d vendor/xiaomi/psyche ]] && [[ kernel/xiaomi/void-aosp-sm8250 ]] && [[ -d vendor/xiaomi-firmware/psyche ]];then
		psyche_more_end_info
	fi
}

psyche_kernel_patch(){
	# need remove 2 techpack Android.mk
	psyche_kernel_path=$(grep TARGET_KERNEL_SOURCE device/xiaomi/psyche/BoardConfig.mk | grep -v '#' | sed 's/TARGET_KERNEL_SOURCE//g' | sed 's/:=//g' | sed 's/[[:space:]]//g')

	rm -f $psyche_kernel_path/techpack/data/drivers/rmnet/perf/Android.mk
	rm -f $psyche_kernel_path/techpack/data/drivers/rmnet/shs/Android.mk	
}

dt_bringup_superior(){
	# handle aosp_psyche
	sed -i 's/aosp_psyche/superior_psyche/g' *.mk
	sed -i 's/vendor\/aosp\/config/vendor\/superior\/config/g' aosp_psyche.mk
	sed -i 's/vendor\/aosp\/config/vendor\/superior\/config/g' BoardConfig.mk
	mv aosp_psyche.mk superior_psyche.mk
	
	# handle overlay
	overlay_custom_dir=$(find . -iname "overlay-*" | sed 's/.\///g')
	mv $overlay_custom_dir overlay-superior
	sed -i 's/overlay-aosp/overlay-superior/g' *.mk
	
	# handle parts
}

psyche_rom_select(){
	if [[ -d hardware/xiaomi ]] && [[ -d device/xiaomi/psyche ]] && [[ -d vendor/xiaomi/psyche ]] && [[ kernel/xiaomi/void-aosp-sm8250 ]] && [[ -d vendor/xiaomi-firmware/psyche ]];then
		return
	fi

	select rom_to_build in "PixelExperience 13" "Superior 13" "Crdroid 13" "RiceDroid 13"
	do
		case $rom_to_build in
			"PixelExperience 13")
				dt_branch="thirteen"
				;;
			"Superior 13")
				dt_branch="superior-13"
				;;
			"Crdroid 13")
				dt_branch="crd-13"
				;;
			"RiceDroid 13")
				dt_branch="rice-13"
				;;
			*)
				echo -e "\n\033[32m=>\033[0m not selected"
				exit 1
				;;
		esac
		break
	done
	
	psyche_deps ${dt_branch}
}
case $script_mode in
	"DT_BRINGUP")
		dt_bringup_superior
		exit 0
		;;
	"ANDROID_SETUP")
		sleep .1
		;;
esac

psyche_rom_select
psyche_kernel_patch
