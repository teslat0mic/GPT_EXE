; Installer script for AI Chat App

!include "MUI2.nsh"
!include "LogicLib.nsh"

; Define application name and file
!define APPNAME "AI Chat App"
!define EXECNAME "run_ai_chat.bat"
!define ICONFILE "app_icon.ico"  ; Add this line to define the icon file

Name "${APPNAME}"
OutFile "${APPNAME}Installer.exe"
InstallDir "$LOCALAPPDATA\${APPNAME}"

RequestExecutionLevel user

; Pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; Languages
!insertmacro MUI_LANGUAGE "English"

Section "Install"
  SetOutPath $INSTDIR
  
  ; Copy portable Python
  File /r "portable_python"
  
  ; Verify python_setup.bat is in portable_python folder
  ${If} ${FileExists} "$INSTDIR\portable_python\python_setup.bat"
    DetailPrint "python_setup.bat found in portable_python folder."
  ${Else}
    MessageBox MB_OK|MB_ICONSTOP "python_setup.bat not found in portable_python folder. Aborting installation."
    Abort
  ${EndIf}
  
  ; Copy application files to the main directory
  File "AI_Chat.py"
  File ".env"
  File "${EXECNAME}"
  File "get-pip.py"
  File "requirements.txt"
  File "${ICONFILE}"  ; Copy the icon file
  
  ; Create start menu shortcut with custom icon
  CreateDirectory "$SMPROGRAMS\${APPNAME}"
  CreateShortCut "$SMPROGRAMS\${APPNAME}\${APPNAME}.lnk" "$INSTDIR\${EXECNAME}" "" "$INSTDIR\${ICONFILE}" 0
  
  ; Create desktop shortcut with custom icon
  CreateShortCut "$DESKTOP\${APPNAME}.lnk" "$INSTDIR\${EXECNAME}" "" "$INSTDIR\${ICONFILE}" 0
  
  ; Write uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd

Section "Uninstall"
  ; Remove application files
  Delete "$INSTDIR\AI_Chat.py"
  Delete "$INSTDIR\.env"
  Delete "$INSTDIR\${EXECNAME}"
  Delete "$INSTDIR\Uninstall.exe"
  Delete "$INSTDIR\get-pip.py"
  Delete "$INSTDIR\requirements.txt"
  Delete "$INSTDIR\${ICONFILE}"  ; Remove the icon file
  
  ; Remove portable Python
  RMDir /r "$INSTDIR\portable_python"
  
  ; Remove shortcuts
  Delete "$SMPROGRAMS\${APPNAME}\${APPNAME}.lnk"
  Delete "$DESKTOP\${APPNAME}.lnk"
  
  ; Remove directories
  RMDir "$SMPROGRAMS\${APPNAME}"
  RMDir "$INSTDIR"
SectionEnd