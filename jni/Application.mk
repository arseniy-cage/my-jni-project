# Target ABIs (Application Binary Interfaces) for which to build.
# armeabi-v7a is a common 32-bit ARM architecture.
APP_ABI := armeabi-v7a

# Minimum Android API level required by your application.
# android-21 corresponds to Android 5.0 Lollipop.
APP_PLATFORM := android-21

# List of modules from Android.mk to be built.
# 'sampvoice' is the only module defined in your Android.mk.
APP_MODULES := sampvoice

# Standard Template Library (STL) to use.
# c++_static links the STL statically into your library, which is generally good for portability.
APP_STL := c++_static
