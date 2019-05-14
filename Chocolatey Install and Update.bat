@echo off

echo Starting Chocolatey Install and Update script.

REM Ensure admin (UAC)
REM https://stackoverflow.com/a/52517718
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

REM Check if Choco works, if not install it.
choco -? > NUL || @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

REM Upgrade All, except those likely to have already auto-updated out of sync with us
choco upgrade all -y --exit-when-reboot-detected --except="firefox,googlechrome,spotify,discord.install" || pause && exit

REM Install Programs
choco install jre8 firefox googlechrome ublockorigin-firefox edgedeflector notepadplusplus.install 7zip.install filezilla putty.install everything ccleaner ffmpeg vlc mpv.install spotify discord.install f.lux.install gpg4win -y

echo Installation and Updates Completed!
pause
exit
