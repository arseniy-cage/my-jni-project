LOCAL_PATH := $(call my-dir)

# Prebuilt static libraries
# Define and include each prebuilt static library separately.

include $(CLEAR_VARS)
LOCAL_MODULE := openal
LOCAL_SRC_FILES := vendor/openal/libopenal.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := opus
LOCAL_SRC_FILES := vendor/opus/libopus.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := enet
LOCAL_SRC_FILES := vendor/enet/libenet.a
include $(PREBUILT_STATIC_LIBRARY)


# Main project module: sampvoice
include $(CLEAR_VARS)

LOCAL_MODULE := sampvoice
# System libraries to link against
LOCAL_LDLIBS := -llog -lOpenSLES -lGLESv2 -lEGL

# Include directories for headers
# Ensure all directories containing header files (.h) are listed here.
LOCAL_C_INCLUDES := $(LOCAL_PATH)/vendor/ini \
                    $(LOCAL_PATH)/vendor/raknet \
                    $(LOCAL_PATH)/vendor/raknet/SAMP \
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
                    $(LOCAL_PATH)/santrope-tea-gtasa/encryption

# Source files for the sampvoice module
# List all .cpp and .c files here.
LOCAL_SRC_FILES := \
    $(wildcard $(LOCAL_PATH)/*.cpp) \
    $(wildcard $(LOCAL_PATH)/game/*.cpp) \
    $(wildcard $(LOCAL_PATH)/gtare/*.cpp) \
    $(wildcard $(LOCAL_PATH)/clientlogic/*.cpp) \
    $(wildcard $(LOCAL_PATH)/net/*.cpp) \
    $(wildcard $(LOCAL_PATH)/util/*.cpp) \
    $(LOCAL_PATH)/game/RW/RenderWare.cpp \
    $(wildcard $(LOCAL_PATH)/gui/*.cpp) \
    $(wildcard $(LOCAL_PATH)/voice/*.cpp) \
    $(wildcard $(LOCAL_PATH)/cryptors/*.cpp) \
    $(wildcard $(LOCAL_PATH)/game/GTASA/Models/*.cpp) \
    $(wildcard $(LOCAL_PATH)/game/GTASA/Core/*.cpp) \
    $(LOCAL_PATH)/vendor/ini/*.cpp \
    $(LOCAL_PATH)/vendor/imgui/*.cpp \
    $(LOCAL_PATH)/vendor/hash/md5.cpp \
    \
    # Явно перечисленные файлы шифрования из santrope-tea-gtasa/encryption
    # Убедитесь, что здесь используются ТАБУЛЯЦИИ, а не пробелы
	$(LOCAL_PATH)/santrope-tea-gtasa/encryption/aes.c \
	$(LOCAL_PATH)/santrope-tea-gtasa/encryption/CTEA.cpp \
	$(LOCAL_PATH)/santrope-tea-gtasa/encryption/CTinyEncrypt.cpp \
	$(LOCAL_PATH)/santrope-tea-gtasa/encryption/CXTEA3.cpp \
    # Добавьте сюда b64.cpp, если он существует:
    #	$(LOCAL_PATH)/santrope-tea-gtasa/encryption/b64.cpp \
    # Добавьте сюда encrypt.cpp, если он существует (хотя имя файла 'encrypt' очень общее):
    #	$(LOCAL_PATH)/santrope-tea-gtasa/encryption/encrypt.cpp \
    \
    # Явно перечисленные файлы RakNet из vendor/raknet/
    # Убедитесь, что здесь используются ТАБУЛЯЦИИ, а не пробелы
	$(LOCAL_PATH)/vendor/raknet/AutoRPC.cpp \
	$(LOCAL_PATH)/vendor/raknet/BitStream.cpp \
	$(LOCAL_PATH)/vendor/raknet/CommandParserInterface.cpp \
	$(LOCAL_PATH)/vendor/raknet/DR_SHA1.cpp \
	$(LOCAL_PATH)/vendor/raknet/FileListTransfer.cpp \
	$(LOCAL_PATH)/vendor/raknet/GetTime.cpp \
	$(LOCAL_PATH)/vendor/raknet/Gets.cpp \
	$(LOCAL_PATH)/vendor/raknet/HTTPConnection2.cpp \
	$(LOCAL_PATH)/vendor/raknet/InternalPacket.cpp \
	$(LOCAL_PATH)/vendor/raknet/Itoa.cpp \
	$(LOCAL_PATH)/vendor/raknet/PacketLogger.cpp \
	$(LOCAL_PATH)/vendor/raknet/RakClient.cpp \
	$(LOCAL_PATH)/vendor/raknet/RakNetworkFactory.cpp \
	$(LOCAL_PATH)/vendor/raknet/RakPeer.cpp \
	$(LOCAL_PATH)/vendor/raknet/RakSleep.cpp \
	$(LOCAL_PATH)/vendor/raknet/RakString.cpp \
	$(LOCAL_PATH)/vendor/raknet/Rand.cpp \
	$(LOCAL_PATH)/vendor/raknet/ReliabilityLayer.cpp \
	$(LOCAL_PATH)/vendor/raknet/SHA1.cpp \
	$(LOCAL_PATH)/vendor/raknet/SimpleMutex.cpp \
	$(LOCAL_PATH)/vendor/raknet/SocketLayer.cpp \
	$(LOCAL_PATH)/vendor/raknet/StringCompressor.cpp \
	$(LOCAL_PATH)/vendor/raknet/StringTable.cpp \
	$(LOCAL_PATH)/vendor/raknet/SystemAddressList.cpp \
	$(LOCAL_PATH)/vendor/raknet/SystemDatabaseClient.cpp \
	$(LOCAL_PATH)/vendor/raknet/SystemDatabaseServer.cpp \
	$(LOCAL_PATH)/vendor/raknet/TCPInterface.cpp \
	$(LOCAL_PATH)/vendor/raknet/TableSerializer.cpp \
	$(LOCAL_PATH)/vendor/raknet/TelnetTransport.cpp \
	$(LOCAL_PATH)/vendor/raknet/_findfirst.cpp \
	$(LOCAL_PATH)/vendor/raknet/rakserver.cpp \
	$(LOCAL_PATH)/vendor/raknet/rijndael.cpp \
    \
    # Явно перечисленные файлы RakNet из vendor/raknet/SAMP/
    # Убедитесь, что здесь используются ТАБУЛЯЦИИ, а не пробелы
	$(LOCAL_PATH)/vendor/raknet/SAMP/SAMPRPC.cpp \
	$(LOCAL_PATH)/vendor/raknet/SAMP/samp_auth.cpp \
	$(LOCAL_PATH)/vendor/raknet/SAMP/samp_netencr.cpp

# Link against the prebuilt static libraries defined above
LOCAL_STATIC_LIBRARIES := openal opus enet

# Compiler flags
LOCAL_CPPFLAGS := -w -s -fvisibility=hidden -pthread -Wall -fpack-struct=1 -O2 -std=c++14 -fexceptions
# LOCAL_CFLAGS := -Wno-error # Uncomment if you need to downgrade compile errors to warnings (use with caution)

# Build the shared library (your .so file)
include $(BUILD_SHARED_LIBRARY)
