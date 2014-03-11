include theos/makefiles/common.mk

BUNDLE_NAME = videogesturesprefs
videogesturesprefs_FILES = videogesturesprefs.mm
videogesturesprefs_INSTALL_PATH = /Library/PreferenceBundles
videogesturesprefs_FRAMEWORKS = UIKit
videogesturesprefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/videogesturesprefs.plist$(ECHO_END)
