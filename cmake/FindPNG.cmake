if (NOT SWITCH)
    cmake_panic("This helper can only be used if you are using the Switch toolchain file.")
endif ()

set(PNG_PATHS $ENV{PNG} png ${PNG} ${PORTLIBS})

find_path(PNG_INCLUDE_DIR png.h
        PATHS ${PNG_PATHS}
        PATH_SUFFIXES include)

find_library(PNG_LIBRARY NAMES libpng.a
        PATHS PNG_PATHS
        PATH_SUFFIXES lib)

set(PNG_INCLUDE_DIRS ${PNG_INCLUDE_DIR})
set(PNG_LIBRARIES ${PNG_LIBRARY})

# Handle the QUIETLY and REQUIRED arguments and set PNG_FOUND to TRUE if all above variables are TRUE.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(PNG DEFAULT_MSG
        PNG_INCLUDE_DIR PNG_LIBRARY)

mark_as_advanced(PNG_INCLUDE_DIR PNG_LIBRARY)
if (PNG_FOUND)
    set(PNG ${PNG_INCLUDE_DIR}/..)
    cmake_info("Setting PNG to ${PNG}")

    add_library(switch::png STATIC IMPORTED GLOBAL)
    set_target_properties(switch::png PROPERTIES
            IMPORTED_LOCATION ${PNG_LIBRARY}
            INTERFACE_INCLUDE_DIRECTORIES ${PNG_INCLUDE_DIR})
endif ()