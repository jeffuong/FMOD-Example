#Finding all the folders in a directory
MACRO(SUBDIRLIST result curdir)
  FILE(GLOB children RELATIVE ${curdir} ${curdir}/*)
  SET(dirlist "") #setting this as a empty string
  FOREACH(child ${children})
    IF(IS_DIRECTORY ${curdir}/${child})
        LIST(APPEND dirlist ${child})
    ENDIF(IS_DIRECTORY ${curdir}/${child})
  ENDFOREACH()
  SET(${result} ${dirlist})
ENDMACRO(SUBDIRLIST)

MACRO(ADDFILTERS)
  FOREACH(items IN ITEMS ${ARGN})
    GET_FILENAME_COMPONENT(filePath "${items}" PATH)
    STRING(REPLACE "/" "\\" pathOf "${filePath}")
    SOURCE_GROUP("${pathOf}" FILES "${items}")
  ENDFOREACH(items IN ITEMS ${ARGN})
ENDMACRO(ADDFILTERS)

MACRO(ADDSHADERFILTER)
  FOREACH(items IN ITEMS ${ARGN})
    GET_FILENAME_COMPONENT(filePath "${items}" PATH)
    STRING(REPLACE "/" "\\" pathOf "${filePath}")
    SOURCE_GROUP("Shaders\\" FILES "${items}")
  ENDFOREACH(items IN ITEMS ${ARGN})
ENDMACRO(ADDSHADERFILTER)

MACRO(DLLTOBIN debug release)
  ADD_CUSTOM_COMMAND(TARGET ${ProjectName} POST_BUILD  # Adds a post-build event to MyTest
  COMMAND ${CMAKE_COMMAND} -E copy_if_different        # which executes "cmake - E copy_if_different..."
  ${debug}                                         # <--this is in-file
  ${CMAKE_BINARY_DIR}/bin64/Debug)  # <--this is out-file path
  
  ADD_CUSTOM_COMMAND(TARGET ${ProjectName} POST_BUILD  # Adds a post-build event to MyTest
  COMMAND ${CMAKE_COMMAND} -E copy_if_different        # which executes "cmake - E copy_if_different..."
  ${release}                                         # <--this is in-file
  ${CMAKE_BINARY_DIR}/bin64/Release)  # <--this is out-file path
ENDMACRO(DLLTOBIN)

MACRO(FINDLIBS debug release)
  SET(deblinuxlibs "${debug}/*.a")
  SET(debwindowlibs "${debug}/*.lib")
  SET(rellinuxlibs "${release}/*.a")
  SET(relwindowlibs "${release}/*.lib")
  
  FILE(GLOB DLIBS "${deblinuxlibs}" "${debwindowlibs}")
  FOREACH(DLIBS ${DLIBS})
    GET_FILENAME_COMPONENT(DLIB "${DLIBS}" NAME)
    #Properties->Linker->Input->Additional Dependencies
    TARGET_LINK_LIBRARIES(${ProjectName} debug ${DLIB})
  ENDFOREACH(DLIBS)    

  FILE(GLOB RLIBS "${rellinuxlibs}" "${relwindowlibs}")
  FOREACH(RLIBS ${RLIBS})
    GET_FILENAME_COMPONENT(RLIB "${RLIBS}" NAME)
    #Properties->Linker->Input->Additional Dependencies
    TARGET_LINK_LIBRARIES(${ProjectName} optimized ${RLIB})
  ENDFOREACH(RLIBS) 
ENDMACRO(FINDLIBS)