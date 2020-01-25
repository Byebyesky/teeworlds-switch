if (NOT SWITCH)
    cmake_panic("This helper can only be used if you are using the Switch toolchain file.")
endif ()

set(GLES_PATHS $ENV{GLES} GL ${GLES} ${PORTLIBS})

find_path(GLES_INCLUDE_DIR gl.h
        PATHS ${GLES_PATHS}
        PATH_SUFFIXES include/GLES)

find_library(GLES_LIBRARY NAMES libGLESv1_CM.a
        PATHS ${GLES_PATHS}
        PATH_SUFFIXES lib)

set(GLES_INCLUDE_DIRS ${GLES_INCLUDE_DIR})
set(GLES_LIBRARIES ${GLES_LIBRARY})

# Handle the QUIETLY and REQUIRED arguments and set GLES_FOUND to TRUE if all above variables are TRUE.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GLES DEFAULT_MSG
        GLES_INCLUDE_DIR GLES_LIBRARY)

mark_as_advanced(GLES_INCLUDE_DIR GLES_LIBRARY)
if (GLES_FOUND)
    set(GLES ${GLES_INCLUDE_DIR}/..)
    cmake_info("Setting GLES to ${GLES}")

    add_library(switch::gles STATIC IMPORTED GLOBAL)
    set_target_properties(switch::gles PROPERTIES
            IMPORTED_LOCATION ${GLES_LIBRARY}
            INTERFACE_INCLUDE_DIRECTORIES ${GLES_INCLUDE_DIR})
endif ()