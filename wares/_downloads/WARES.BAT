@ECHO OFF
IF NOT EXIST "%USERPROFILE%\DESKTOP\NETPRINT.BAT" GOTO DRIVE_C
CALL "%USERPROFILE%\DESKTOP\NETPRINT.BAT"
GOTO ENDPRINT
:DRIVE_C
IF EXIST C:\NETPRINT.BAT CALL C:\NETPRINT.BAT
:ENDPRINT
S:

IF EXIST AREV.BMP GOTO MAIN
IF EXIST ATLAS.LCK GOTO BUSY
COPY WARES.BAT ATLAS.LCK
IF NOT "%EMSMAGIC%" == "" EMSMAGIC

:MAIN
IF $%1$==$$ GOTO UNAME
IF EXIST %1.INI SET AREV=%1.INI
IF NOT EXIST %1.INI SET AREV=DEFAULT.INI
AREV.EXE %1 /X
GOTO EXIT

:UNAME
IF $%USERNAME%$==$$ GOTO NONAME
IF EXIST %USERNAME%.INI SET AREV=%USERNAME%.INI
IF NOT EXIST %USERNAME%.INI SET AREV=DEFAULT.INI
AREV %USERNAME% /X
GOTO EXIT

:NONAME
SET AREV=DEFAULT.INI
AREV ATLAS /X

:EXIT
IF NOT EXIST RESTART.BAT GOTO WRAP
echo calling restart.bat
CALL RESTART.BAT

:WRAP
SET AREV=""
IF EXIST ATLAS.LCK DEL ATLAS.LCK
IF EXIST RESTART.BAT DEL RESTART.BAT
GOTO END

:BUSY
ECHO              зддддддддддддддддддддддддддддддддддддддддддд©
ECHO              Ё                                           Ё
ECHO              Ё  Another session of ATLAS is running.     Ё
ECHO              Ё                                           Ё
ECHO              Ё  Please use the running session instead   Ё
ECHO              Ё                                           Ё
ECHO              Ё  of trying to start ATLAS again.          Ё
ECHO              Ё                                           Ё
ECHO              Ё      ( or DEL \ATLAS\ATLAS.LCK )          Ё
ECHO              Ё                                           Ё
ECHO              юддддддддддддддддддддддддддддддддддддддддддды
PAUSE.

:END
