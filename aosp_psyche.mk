#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Project-Elixir stuff.
TARGET_SUPPORTS_QUICK_TAP := true
TARGET_BOOT_ANIMATION_RES := 1080
$(call inherit-product, vendor/aosp/config/common_full_phone.mk)
IS_PHONE := true
ELIXIR_MAINTAINER := stuartore
ELIXIR_BUILD_TYPE := UNOFFICIAL
EXTRA_UDFPS_ANIMATIONS := true
TARGET_FACE_UNLOCK_SUPPORTED := true
TARGET_INCLUDE_LIVE_WALLPAPERS := true
# Bootanimation Resolution
TARGET_BOOT_ANIMATION_RES := 1080
# Charging Animation
TARGET_INCLUDE_PIXEL_CHARGER := true
BUILD_WITH_GAPPS := true

# Inherit from psyche device
$(call inherit-product, device/xiaomi/psyche/device.mk)

# Include GMS by default, but rely on environment variable just in case we don't want to build with GMS conditionally
ifneq ($(WITH_GMS),true)
$(call inherit-product-if-exists, vendor/gapps/arm64/arm64-vendor.mk)
endif

PRODUCT_NAME := aosp_psyche
PRODUCT_DEVICE := psyche
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := 2112123AC

PRODUCT_CHARACTERISTICS := nosdcard
BUILD_FINGERPRINT := Xiaomi/psyche/psyche:12/RKQ1.211001.001/V13.0.10.0.SLDCNXM:user/release-keys

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="psyche-user 12 RKQ1.211001.001 V13.0.10.0.SLDCNXM release-keys" \
    TARGET_PRODUCT="psyche"
