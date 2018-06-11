:: SET VS90COMNTOOLS=%VS140COMNTOOLS%

mkdir build
cd build
cmake.exe -G"Visual Studio 14 2015" .. -DBUILD_PYTHON_WRAPPER=ON
if errorlevel 1 exit 1
MSBuild.exe ALL_BUILD.vcxproj /property:Configuration=Release
if errorlevel 1 exit 1

:: Add more build steps here, if they are necessary.

:: See
:: http://docs.continuum.io/conda/build.html
:: for a list of environment variables that are set during the build process.
