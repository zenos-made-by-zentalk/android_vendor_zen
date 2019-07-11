ifneq ($(IS_GENERIC_SYSTEM_IMAGE), true)
ifeq ($(CUSTOM_BUILD_TYPE), OFFICIAL)

ifeq ($(IS_GO_VERSION), true)
CUSTOM_OTA_VERSION_CODE := pie_go
else
CUSTOM_OTA_VERSION_CODE := pie
endif

CUSTOM_PROPERTIES += \
    org.zen.ota.version_code=$(CUSTOM_OTA_VERSION_CODE) \
    sys.ota.disable_uncrypt=1

PRODUCT_PACKAGES += \
    Updates

PRODUCT_COPY_FILES += \
    vendor/zen/config/permissions/org.zen.ota.xml:system/etc/permissions/org.zen.ota.xml

endif
endif
