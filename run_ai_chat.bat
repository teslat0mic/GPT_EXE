@echo off
SET SCRIPT_DIR=%~dp0
SET PYTHON_SETUP=%SCRIPT_DIR%portable_python\python_setup.bat
SET AI_CHAT_PY=%SCRIPT_DIR%AI_Chat.py

IF NOT EXIST "%PYTHON_SETUP%" (
    echo Error: python_setup.bat not found at %PYTHON_SETUP%
    pause
    exit /b 1
)

IF NOT EXIST "%AI_CHAT_PY%" (
    echo Error: AI_Chat.py not found at %AI_CHAT_PY%
    pause
    exit /b 1
)

call "%PYTHON_SETUP%"

SET STREAMLIT_SERVER_PORT=8501
SET STREAMLIT_SERVER_HEADLESS=true

IF NOT DEFINED PYTHON (
    echo Error: PYTHON environment variable not set by python_setup.bat
    pause
    exit /b 1
)

IF NOT EXIST "%PYTHON%" (
    echo Error: Python executable not found at %PYTHON%
    pause
    exit /b 1
)

start "" http://localhost:8501

echo Running: "%PYTHON%" -m streamlit run "%AI_CHAT_PY%"
"%PYTHON%" -m streamlit run "%AI_CHAT_PY%"

if %ERRORLEVEL% NEQ 0 (
    echo An error occurred while running the Streamlit app.
    echo Please check if all dependencies are correctly installed.
    pause
)

pause