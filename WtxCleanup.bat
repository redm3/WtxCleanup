@echo off
REM Define variables
set SERVER_NAME=.\SQLExpress
set DATABASE_NAME=Weightrax
set SQL_SCRIPT_PATH=wtxcleanup.sql
set OUTPUT_PATH=wtxcleanup-log.txt
set USERNAME=wtxuser
set PASSWORD=Opendb2!
 
REM Run the SQL script and output results to a text file
sqlcmd -S %SERVER_NAME% -d %DATABASE_NAME% -U %USERNAME% -P %PASSWORD% -i %SQL_SCRIPT_PATH% -o %OUTPUT_PATH%
 
REM Check if the command was successful
if %ERRORLEVEL% EQU 0 (
    echo SQL script executed successfully. Results are in %OUTPUT_PATH%
) else (
    echo Failed to execute SQL script. Check the error messages above.
)
 