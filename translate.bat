@echo off
SET ERRORLEVEL=0

SET IFILE=%~dp0source\python\c.dpp
SET OFILE=%~dp0source\python\c.d

FOR %%i IN (%IFILE%) DO SET IDATE=%%~ti
FOR %%i IN (%OFILE%) DO SET ODATE=%%~ti
IF "%IDATE%"=="%ODATE%" GOTO END

FOR /F %%i IN ('DIR /S /B /O:D %IFILE% %OFILE%') DO SET NEWEST=%%i
IF "%NEWEST%"=="%OFILE%" GOTO END

for /f "delims=" %%i in ('python %~dp0include.py') do set PYTHON_INCLUDE_PATH=%%i
IF %ERRORLEVEL% NEQ 0 (
    echo "Could not run Python to get include path"
    exit /b 1
)

dub run dpp@0.5.1 --build=release -- --ignore-cursor=stat64 --ignore-cursor=PyType_HasFeature --ignore-cursor=_Py_IS_TYPE  --ignore-cursor=_PyObject_TypeCheck --ignore-cursor=COMPILER --ignore-cursor=_PyCode_DEF --ignore-cursor=Py_IS_TYPE --function-macros --preprocess-only --include-path "%PYTHON_INCLUDE_PATH%" "%IFILE%"

:END
