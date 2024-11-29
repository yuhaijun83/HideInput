@ECHO OFF
REM *************************************************************************
REM   FileName    :: TEST.bat
REM   Generated   :: yyyy-MM-dd
REM   LastAuthor  :: XXXX
REM *************************************************************************

SET CURRENT_PATH=%~dp0
SET HIDEINPUT_PATH=%CURRENT_PATH%\ReleaseTools\HideInput\HideInput.exe

SET ORACLE_USER=C01
SET ORACLE_PASS=
SET ORACLE_SID=ACSDB

rem ECHO DB�ڑ����[�U�̃p�X���[�h����͂��Ă�������:(�p�X���[�h���\���ɂ���)
ECHO.

:INPUT_PASS_LBL01
SET INPUT_ORACLE_PASS_TMP=
FOR /F "usebackq tokens=1,2" %%A IN (`%HIDEINPUT_PATH% SQLPLUS`) DO (
    SET INPUT_ORACLE_PASS_TMP=%%A
)
IF "%INPUT_ORACLE_PASS_TMP%" == "" (
  ECHO �p�X���[�h����͂��Ă�������:
  GOTO :INPUT_PASS_LBL01
)
SET ORACLE_PASS=%INPUT_ORACLE_PASS_TMP%

ECHO PASSWORD IS:%ORACLE_PASS%
ECHO.
CMD /K SQLPLUS.exe -S -L %ORACLE_USER%/%ORACLE_PASS%@%ORACLE_SID% @ReleaseTools\DB_CONNECT_TEST\DB_CONNECT_TEST.SQL
IF %ERRORLEVEL% == 0 (
    ECHO.
    ECHO ���͂����p�X���[�h���������ł��B���̏������J�n���܂�... ...
) ELSE (
    ECHO.
    ECHO ���͂����p�X���[�h���ԈႢ�ł��B������x���͂��Ă��������B
    GOTO :INPUT_PASS_LBL01
)

PAUSE

@ECHO OFF
