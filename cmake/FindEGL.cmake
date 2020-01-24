if (NOT SWITCH)
    cmake_panic("This helper can only be used if you are using the Switch toolchain file.")
endif ()

set(EGL_PATHS $ENV{EGL} egl ${EGL} ${PORTLIBS})

find_path(EGL_INCLUDE_DIR egl.h
        PATHS ${EGL_PATHS}
        PATH_SUFFIXES include/EGL)

find_library(EGL_LIBRARY NAMES libEGL.a
        PATHS EGL_PATHS
        PATH_SUFFIXES lib)

set(EGL_INCLUDE_DIRS ${EGL_INCLUDE_DIR})
set(EGL_LIBRARIES ${EGL_LIBRARY})

# Handle the QUIETLY and REQUIRED arguments and set EGL_FOUND to TRUE if all above variables are TRUE.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(EGL DEFAULT_MSG
        EGL_INCLUDE_DIR EGL_LIBRARY)

mark_as_advanced(EGL_INCLUDE_DIR EGL_LIBRARY)
if (EGL_FOUND)
    set(EGL ${EGL_INCLUDE_DIR}/..)
    cmake_info("Setting EGL to ${EGL}")

    add_library(switch::egl STATIC IMPORTED GLOBAL)
    set_target_properties(switch::egl PROPERTIES
            IMPORTED_LOCATION ${EGL_LIBRARY}
            INTERFACE_INCLUDE_DIRECTORIES ${EGL_INCLUDE_DIR})
endif ()