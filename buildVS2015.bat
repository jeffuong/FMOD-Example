cls
mkdir buildMSVC
cd buildMSVC
cmake -G"Visual Studio 14 2015 Win64" ../src -DCMAKE_BUILD_TYPE="Debug;Release;RelWithDebInfo" 2>> ../cmakeError.log