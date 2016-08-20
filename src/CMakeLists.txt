CMAKE_MINIMUM_REQUIRED(VERSION 3.0.2)
#Specify build types
SET(CMAKE_CONFIGURATION_TYPES "Debug;Release;RelWithDebInfo" CACHE STRING "Configurations" FORCE)
#This is the project name
PROJECT(FMOD_Example)
#Finding all the folders in a directory

SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../cmake/Modules")
INCLUDE(macros)

SUBDIRLIST( SUBDIRS ${CMAKE_CURRENT_SOURCE_DIR})


# Turn on the ability to create folders to organize projects (.vcproj)
# It creates "CMakePredefinedTargets" folder by default and adds CMake
# defined projects like INSTALL.vcproj and ZERO_CHECK.vcproj
SET_PROPERTY(GLOBAL PROPERTY USE_FOLDERS ON)

SET(EX_DEPEND "${CMAKE_SOURCE_DIR}/../ExternalDependencies")

############OUTPUT FILES LOCATION##################################
#Where the files will be located after being being built
#ARCHIVE = STATIC, LIBRARY = Module libs, RUNTIME = EXE
SET(ARCHIVE_OUTPUT_DIRECTORY_DEBUG "${PROJECT_BINARY_DIR}/lib64")
SET(LIBRARY_OUTPUT_DIRECTORY_DEBUG "${PROJECT_BINARY_DIR}/lib64")
SET(RUNTIME_OUTPUT_DIRECTORY_DEBUG "${PROJECT_BINARY_DIR}/bin64")

SET(ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${PROJECT_BINARY_DIR}/lib64")
SET(LIBRARY_OUTPUT_DIRECTORY_RELEASE "${PROJECT_BINARY_DIR}/lib64")
SET(RUNTIME_OUTPUT_DIRECTORY_RELEASE "${PROJECT_BINARY_DIR}/bin64")
############OUTPUT FILES LOCATION##################################

#Checking to see if compiled in 32/64
IF( CMAKE_SIZEOF_VOID_P EQUAL 8 )
    MESSAGE( "64 bits compiler detected" )
    SET( EX_PLATFORM 64 )
    SET( EX_PLATFORM_NAME "x64" )
ELSE( CMAKE_SIZEOF_VOID_P EQUAL 8 ) 
    MESSAGE( "32 bits compiler detected" )
    SET( EX_PLATFORM 32 )
    SET( EX_PLATFORM_NAME "x86" )
ENDIF( CMAKE_SIZEOF_VOID_P EQUAL 8 )

IF( EX_PLATFORM EQUAL 64 )
  MESSAGE( "Outputting to lib64 and bin64" )
  IF(CMAKE_BUILD_TYPE MATCHES Debug)
  # ---------- Setup output Directories -------------------------
  SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${LIBRARY_OUTPUT_DIRECTORY_DEBUG} CACHE PATH
    "Single Directory for all Libraries")
  
  # --------- Setup the Executable output Directory -------------
  SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${RUNTIME_OUTPUT_DIRECTORY_DEBUG} CACHE PATH
    "Single Directory for all Executables.")
  
  # --------- Setup the Executable output Directory -------------
  SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${ARCHIVE_OUTPUT_DIRECTORY_DEBUG} CACHE PATH
    "Single Directory for all static libraries.") 
  ELSEIF(CMAKE_BUILD_TYPE MATCHES Release)
    # ---------- Setup output Directories -------------------------
  SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${LIBRARY_OUTPUT_DIRECTORY_RELEASE} CACHE PATH
    "Single Directory for all Libraries")
  
  # --------- Setup the Executable output Directory -------------
  SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${RUNTIME_OUTPUT_DIRECTORY_RELEASE} CACHE PATH
    "Single Directory for all Executables.")
  
  # --------- Setup the Executable output Directory -------------
  SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${ARCHIVE_OUTPUT_DIRECTORY_RELEASE} CACHE PATH
    "Single Directory for all static libraries.") 
  ENDIF(CMAKE_BUILD_TYPE MATCHES Debug) 
ELSE( EX_PLATFORM EQUAL 64 )
# ---------- Setup output Directories -------------------------
SET (CMAKE_LIBRARY_OUTPUT_DIRECTORY
   ${PROJECT_BINARY_DIR}/lib CACHE PATH
   "Single Directory for all Libraries")

# --------- Setup the Executable output Directory -------------
SET (CMAKE_RUNTIME_OUTPUT_DIRECTORY
   ${PROJECT_BINARY_DIR}/bin CACHE PATH
   "Single Directory for all Executables.")

# --------- Setup the Executable output Directory -------------
SET (CMAKE_ARCHIVE_OUTPUT_DIRECTORY
   ${PROJECT_BINARY_DIR}/lib CACHE PATH
   "Single Directory for all static libraries.")
ENDIF( EX_PLATFORM EQUAL 64 )

################FINDING LIBRARY PACKAGES###########################

IF(MSVC)
  SET(FMOD_ROOT "${EX_DEPEND}/lib/msvc14/FMOD-1.08.06")
ENDIF(MSVC)  

FIND_PACKAGE(FMOD)

################FINDING LIBRARY PACKAGES###########################


#######################GCC FLAGS###################################
SET(GCC_FLAGS_DEBUG   "-std=c++14 -Wextra -Wall -pedantic ")
SET(GCC_FLAGS_RELEASE "-std=c++14 -Wextra -Wall -pedantic ")
#######################GCC FLAGS###################################

#######################UNIX FLAGS##################################
SET(UNIX_FLAGS_DEBUG   "-std=c++14 -Wextra -Wall -pedantic")
SET(UNIX_FLAGS_RELEASE "-std=c++14 -Wextra -Wall -pedantic")
#######################UNIX FLAGS##################################

#######################MSVC FLAGS##################################
SET(MSVC_FLAGS_DEBUG "/W3 /MP")
SET(MSVC_FLAGS_RELEASE "/W3 /MP")
#######################MSVC FLAGS##################################


################GLOBAL INCLUDE DIR#################################
INCLUDE_DIRECTORIES("${EX_DEPEND}/Global_Include")
################GLOBAL INCLUDE DIR#################################

FOREACH(subdir ${SUBDIRS})
	IF(subdir STREQUAL ".idea")
	ELSE()
		ADD_SUBDIRECTORY(${subdir})
	ENDIF(subdir STREQUAL ".idea")
ENDFOREACH()