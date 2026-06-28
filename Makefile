TARGET := iphone:clang:latest:14.0
ARCHS := arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = GameCenterHook
GameCenterHook_FILES = Tweak.x
GameCenterHook_FRAMEWORKS = UIKit GameKit

include $(THEOS_MAKE_PATH)/tweak.mk
