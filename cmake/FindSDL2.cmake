if (NOT SWITCH)
    cmake_panic("This helper can only be used if you are using the Switch toolchain file.")
endif ()

set(SDL2_PATHS $ENV{SDL2} sdl2 ${SDL2} ${PORTLIBS})

find_path(SDL2_INCLUDE_DIR SDL.h
        PATHS ${SDL2_PATHS}
        PATH_SUFFIXES include/SDL2)

find_library(SDL2_LIBRARY NAMES libSDL2.a
        PATHS SDL2_PATHS
        PATH_SUFFIXES lib)

set(SDL2_INCLUDE_DIRS ${SDL2_INCLUDE_DIR})
set(SDL2_LIBRARIES ${SDL2_LIBRARY})

# Handle the QUIETLY and REQUIRED arguments and set SDL2_FOUND to TRUE if all above variables are TRUE.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SDL2 DEFAULT_MSG
        SDL2_INCLUDE_DIR SDL2_LIBRARY)

mark_as_advanced(SDL2_INCLUDE_DIR SDL2_LIBRARY)
if (SDL2_FOUND)
    set(SDL2 ${SDL2_INCLUDE_DIR}/..)
    cmake_info("Setting SDL2 to ${SDL2}")

    add_library(switch::sdl2 STATIC IMPORTED GLOBAL)
    set_target_properties(switch::sdl2 PROPERTIES
            IMPORTED_LOCATION ${SDL2_LIBRARY}
            INTERFACE_INCLUDE_DIRECTORIES ${SDL2_INCLUDE_DIR})
endif ()