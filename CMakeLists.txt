# Copyright 2019 SwitchPy Team. All rights reserved.
# Licensed under the MIT license.
# Refer to the LICENSE file included.
#
# libnx CMake template for Nintendo Switch homebrew development.


if(NOT SWITCH)
set(HOMEBREW_APP "teeworlds")
include(CMakeLists2.txt)
else()
cmake_minimum_required(VERSION 3.1)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(options)
include(utils)

find_package(LIBNX REQUIRED)
if (NOT LIBNX_FOUND)
    cmake_panic("Unable to detect libnx on this system.")
endif ()

# === The following 3 libs are required for cURL ===
# === Add ${CURL_LIBRARIES} ${MBEDTLS_LIBRARIES} ${ZLIB_LIBRARIES} to target_link_libraries() before switch::libnx ===

# find_package(CURL REQUIRED)
# if (NOT CURL_FOUND)
#     cmake_panic("Unable to detect libcurl on this system.")
# endif ()
# find_package(ZLIB REQUIRED)
# if (NOT ZLIB_FOUND)
#     cmake_panic("Unable to detect zlib on this system.")
# endif ()
# find_package(MbedTLS REQUIRED)
# if (NOT MbedTLS_FOUND)
#     cmake_panic("Unable to detect mbedtls on this system.")
# endif ()

# === Add switch::libtwili to target_link_libraries() to link with libtwili ===

# find_package(LIBTWILI REQUIRED)
# if (NOT LIBTWILI_FOUND)
#     cmake_panic("Unable to detect libtwili on this system.")
# endif ()

include_directories(${PROJECT_BINARY_DIR} ${DEVKITPRO}/libnx/include ${PORTLIBS}/include)
link_directories(${PORTLIBS}/lib)

# Replace this with the name of your application
set(HOMEBREW_APP "teeworlds")

# Meta information about the app
set(APP_TITLE ${HOMEBREW_APP})
set(APP_AUTHOR "Flyingsky")
set(APP_ICON "../assets/teeworlds.jpg")


if (NOT DEFINED CMAKE_BUILD_TYPE_INIT)
    set(CMAKE_BUILD_TYPE_INIT Release)
endif ()

set(CMAKE_C_STANDARD 99)
if (USE_CPP_17)
    set(CMAKE_CXX_STANDARD 17)
else ()
    set(CMAKE_CXX_STANDARD 11)
endif ()

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    include(clang-utils)
endif ()

include(nx-utils)

cmake_info("Building ${APP_TITLE} version ${APP_VERSION}.")

include(CMakeLists2.txt)

set(APP_VERSION
        "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}")

find_package(Bz2)
target_link_libraries(${HOMEBREW_APP}.elf switch::bz2)

find_package(PNG)
target_link_libraries(${HOMEBREW_APP}.elf switch::png)

find_package(EGL)
target_link_libraries(${HOMEBREW_APP}.elf switch::egl)

find_package(GLES)
target_link_libraries(${HOMEBREW_APP}.elf switch::gles)

target_link_libraries(${HOMEBREW_APP}.elf switch::opengl)

find_package(Drm)
target_link_libraries(${HOMEBREW_APP}.elf switch::drm)

target_link_libraries(${HOMEBREW_APP}.elf switch::libnx)
set_target_properties(${HOMEBREW_APP}.elf PROPERTIES
        LINKER_LANGUAGE CXX # Replace this with C if you have C source files
        LINK_FLAGS "-specs=${LIBNX}/switch.specs -Wl,-no-as-needed -Wl,-Map,.map")

build_switch_binaries(${HOMEBREW_APP}.elf)
#build_switch_sysmodule(${HOMEBREW_APP}.elf)  # build .kip
#build_switch_nsp(${HOMEBREW_APP}.elf)  # build .nsp
endif()