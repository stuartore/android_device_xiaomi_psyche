#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# SuperiorOS Stuff
TARGET_USES_AOSP_RECOVERY := true
TARGET_SUPPORTS_QUICK_TAP := true
SUSHI_BOOTANIMATION := 1440
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from psyche device
$(call inherit-product, device/xiaomi/psyche/device.mk)

# Gapps
WITH_GMS := true
TARGET_CORE_GMS := true
TARGET_GAPPS_ARCH := arm64

# Rice Target
TARGET_ENABLE_BLUR := true

# Rice stuff
RICE_OFFICIAL := false
RICE_CHIPSET := "Snapdragon 870 5G"
RICE_MAINTAINER := "stuartore"

# UDFPS ICONS/ANIMATIONS
TARGET_HAS_UDFPS := true

PRODUCT_NAME := lineage_psyche
PRODUCT_DEVICE := psyche
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := 2112123AC

PRODUCT_CHARACTERISTICS := nosdcard
BUILD_FINGERPRINT := Xiaomi/psyche/psyche:12/RKQ1.211001.001/V13.0.10.0.SLDCNXM:user/release-keys
