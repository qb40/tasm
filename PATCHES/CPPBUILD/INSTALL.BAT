@echo off
if /%1==/ goto usage
if /%2==/ goto usage

copy patch.exe %1\%2\bin
copy td32.rtp %1\%2\bin
copy tasm32.rtp %1\%2\bin
%1
cd %2\bin
if not exist td32.exe goto tryTasm32
patch td32.rtp
:tryTasm32
if not exist tasm32.exe goto end
patch tasm32.rtp
goto cleanup

:usage
echo .
echo . usage: install c: \bc5
echo .
echo . This will patch your TD32.EXE and TASM32.EXE to support
echo . Borland C++ Builder applications.  The first parameter to the
echo . install.bat file should be the drive letter to which you
echo . installed your Borland C++ 5.0 software.  The second parameter
echo . should be the root directory for the installation.  The
echo . patch file assumes that your tools are installed in the bin
echo . directory below this.
echo .
goto end

:cleanup
del patch.exe
del td32.rtp
del tasm32.rtp

:end
