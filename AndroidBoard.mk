#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),m30s)
include device/samsung/universal9611-common/AndroidBoardPieLaunched.mk
endif
