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

# Inherit device configuration
# NFC (SM-M307FN only, selected at boot from the bootloader version)
TARGET_USES_SLSI_NFC := true
TARGET_USES_SLSI_NFC_SKU := true

$(call inherit-product, device/samsung/m30s/device.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
## Inherit some common Halcyon stuff
$(call inherit-product, vendor/halcyon/config/common.mk)

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 28

# Client-id base
PRODUCT_GMS_CLIENTID_BASE := android-samsung-ss

# Build fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
	BuildDesc="m30sdd-user 11 RP1A.200720.012 M307FXXS4CWC2 release-keys" \
	BuildFingerprint="samsung/m30sdd/m30s:11/RP1A.200720.012/M307FXXS4CWC2:user/release-keys"

## Device configuration
PRODUCT_NAME := halcyon_m30s
PRODUCT_DEVICE := m30s
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-M307F
PRODUCT_MANUFACTURER := samsung

TARGET_BOOT_ANIMATION_RES := 1080
