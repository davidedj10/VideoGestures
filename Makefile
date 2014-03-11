include theos/makefiles/common.mk

TWEAK_NAME = VideoGestures
VideoGestures_FILES = Tweak.xm
VideoGestures_FRAMEWORKS = UIKit

export SDKVERSION_armv6 = 5.1
export TARGET_IPHONEOS_DEPLOYMENT_VERSION = 3.0
export TARGET_IPHONEOS_DEPLOYMENT_VERSION_armv7s = 6.0
export TARGET_IPHONEOS_DEPLOYMENT_VERSION_arm64 = 7.0
export ARCHS = armv7 armv7s arm64

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += videogesturesprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
