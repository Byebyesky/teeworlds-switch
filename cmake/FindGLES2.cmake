if (NOT SWITCH)
    cmake_panic("This helper can only be used if you are using the Switch toolchain file.")
endif ()

set(GLES2_PATHS $ENV{GLES2} GL ${GLES2} ${PORTLIBS})

find_path(GLES2_INCLUDE_DIR gl2.h
        PATHS ${GLES2_PATHS}
        PATH_SUFFIXES include/GLES2)

find_library(GLES2_LIBRARY NAMES libGLESv2.a
        PATHS ${GLES2_PATHS}
        PATH_SUFFIXES lib)

set(GLES2_INCLUDE_DIRS ${GLES2_INCLUDE_DIR})
set(GLES2_LIBRARIES ${GLES2_LIBRARY})

# Handle the QUIETLY and REQUIRED arguments and set GLES2_FOUND to TRUE if all above variables are TRUE.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GLES2 DEFAULT_MSG
        GLES2_INCLUDE_DIR GLES2_LIBRARY)

mark_as_advanced(GLES2_INCLUDE_DIR GLES2_LIBRARY)
if (GLES2_FOUND)
    set(GLES2 ${GLES2_INCLUDE_DIR}/..)
    cmake_info("Setting GLES2 to ${GLES2}")

    add_library(switch::gles2 STATIC IMPORTED GLOBAL)
    set_target_properties(switch::gles2 PROPERTIES
            IMPORTED_LOCATION ${GLES2_LIBRARY}
            INTERFACE_INCLUDE_DIRECTORIES ${GLES2_INCLUDE_DIR})
endif ()