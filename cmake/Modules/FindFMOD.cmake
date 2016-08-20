# - Find FMOD
#
#  FMOD_FOUND - Set to True if Wwise is found
#  FMOD_INCLUDE_DIRS - the Wwise include directories
#  FMOD_LIBRARY - All of the Wwise Libs for release and debug

SET(FIND_FMOD_PATHS
    ${FMOD_ROOT}
    /Library/Frameworks
    /usr/local
    /usr
    /sw
    /opt/local
    /opt/csw
    /opt)
    
SET(libdirs "${FMOD_ROOT}/lib")

FILE(GLOB WINLIBS RELATIVE "${libdirs}/" "${libdirs}/*.lib")

FIND_PATH(
	FMOD_INCLUDE_DIRS
  NAMES fmod_studio.hpp
  PATH_SUFFIXES include
  PATHS ${FIND_FMOD_PATHS})
  
FIND_LIBRARY(
    FMOD_LIBRARY
    NAMES fmodstudio64_vc
    PATHS ${FIND_FMOD_PATHS}
    PATH_SUFFIXES lib
  )
  
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(FMOD DEFAULT_MSG FMOD_LIBRARY FMOD_INCLUDE_DIRS)