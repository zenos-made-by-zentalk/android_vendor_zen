# Set all versions
ZEN_BUILD_TYPE ?= UNOFFICIAL
ZEN_DATE_YEAR := $(shell date -u +%Y)
ZEN_DATE_MONTH := $(shell date -u +%m)
ZEN_DATE_DAY := $(shell date -u +%d)
ZEN_DATE_HOUR := $(shell date -u +%H)
ZEN_DATE_MINUTE := $(shell date -u +%M)
ZEN_MAINTAINER := None
ZEN_PLATFORM_VERSION := 9.0
ZenOS_VERSION := BETA

TARGET_PRODUCT_SHORT := $(subst zen_,,$(ZEN_BUILD))

CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)

ifeq ($(ZEN_OFFICIAL),true)
   LIST = $(shell curl -s https://raw.githubusercontent.com/zenos-made-by-zentalk/android_vendor_zen/pie/zen.devices)
   FOUND_DEVICE = $(filter $(CURRENT_DEVICE), $(LIST))
    ifeq ($(FOUND_DEVICE),$(CURRENT_DEVICE))
      IS_OFFICIAL=true
      ZEN_BUILD_TYPE := OFFICIAL
    else
      ZEN_BUILD_TYPE := UNOFFICIAL
    endif
endif   

ZEN_BUILD_DATE_UTC := $(shell date -d '$(ZEN_DATE_YEAR)-$(ZEN_DATE_MONTH)-$(ZEN_DATE_DAY) $(ZEN_DATE_HOUR):$(ZEN_DATE_MINUTE) UTC' +%s)
ZEN_NAME := ZenOS-$(ZenOS_VERSION)-$(CURRENT_DEVICE)-$(ZEN_BUILD_TYPE)-$(ZEN_BUILD_DATE)
ZEN_BUILD_DATE := $(ZEN_DATE_YEAR)$(ZEN_DATE_MONTH)$(ZEN_DATE_DAY)-$(ZEN_DATE_HOUR)$(ZEN_DATE_MINUTE)
ZEN_VERSION := ZenOS-$(ZEN_BUILD)-$(ZEN_PLATFORM_VERSION)-$(ZEN_BUILD_DATE)-$(ZEN_BUILD_TYPE)
ZEN_FINGERPRINT := ZenOS/$(ZEN_PLATFORM_VERSION)/$(ZEN_PRODUCT_SHORT)/$(ZEN_BUILD_DATE)

ZEN_PROPERTIES := \
    org.zen.version=$(ZenOS_VERSION) \
    org.zen.build_date=$(ZEN_BUILD_DATE) \
    org.zen.build_date_utc=$(ZEN_BUILD_DATE_UTC) \
    org.zen.build_type=$(ZEN_BUILD_TYPE) \
    org.zen.fingerprint=$(ZEN_FINGERPRINT) \
    org.zen.maintainer=$(ZEN_MAINTAINER)
