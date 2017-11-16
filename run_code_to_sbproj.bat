@echo off
set /p FILE_PATH="Path to SBIO code file: "
matlab.exe -nodisplay -nosplash -nodesktop -r "run('%FILE_PATH%');sbiosaveproject sbio_model model;exit;"
pause
cls
exit