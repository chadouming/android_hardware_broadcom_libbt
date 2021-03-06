LOCAL_PATH := $(call my-dir)

ifneq ($(BOARD_HAVE_BLUETOOTH_BCM),)

include $(CLEAR_VARS)

BDROID_DIR := $(TOP_DIR)system/bt

LOCAL_SRC_FILES := \
        src/bt_vendor_brcm.c \
        src/hardware.c \
        src/userial_vendor.c \
        src/upio.c \
        src/conf.c

LOCAL_C_INCLUDES += \
        $(LOCAL_PATH)/include \
        $(BDROID_DIR)/hci/include

LOCAL_SHARED_LIBRARIES := \
        libcutils \
        liblog

LOCAL_MODULE := libbt-vendor
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_OWNER := broadcom
LOCAL_PROPRIETARY_MODULE := true

ifeq ($(BOARD_HAVE_BCM_4356),true)
    LOCAL_CFLAGS += -DBCM_4356
endif

ifeq ($(BOARD_HAVE_SAMSUNG_BLUETOOTH),true)
    LOCAL_CFLAGS += -DSAMSUNG_BLUETOOTH
endif

ifeq ($(BCM_BLUETOOTH_MANTA_BUG), true)
    LOCAL_CFLAGS += -DMANTA_BUG
endif

include $(LOCAL_PATH)/vnd_buildcfg.mk

include $(BUILD_SHARED_LIBRARY)

ifeq ($(TARGET_PRODUCT), full_maguro)
    include $(LOCAL_PATH)/conf/samsung/maguro/Android.mk
endif
ifeq ($(TARGET_PRODUCT), full_crespo)
    include $(LOCAL_PATH)/conf/samsung/crespo/Android.mk
endif
ifeq ($(TARGET_PRODUCT), full_crespo4g)
    include $(LOCAL_PATH)/conf/samsung/crespo4g/Android.mk
endif
ifeq ($(TARGET_PRODUCT), full_wingray)
    include $(LOCAL_PATH)/conf/moto/wingray/Android.mk
endif

endif # BOARD_HAVE_BLUETOOTH_BCM
