@echo off
mode con cols=90 lines=30
title FiveM Terminal Scanner
color 0A

:: Pfad definieren
set "FIVEM_PATH=%localappdata%\FiveM"
set "LOGFILE=%~dp0terminal_scan_log.txt"

:MENU
cls
echo ===========================================================
echo                 FiveM TERMINAL SCANNER
echo ===========================================================
echo.
echo  1) FiveM-Ordner prüfen
echo  2) Scan-Log anzeigen
echo  3) Beenden
echo.
set /p choice=Bitte Auswahl eingeben: 

if "%choice%"=="1" goto SCAN
if "%choice%"=="2" goto SHOWLOG
if "%choice%"=="3" exit
goto MENU

:SCAN
cls
echo ===========================================================
echo                STARTE FIVEM SCAN...
echo ===========================================================
echo Ordner: %FIVEM_PATH%
echo.
echo Ergebnisse werden nach: %LOGFILE%
echo gespeichert.
echo -----------------------------------------------------------

if not exist "%FIVEM_PATH%" (
    echo FEHLER: FiveM-Ordner nicht gefunden!
    pause
    goto MENU
)

echo Scan gestartet am %date% %time% > "%LOGFILE%"
echo ----------------------------------------------------------- >> "%LOGFILE%"

:: Verdächtige Dateitypen
set suspiciousExt=*.lua *.asi *.dll *.exe *.ct
set suspiciousNames=modmenu* cheat* injector* hack* exploit* menu*

echo Suche nach ungewöhnlichen Dateitypen...
for %%x in (%suspiciousExt%) do (
    for /r "%FIVEM_PATH%" %%i in (%%x) do (
        echo [EXT] %%i
        echo [EXT] %%i >> "%LOGFILE%"
    )
)

echo Suche nach verdächtigen Dateinamen...
for %%y in (%suspiciousNames%) do (
    for /r "%FIVEM_PATH%" %%j in (%%y.*) do (
        echo [NAME] %%j
        echo [NAME] %%j >> "%LOGFILE%"
    )
)

echo -----------------------------------------------------------
echo Scan abgeschlossen!
echo.
pause
goto MENU


:SHOWLOG
cls
echo ===========================================================
echo                   SCAN LOG ANZEIGE
echo ===========================================================
echo.
if not exist "%LOGFILE%" (
    echo Kein Logfile gefunden!
    pause
    goto MENU
)

type "%LOGFILE%"
echo.
pause
goto MENU
