@echo off
SET SCRIPT_DIR=%~dp0
SET PORTABLE_PYTHON_HOME=%SCRIPT_DIR%
SET PATH=%PORTABLE_PYTHON_HOME%;%PORTABLE_PYTHON_HOME%\Scripts;%PATH%
SET PYTHONHOME=%PORTABLE_PYTHON_HOME%
SET PYTHONPATH=%PORTABLE_PYTHON_HOME%\Lib\site-packages;%PORTABLE_PYTHON_HOME%\Lib
SET PYTHON=%PORTABLE_PYTHON_HOME%\python.exe
SET PIP=%PORTABLE_PYTHON_HOME%\Scripts\pip.exe

REM Ensure python312._pth is configured correctly
echo import site >> "%PORTABLE_PYTHON_HOME%\python312._pth"

REM Install pip if not present
IF NOT EXIST "%PIP%" (
    "%PYTHON%" "%SCRIPT_DIR%..\get-pip.py" --no-warn-script-location
)

REM Install required packages
"%PIP%" install -r "%SCRIPT_DIR%..\requirements.txt"

REM Add the parent directory to PYTHONPATH
SET PYTHONPATH=%PYTHONPATH%;%SCRIPT_DIR%..
