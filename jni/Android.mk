LOCAL_PATH := $(call my-dir)

# Prebuilt static libraries
# Define and include each prebuilt static library separately.

include $(CLEAR_VARS)
LOCAL_MODULE := openal
LOCAL_SRC_FILES := vendor/openal/libopenal.a # Относительно LOCAL_PATH (т.е. jni/vendor/openal/libopenal.a)
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := opus
LOCAL_SRC_FILES := vendor/opus/libopus.a # Относительно LOCAL_PATH
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := enet
LOCAL_SRC_FILES := vendor/enet/libenet.a # Относительно LOCAL_PATH
include $(PREBUILT_STATIC_LIBRARY)


# Main project module: sampvoice
include $(CLEAR_VARS)

LOCAL_MODULE := sampvoice
# System libraries to link against
LOCAL_LDLIBS := -llog -lOpenSLES -lGLESv2 -lEGL

# Include directories for headers
# Ensure all directories containing header files (.h) are listed here.
# *** ИСПРАВЛЕНО: Убран лишний 'jni/' из всех путей ***
LOCAL_C_INCLUDES := $(LOCAL_PATH)/vendor/ini \
                    $(LOCAL_PATH)/vendor/RakNet \
                    $(LOCAL_PATH)/vendor/RakNet/SAMP \
                    $(LOCAL_PATH)/vendor/imgui \
                    $(LOCAL_PATH)/vendor/hash \
                    $(LOCAL_PATH)/voice \
                    $(LOCAL_PATH)/net \
                    $(LOCAL_PATH)/util \
                    $(LOCAL_PATH)/cryptors \
                    $(LOCAL_PATH)/game \
                    $(LOCAL_PATH)/game/GTASA/Core \
                    $(LOCAL_PATH)/game/GTASA/Models \
                    $(LOCAL_PATH)/game/RW \
                    $(LOCAL_PATH)/gtare \
                    $(LOCAL_PATH)/clientlogic \
                    $(LOCAL_PATH)/gui \
                    $(LOCAL_PATH)/santrope-tea-gtasa/encryption # Это путь относительно jni/

# Source files for the sampvoice module
# List all .cpp and .c files here.
# *** ИСПРАВЛЕНО: Убран лишний 'jni/' из всех путей ***
LOCAL_SRC_FILES := \
    $(wildcard $(LOCAL_PATH)/*.cpp) \
    $(wildcard $(LOCAL_PATH)/game/*.cpp) \
    $(wildcard $(LOCAL_PATH)/gtare/*.cpp) \
    $(wildcard $(LOCAL_PATH)/clientlogic/*.cpp) \
    $(wildcard $(LOCAL_PATH)/net/*.cpp) \
    $(wildcard $(LOCAL_PATH)/util/*.cpp) \
    $(wildcard $(LOCAL_PATH)/game/RW/RenderWare.cpp) \
    $(wildcard $(LOCAL_PATH)/gui/*.cpp) \
    $(wildcard $(LOCAL_PATH)/voice/*.cpp) \
    $(wildcard $(LOCAL_PATH)/cryptors/*.cpp) \
    $(wildcard $(LOCAL_PATH)/game/GTASA/Models/*.cpp) \
    $(wildcard $(LOCAL_PATH)/game/GTASA/Core/*.cpp) \
    $(wildcard $(LOCAL_PATH)/santrope-tea-gtasa/encryption/*.cpp) \
    $(wildcard $(LOCAL_PATH)/santrope-tea-gtasa/encryption/*.c) \
    $(wildcard $(LOCAL_PATH)/vendor/ini/*.cpp) \
    $(wildcard $(LOCAL_PATH)/vendor/RakNet/*.cpp) \
    $(wildcard $(LOCAL_PATH)/vendor/RakNet/SAMP/*.cpp) \
    $(wildcard $(LOCAL_PATH)/vendor/imgui/*.cpp) \
    $(wildcard $(LOCAL_PATH)/vendor/hash/md5.cpp)

# Link against the prebuilt static libraries defined above
LOCAL_STATIC_LIBRARIES := openal opus enet

# Compiler flags
LOCAL_CPPFLAGS := -w -s -fvisibility=hidden -pthread -Wall -fpack-struct=1 -O2 -std=c++14 -fexceptions
# LOCAL_CFLAGS := -Wno-error # Uncomment if you need to downgrade compile errors to warnings (use with caution)

# Build the shared library (your .so file)
include $(BUILD_SHARED_LIBRARY)
