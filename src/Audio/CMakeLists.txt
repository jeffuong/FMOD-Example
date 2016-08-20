SET(PREPROCESSOR_DEF "")

####################BUILD TYPE####################
#Mutually exclusive only one can be set true
#Expect undefined results if multiple are true
SET(MAKE_EXECUTABLE TRUE)
SET(MAKE_STATIC_LIB FALSE)
SET(MAKE_SHARED_LIB FALSE)
####################BUILD TYPE####################

#######################DO NOT TOUCH##############################
#Get the folder name
GET_FILENAME_COMPONENT(ProjectName ${CMAKE_CURRENT_LIST_DIR} NAME)
#Replacing space with _ from the above directory
STRING(REPLACE " " "_" ProjectName ${ProjectName})
#######################DO NOT TOUCH##############################


#####################FINDING FILES AND FOLDER NAMES #########################

# Getting every file and putting it in the variable SRCS
FILE(GLOB_RECURSE SRCS RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" *.h *.hpp *.c *.cpp)

ADDFILTERS(${SRCS})

#####################FINDING FILES AND FOLDER NAMES #########################

##########Adding Preprocessor Defines##########
FOREACH(predef ${PREPROCESSOR_DEF})
  ADD_DEFINITIONS(-D"${predef}")
ENDFOREACH(predef)

##########Adding Preprocessor Defines##########

##########Setting Compiler Flags#########
IF(WIN32)
  IF(MINGW)
    SET(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} ${GCC_FLAGS_DEBUG}")
    SET(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} ${GCC_FLAGS_RELEASE}") 
  ELSEIF(MSVC)
    SET(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} ${MSVC_FLAGS_DEBUG}")
    SET(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} ${MSVC_FLAGS_RELEASE}")
  ENDIF(MINGW)
ELSEIF(UNIX)
  SET(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} ${UNIX_FLAGS_DEBUG}")
  SET(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_DEBUG} ${UNIX_FLAGS_RELEASE}")
ENDIF(WIN32)
##########Setting Compiler Flags#########


#################################DONT TOUCH####################################
############################ExternalDependencies###############################

INCLUDE_DIRECTORIES("${EX_DEPEND}/${ProjectName}/include")
IF(EX_PLATFORM EQUAL 64)
  IF(MINGW)
    LINK_DIRECTORIES("${EX_DEPEND}/${ProjectName}/lib/mingw/64/Deb") 
    LINK_DIRECTORIES("${EX_DEPEND}/${ProjectName}/lib/mingw/64/Rel")    
  ELSEIF(MSVC)
    LINK_DIRECTORIES("${EX_DEPEND}/${ProjectName}/lib/msvc/64/Deb") 
    LINK_DIRECTORIES("${EX_DEPEND}/${ProjectName}/lib/msvc/64/Rel")
  ENDIF(MINGW)
ELSEIF(EX_PLATFORM STREQUAL 32)
  IF(MINGW)
    LINK_DIRECTORIES("${EX_DEPEND}/${ProjectName}/lib/mingw/32/Deb") 
    LINK_DIRECTORIES("${EX_DEPEND}/${ProjectName}/lib/mingw/32/Rel")        
  ELSEIF(MSVC)
    LINK_DIRECTORIES("${EX_DEPEND}/${ProjectName}/lib/msvc/32/Deb") 
    LINK_DIRECTORIES("${EX_DEPEND}/${ProjectName}/lib/msvc/32/Rel")    
  ENDIF(MINGW)
ENDIF(EX_PLATFORM EQUAL 64)
############################ExternalDependencies###############################
#################################DONT TOUCH####################################

INCLUDE_DIRECTORIES(${FMOD_INCLUDE_DIR})

IF(MAKE_EXECUTABLE STREQUAL TRUE)
  #Make the folder name the same name as the solution
  ADD_EXECUTABLE(${ProjectName} ${SRCS})
ELSEIF(MAKE_STATIC_LIB STREQUAL TRUE)
 ADD_LIBRARY(${ProjectName} STATIC ${SRCS})
ELSEIF(MAKE_SHARED_LIB STREQUAL TRUE)
  ADD_LIBRARY(${ProjectName} SHARED ${SRCS})
ENDIF(MAKE_EXECUTABLE STREQUAL TRUE)

TARGET_LINK_LIBRARIES(${ProjectName} ${FMOD_LIBRARY})

#Putting this executable project in a folder
#SET_TARGET_PROPERTIES (${ProjectName} PROPERTIES
#    FOLDER Libraries/Static)

#######################FINDING LIBS CUSTOM###################################
#######################FINDING LIBS CUSTOM###################################

#######################FINDING LIBS CUSTOM###################################
#######################FINDING LIBS CUSTOM###################################
IF(MSVC)
  SET_TARGET_PROPERTIES(${ProjectName} PROPERTIES LINK_FLAGS_DEBUG "/SUBSYSTEM:CONSOLE")
  SET_TARGET_PROPERTIES(${ProjectName} PROPERTIES LINK_FLAGS_RELEASE "/SUBSYSTEM:WINDOWS")
ENDIF(MSVC)
#################################DONT TOUCH######################################
#########################CHECKING DEBUG AND RELEASE LIBS#########################

IF(EX_PLATFORM EQUAL 64)
  IF(WIN32)
    IF(MINGW)
      FINDLIBS("${EX_DEPEND}/${ProjectName}/lib/mingw/64/Deb" "${EX_DEPEND}/${ProjectName}/lib/mingw/64/Rel")      
    ELSEIF(MSVC)
      FINDLIBS("${EX_DEPEND}/${ProjectName}/lib/msvc/64/Deb" "${EX_DEPEND}/${ProjectName}/lib/msvc/64/Rel")  
    ENDIF(MINGW)
  ENDIF(WIN32)
  
ELSEIF(EX_PLATFORM EQUAL 32)
  IF(MINGW)
    FINDLIBS("${EX_DEPEND}/${ProjectName}/lib/mingw/32/Deb" "${EX_DEPEND}/${ProjectName}/lib/mingw/32/Rel") 
  ELSEIF(MSVC)
    FINDLIBS("${EX_DEPEND}/${ProjectName}/lib/msvc/32/Deb" "${EX_DEPEND}/${ProjectName}/lib/msvc/32/Rel")
  ENDIF(MINGW)
ENDIF(EX_PLATFORM EQUAL 64)

#########################CHECKING DEBUG AND RELEASE LIBS#########################
#################################DONT TOUCH######################################

#DLLTOBIN("${EX_DEPEND}/lib/msvc14/SDL2-2.0.4/lib/SDL2.dll" "${EX_DEPEND}/lib/msvc14/SDL2-2.0.4/lib/SDL2.dll")