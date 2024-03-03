cd %~dp0
powershell.exe -ExecutionPolicy Bypass -Command ".\UWSCWrapper.ps1 %1; exit $LASTEXITCODE"
