set(WAVPACK_SRC_DIR src/engine/external/wavpack)
set_src(WAVPACK_SRC GLOB ${WAVPACK_SRC_DIR}
  bits.c
  float.c
  metadata.c
  unpack.c
  wavpack.h
  words.c
  wputils.c
)
add_library(wavpack EXCLUDE_FROM_ALL OBJECT ${WAVPACK_SRC})
set(WAVPACK_DEP $<TARGET_OBJECTS:wavpack>)
set(WAVPACK_INCLUDEDIR ${WAVPACK_SRC_DIR})
set(WAVPACK_INCLUDE_DIRS ${WAVPACK_INCLUDEDIR})

list(APPEND TARGETS_DEP wavpack)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Wavpack DEFAULT_MSG WAVPACK_INCLUDEDIR)
set(WAVPACK_BUNDLED ON)