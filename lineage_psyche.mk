#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common PixelExperience stuff
TARGET_USES_AOSP_RECOVERY := true
TARGET_SUPPORTS_QUICK_TAP := true
TARGET_BOOT_ANIMATION_RES := 1080
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from psyche device
$(call inherit-product, device/xiaomi/psyche/device.mk)

# Include GMS by default, but rely on environment variable just in case we don't want to build with GMS conditionally
ifneq ($(NO_GMS),true)
$(call inherit-product-if-exists, vendor/gapps/arm64/arm64-vendor.mk)
endif

PRODUCT_NAME := lineage_psyche
PRODUCT_DEVICE := psyche
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := 2112123AC

PRODUCT_CHARACTERISTICS := nosdcard
BUILD_FINGERPRINT := Xiaomi/psyche/psyche:12/RKQ1.211001.001/V13.0.10.0.SLDCNXM:user/release-keys
# Face unlock
TARGET_SUPPORT_FACE_UNLOCK := true
# GMS
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
