PRODUCT_BRAND ?= ZenOS

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    ro.setupwizard.rotation_locked=true

# Default notification/alarm sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.notification_sound=Popcorn.ogg \
    ro.config.alarm_alert=Bright_morning.ogg

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.dun.override=0
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Ambient Play
PRODUCT_PACKAGES += \
    AmbientPlayHistoryProvider

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/zen/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/zen/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/zen/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh \
    vendor/zen/prebuilt/common/bin/blacklist:system/addon.d/blacklist

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/zen/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/zen/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/zen/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Bootanimation
ifeq ($(TARGET_BOOT_ANIMATION_RES),720)
     PRODUCT_COPY_FILES += vendor/zen/media/bootanimation_720.zip:system/media/bootanimation.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),1080)
     PRODUCT_COPY_FILES += vendor/zen/media/bootanimation_1080.zip:system/media/bootanimation.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),1440)
     PRODUCT_COPY_FILES += vendor/zen/media/bootanimation_1440.zip:system/media/bootanimation.zip
else
     $(warning "ZenOS: TARGET_BOOT_ANIMATION_RES is undefined, assuming 1080p")
     PRODUCT_COPY_FILES += vendor/zen/media/bootanimation_1080.zip:system/media/bootanimation.zip
endif

# Some permissions
PRODUCT_COPY_FILES += \
    vendor/zen/config/permissions/backup.xml:system/etc/sysconfig/backup.xml \
    vendor/zen/config/permissions/privapp-permissions-aosp.xml:system/etc/permissions/privapp-permissions-aosp.xml \
    vendor/zen/config/permissions/org.lineageos.snap.xml:system/etc/permissions/org.lineageos.snap.xml \
    vendor/zen/config/permissions/privapp-permissions-custom.xml:system/etc/permissions/privapp-permissions-custom.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/zen/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/zen/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# Copy all custom init rc files
$(foreach f,$(wildcard vendor/zen/prebuilt/common/etc/init/*.rc),\
    $(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/zen/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/zen/config/permissions/custom-power-whitelist.xml:system/etc/sysconfig/custom-power-whitelist.xml

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Optional packages
PRODUCT_PACKAGES += \
    LiveWallpapersPicker

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/zen/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/zen/overlay/common

# Cutout control overlay
PRODUCT_PACKAGES += \
    NoCutoutOverlay

# SetupWizard overlay
PRODUCT_PACKAGES += \
    SetupWizardOverlay

# Branding
include vendor/zen/config/branding.mk

# OTA
include vendor/zen/config/ota.mk

# Pixel Style
include vendor/pixelstyle/config.mk

# Themes
include vendor/themes/config.mk

-include $(WORKSPACE)/build_env/image-auto-bits.mk
