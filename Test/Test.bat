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

rem ECHO DB接続ユーザのパスワードを入力してください:(パスワードを非表示にする)
ECHO.

:INPUT_PASS_LBL01
SET INPUT_ORACLE_PASS_TMP=
FOR /F "usebackq tokens=1,2" %%A IN (`%HIDEINPUT_PATH% SQLPLUS`) DO (
    SET INPUT_ORACLE_PASS_TMP=%%A
)
IF "%INPUT_ORACLE_PASS_TMP%" == "" (
  ECHO パスワードを入力してください:
  GOTO :INPUT_PASS_LBL01
)
SET ORACLE_PASS=%INPUT_ORACLE_PASS_TMP%

ECHO PASSWORD IS:%ORACLE_PASS%
ECHO.
CMD /K SQLPLUS.exe -S -L %ORACLE_USER%/%ORACLE_PASS%@%ORACLE_SID% @ReleaseTools\DB_CONNECT_TEST\DB_CONNECT_TEST.SQL
IF %ERRORLEVEL% == 0 (
    ECHO.
    ECHO 入力したパスワードが正しいです。次の処理を開始します... ...
) ELSE (
    ECHO.
    ECHO 入力したパスワードが間違いです。もう一度入力してください。
    GOTO :INPUT_PASS_LBL01
)

PAUSE

@ECHO OFF
