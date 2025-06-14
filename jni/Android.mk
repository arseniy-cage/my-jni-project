LOCAL_PATH := $(call my-dir)

# Prebuilt static libraries
# Define and include each prebuilt static library separately.

include $(CLEAR_VARS)
LOCAL_MODULE := openal # Module name without 'lib' prefix
LOCAL_SRC_FILES := vendor/openal/libopenal.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := opus # Module name without 'lib' prefix
LOCAL_SRC_FILES := vendor/opus/libopus.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := enet # Module name without 'lib' prefix
LOCAL_SRC_FILES := vendor/enet/libenet.a
include $(PREBUILT_STATIC_LIBRARY)


# Main project module: sampvoice
include $(CLEAR_VARS)

LOCAL_MODULE := sampvoice
# System libraries to link against
LOCAL_LDLIBS := -llog -lOpenSLES -lGLESv2 -lEGL

# Include directories for headers
# Ensure all directories containing header files (.h) are listed here.
# *** ИСПРАВЛЕНО: Добавлен префикс 'jni/' к путям, если заголовки находятся в my-jni-project/jni/... ***
LOCAL_C_INCLUDES := $(LOCAL_PATH)/jni/vendor/ini \
                    $(LOCAL_PATH)/jni/vendor/RakNet \
                    $(LOCAL_PATH)/jni/vendor/RakNet/SAMP \
                    $(LOCAL_PATH)/jni/vendor/imgui \
                    $(LOCAL_PATH)/jni/vendor/hash \
                    $(LOCAL_PATH)/jni/voice \
                    $(LOCAL_PATH)/jni/net \
                    $(LOCAL_PATH)/jni/util \
                    $(LOCAL_PATH)/jni/cryptors \
                    $(LOCAL_PATH)/jni/game \
                    $(LOCAL_PATH)/jni/game/GTASA/Core \
                    $(LOCAL_PATH)/jni/game/GTASA/Models \
                    $(LOCAL_PATH)/jni/game/RW \
                    $(LOCAL_PATH)/jni/gtare \
                    $(LOCAL_PATH)/jni/clientlogic \
                    $(LOCAL_PATH)/jni/gui \
                    $(LOCAL_PATH)/jni/santrope-tea-gtasa/encryption # IMPORTANT: This path assumes 'santrope-tea-gtasa' is directly inside your JNI root folder.

# Source files for the sampvoice module
# List all .cpp and .c files here.
# *** ИСПРАВЛЕНО: Добавлен префикс 'jni/' ко всем путям здесь ***
LOCAL_SRC_FILES := \
    $(wildcard $(LOCAL_PATH)/jni/*.cpp) \
    $(wildcard $(LOCAL_PATH)/jni/game/*.cpp) \
    $(wildcard $(LOCAL_PATH)/jni/gtare/*.cpp) \
    $(wildcard $(LOCAL_PATH)/jni/clientlogic/*.cpp) \
    $(wildcard $(LOCAL_PATH)/jni/net/*.cpp) \
    $(wildcard $(LOCAL_PATH)/jni/util/*.cpp) \
    $(wildcard $(LOCAL_PATH)/jni/game/RW/RenderWare.cpp) \
    $(wildcard $(LOCAL_PATH)/jni/gui/*.cpp) \
    $(wildcard $(LOCAL_PATH)/jni/voice/*.cpp) \
    $(wildcard $(LOCAL_PATH)/jni/cryptors/*.cpp) \
    $(wildcard $(LOCAL_PATH)/jni/game/GTASA/Models/*.cpp) \
    $(wildcard $(LOCAL_PATH)/jni/game/GTASA/Core/*.cpp) \
    $(wildcard $(LOCAL_PATH)/jni/santrope-tea-gtasa/encryption/*.cpp) \
    $(wildcard $(LOCAL_PATH)/jni/santrope-tea-gtasa/encryption/*.c) \
    $(wildcard $(LOCAL_PATH)/jni/vendor/ini/*.cpp) \
    $(wildcard $(LOCAL_PATH)/jni/vendor/RakNet/*.cpp) \
    $(wildcard $(LOCAL_PATH)/jni/vendor/RakNet/SAMP/*.cpp) \
    $(wildcard $(LOCAL_PATH)/jni/vendor/imgui/*.cpp) \
    $(wildcard $(LOCAL_PATH)/jni/vendor/hash/md5.cpp)

# Link against the prebuilt static libraries defined above
LOCAL_STATIC_LIBRARIES := openal opus enet

# Compiler flags
LOCAL_CPPFLAGS := -w -s -fvisibility=hidden -pthread -Wall -fpack-struct=1 -O2 -std=c++14 -fexceptions
# LOCAL_CFLAGS := -Wno-error # Uncomment if you need to downgrade compile errors to warnings (use with caution)

# Build the shared library (your .so file)
include $(BUILD_SHARED_LIBRARY)
