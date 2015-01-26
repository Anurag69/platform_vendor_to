$(call inherit-product, device/lge/vs985/full_vs985.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/to/config/common_full_phone.mk)

# Enhanced NFC
$(call inherit-product, vendor/to/config/nfc_enhanced.mk)

$(call inherit-product, vendor/to/device/lge/g3-common/to.mk)

PRODUCT_NAME := to_vs985

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_DEVICE="g3" \
    PRODUCT_NAME="g3_vzw_us" \
    BUILD_FINGERPRINT="lge/g3_vzw/g3:4.4.2/KVT49L.VS98512B/VS98512B.1414669625:user/release-keys" \
    PRIVATE_BUILD_DESC="g3_vzw-user 4.4.2 KVT49L.VS98512B VS98512B.1414669625 release-keys"

PRODUCT_GMS_CLIENTID_BASE := android-verizon