PRODUCT_BRAND ?= teamoctos

# Include OctOS bootanimation
include vendor/to/config/bootanimation.mk

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# OMS Verified
PRODUCT_PROPERTY_OVERRIDES += \
    ro.substratum.verified=true

#Pixel Launcher
PRODUCT_COPY_FILES += \
    vendor/to/prebuilt/common/apk/PixelLauncher.apk:system/priv-app/PixelLauncher/PixelLauncherPrebuilt.apk \
    vendor/to/prebuilt/common/apk/PixelLauncherIcons.apk:system/app/pixellaunchericons/PixelLauncherIcons.apk \
    vendor/to/prebuilt/common/apk/WallpaperPickerGoogle.apk:system/app/WallpaperPickerGoogle/WallpaperPickerGooglePrebuilt.apk

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.alarm_alert=Hassium.ogg \
    ro.config.ringtone=Titania.ogg \
    ro.config.notification_sound=Tethys.ogg \

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0
endif

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=0
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/to/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/to/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/to/prebuilt/common/bin/50-cm.sh:system/addon.d/50-cm.sh \
    vendor/to/prebuilt/common/bin/blacklist:system/addon.d/blacklist

# System feature whitelists
PRODUCT_COPY_FILES += \
    vendor/to/config/permissions/backup.xml:system/etc/sysconfig/backup.xml \
    vendor/to/config/permissions/power-whitelist.xml:system/etc/sysconfig/power-whitelist.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/to/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/to/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/to/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/to/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# CM-specific init file
PRODUCT_COPY_FILES += \
    vendor/to/prebuilt/common/etc/init.local.rc:root/init.cm.rc

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/to/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is CM!
PRODUCT_COPY_FILES += \
    vendor/to/config/permissions/com.cyanogenmod.android.xml:system/etc/permissions/com.cyanogenmod.android.xml

ifneq ($(TARGET_DISABLE_CMSDK), true)
# CMSDK
include vendor/to/config/cmsdk_common.mk
endif

# Required CM packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    CMAudioService \
    CMParts \
    Development \
    Jelly \
    Profiles \
    WeatherManagerService

# OMS interfacer
PRODUCT_PACKAGES += \
   ThemeInterfacer

# OctOs packages
PRODUCT_PACKAGES += \
    AboutOctOs \
    OctOTA \
    OmniJaws \
    OmniSwitch \
    OmniStyle \
    PixelLauncher

# Optional CM packages
PRODUCT_PACKAGES += \
    libemoji \
    LiveWallpapersPicker \
    PhotoTable \
    Terminal

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Custom CM packages
PRODUCT_PACKAGES += \
    AudioFX \
    CMSettingsProvider \
    CMUpdater \
    Eleven \
    ExactCalculator \
    LiveLockScreenService \
    LockClock \
    WallpaperPicker \
    WeatherProvider

PRODUCT_PROPERTY_OVERRIDES += \
    ro.opa.eligible_device=true

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Extra tools in CM
PRODUCT_PACKAGES += \
    7z \
    bash \
    bzip2 \
    curl \
    fsck.ntfs \
    gdbserver \
    htop \
    lib7z \
    libsepol \
    micro_bench \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs \
    oprofiled \
    pigz \
    powertop \
    sqlite3 \
    strace \
    tune2fs \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Custom off-mode charger
ifneq ($(WITH_CM_CHARGER),false)
PRODUCT_PACKAGES += \
    charger_res_images \
    cm_charger_res_images \
    font_log.png \
    libhealthd.cm
endif

# ExFAT support
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank

# Conditionally build in su
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

#DU Utils Library
PRODUCT_PACKAGES += \
    org.dirtyunicorns.utils

PRODUCT_BOOT_JARS += \
    org.dirtyunicorns.utils

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=3

DEVICE_PACKAGE_OVERLAYS += vendor/to/overlay/common

# Include OctOS versioning
include vendor/to/config/to_versioning.mk

PRODUCT_PROPERTY_OVERRIDES += \
  ro.to.display.version=$(TO_DISPLAY_VERSION)

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/to/config/partner_gms.mk
-include vendor/cyngn/product.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)
