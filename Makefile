GO_EASY_ON_ME = 1
DEBUG = 0
TARGET = iphone:latest
ARCHS = armv7 arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AppDelete
AppDelete_FILES = Tweak.xm
AppDelete_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

BUNDLE_NAME = ADSettings
ADSettings_FILES = ADPreferenceController.m
ADSettings_INSTALL_PATH = /Library/PreferenceBundles
ADSettings_PRIVATE_FRAMEWORKS = Preferences
ADSettings_FRAMEWORKS = CoreGraphics Social UIKit
ADSettings_LIBRARIES = cephei cepheiprefs

include $(THEOS_MAKE_PATH)/bundle.mk


internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/AppDelete.plist$(ECHO_END)
	$(ECHO_NOTHING)find $(THEOS_STAGING_DIR) -name .DS_Store | xargs rm -rf$(ECHO_END)