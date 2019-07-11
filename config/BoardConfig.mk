include vendor/zen/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/zen/config/BoardConfigQcom.mk
endif

include vendor/zen/config/BoardConfigSoong.mk
