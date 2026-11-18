#
# Copyright (C) 2023 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/samsung/m30s

# Inherit common device configuration
$(call inherit-product, device/samsung/universal9611-common/common.mk)
# Inherit m30s blobs
$(call inherit-product, vendor/samsung/m30s/m30s-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += $(DEVICE_PATH)/overlay

# Screen H/W
TARGET_SCREEN_HEIGHT := 2340
TARGET_SCREEN_WIDTH := 1080

# V32
PRODUCT_PACKAGES += libutils-v32

# Shims
PRODUCT_PACKAGES += \
    libshim_ubsan

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_RETROFIT_DYNAMIC_PARTITIONS := false

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Audio configs
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/audio/mixer_gains.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_gains.xml \
    $(DEVICE_PATH)/configs/audio/mixer_gains_rc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_gains_rc.xml \
    $(DEVICE_PATH)/configs/audio/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml \
    $(DEVICE_PATH)/configs/audio/mixer_paths_rc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_rc.xml \
    $(DEVICE_PATH)/configs/audio/dax-default.xml:$(TARGET_COPY_OUT_VENDOR)/etc/dolby/dax-default.xml

# Fingerprint
PRODUCT_PACKAGES += \
     android.hardware.biometrics.fingerprint-service.samsung

PRODUCT_COPY_FILES += \
     $(DEVICE_PATH)/configs/keylayout/uinput-sec-fp.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/uinput-sec-fp.kl


# DEBUG ONLY: boot log snapshotter for eng builds
ifeq ($(TARGET_BUILD_VARIANT),eng)
PRODUCT_PACKAGES += \
    m30s-bootlog.sh \
    m30s-bootlog.rc
endif
