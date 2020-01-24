if (NOT SWITCH)
    cmake_panic("This helper can only be used if you are using the Switch toolchain file.")
endif ()

set(OPENGL_PATHS $ENV{OPENGL} GL ${OPENGL} ${PORTLIBS})

find_path(OPENGL_INCLUDE_DIR gl.h
        PATHS ${OPENGL_PATHS}
        PATH_SUFFIXES include/GL)

find_library(OPENGL_LIBRARY NAMES libglapi.a
        PATHS ${OPENGL_PATHS}
        PATH_SUFFIXES lib)

set(OPENGL_INCLUDE_DIRS ${OPENGL_INCLUDE_DIR})
set(OPENGL_LIBRARIES ${OPENGL_LIBRARY})

# Handle the QUIETLY and REQUIRED arguments and set OPENGL_FOUND to TRUE if all above variables are TRUE.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OPENGL DEFAULT_MSG
        OPENGL_INCLUDE_DIR OPENGL_LIBRARY)

mark_as_advanced(OPENGL_INCLUDE_DIR OPENGL_LIBRARY)
if (OPENGL_FOUND)
    set(OPENGL ${OPENGL_INCLUDE_DIR}/..)
    cmake_info("Setting OPENGL to ${OPENGL}")

    add_library(switch::opengl STATIC IMPORTED GLOBAL)
    set_target_properties(switch::opengl PROPERTIES
            IMPORTED_LOCATION ${OPENGL_LIBRARY}
            INTERFACE_INCLUDE_DIRECTORIES ${OPENGL_INCLUDE_DIR})
endif ()