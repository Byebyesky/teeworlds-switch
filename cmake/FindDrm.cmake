if (NOT SWITCH)
    cmake_panic("This helper can only be used if you are using the Switch toolchain file.")
endif ()

set(DRM_PATHS $ENV{DRM} drm ${DRM} ${PORTLIBS})

find_path(DRM_INCLUDE_DIR nouveau_drm.h
        PATHS ${DRM_PATHS}
        PATH_SUFFIXES include)

find_library(DRM_LIBRARY NAMES libdrm_nouveau.a
        PATHS DRM_PATHS
        PATH_SUFFIXES lib)

set(DRM_INCLUDE_DIRS ${DRM_INCLUDE_DIR})
set(DRM_LIBRARIES ${DRM_LIBRARY})

# Handle the QUIETLY and REQUIRED arguments and set DRM_FOUND to TRUE if all above variables are TRUE.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(DRM DEFAULT_MSG
        DRM_INCLUDE_DIR DRM_LIBRARY)

mark_as_advanced(DRM_INCLUDE_DIR DRM_LIBRARY)
if (DRM_FOUND)
    set(DRM ${DRM_INCLUDE_DIR}/..)
    cmake_info("Setting DRM to ${DRM}")

    add_library(switch::drm STATIC IMPORTED GLOBAL)
    set_target_properties(switch::drm PROPERTIES
            IMPORTED_LOCATION ${DRM_LIBRARY}
            INTERFACE_INCLUDE_DIRECTORIES ${DRM_INCLUDE_DIR})
endif ()