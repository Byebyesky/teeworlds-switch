if (NOT SWITCH)
    cmake_panic("This helper can only be used if you are using the Switch toolchain file.")
endif ()

set(FREETYPE_PATHS $ENV{FREETYPE} freetype2 freetype ${FREETYPE} ${PORTLIBS})

find_path(FREETYPE_INCLUDE_DIR ft2build.h
        PATHS ${FREETYPE_PATHS}
        PATH_SUFFIXES include/freetype2)

find_library(FREETYPE_LIBRARY NAMES libfreetype.a
        PATHS FREETYPE_PATHS
        PATH_SUFFIXES lib)

set(FREETYPE_INCLUDE_DIRS ${FREETYPE_INCLUDE_DIR})
set(FREETYPE_LIBRARIES ${FREETYPE_LIBRARY})

# Handle the QUIETLY and REQUIRED arguments and set FREETYPE_FOUND to TRUE if all above variables are TRUE.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(FREETYPE DEFAULT_MSG
        FREETYPE_INCLUDE_DIR FREETYPE_LIBRARY)

mark_as_advanced(FREETYPE_INCLUDE_DIR FREETYPE_LIBRARY)
if (FREETYPE_FOUND)
    set(FREETYPE ${FREETYPE_INCLUDE_DIR}/..)
    cmake_info("Setting FREETYPE to ${FREETYPE}")

    add_library(switch::freetype STATIC IMPORTED GLOBAL)
    set_target_properties(switch::freetype PROPERTIES
            IMPORTED_LOCATION ${FREETYPE_LIBRARY}
            INTERFACE_INCLUDE_DIRECTORIES ${FREETYPE_INCLUDE_DIR})
endif ()