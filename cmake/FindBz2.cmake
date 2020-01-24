if (NOT SWITCH)
    cmake_panic("This helper can only be used if you are using the Switch toolchain file.")
endif ()

set(BZ2_PATHS $ENV{BZ2} bz2 ${BZ2} ${PORTLIBS})

find_path(BZ2_INCLUDE_DIR bzlib.h
        PATHS ${BZ2_PATHS}
        PATH_SUFFIXES include)

find_library(BZ2_LIBRARY NAMES libbz2.a
        PATHS BZ2_PATHS
        PATH_SUFFIXES lib)

set(BZ2_INCLUDE_DIRS ${BZ2_INCLUDE_DIR})
set(BZ2_LIBRARIES ${BZ2_LIBRARY})

# Handle the QUIETLY and REQUIRED arguments and set BZ2_FOUND to TRUE if all above variables are TRUE.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(BZ2 DEFAULT_MSG
        BZ2_INCLUDE_DIR BZ2_LIBRARY)

mark_as_advanced(BZ2_INCLUDE_DIR BZ2_LIBRARY)
if (BZ2_FOUND)
    set(BZ2 ${BZ2_INCLUDE_DIR}/..)
    cmake_info("Setting BZ2 to ${BZ2}")

    add_library(switch::bz2 STATIC IMPORTED GLOBAL)
    set_target_properties(switch::bz2 PROPERTIES
            IMPORTED_LOCATION ${BZ2_LIBRARY}
            INTERFACE_INCLUDE_DIRECTORIES ${BZ2_INCLUDE_DIR})
endif ()