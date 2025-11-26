@echo off
title FiveM Datei-Check
color 0A

set "FIVEM_PATH=%localappdata%\FiveM"
echo ---------------------------------------------------
echo   FiveM Anti-Cheat Scanner (lokaler Datei-Check)
echo ---------------------------------------------------
echo.
echo FiveM Ordner: %FIVEM_PATH%
echo.

if not exist "%FIVEM_PATH%" (
    echo Fehler: FiveM Ordner wurde nicht gefunden!
    pause
    exit /b
)

echo Scanne nach bekannten Cheat-Dateien ...
echo.

set "LOGFILE=%~dp0scan_log.txt"
echo Scan gestartet am %date% %time% > "%LOGFILE%"
echo ------------------------------ >> "%LOGFILE%"

rem Liste häufig verdächtiger Dateien
set suspiciousExt=*.lua *.asi *.dll *.exe *.ct
set suspiciousNames=modmenu* cheat* injector* hack* exploit* menu*

echo ---- Gefundene verdächtige Dateien ----
echo (Ergebnisse werden auch in scan_log.txt gespeichert)
echo.

rem Nach verdächtigen Dateiendungen suchen
for %%x in (%suspiciousExt%) do (
    for /r "%FIVEM_PATH%" %%i in (%%x) do (
        echo [EXT] %%i
        echo [EXT] %%i >> "%LOGFILE%"
    )
)

rem Nach verdächtigen Dateinamen suchen
for %%y in (%suspiciousNames%) do (
    for /r "%FIVEM_PATH%" %%j in (%%y.*) do (
        echo [NAME] %%j
        echo [NAME] %%j >> "%LOGFILE%"
    )
)

echo.
echo Scan abgeschlossen!
echo Ergebnisse gespeichert in: "%LOGFILE%"
echo.
pause
