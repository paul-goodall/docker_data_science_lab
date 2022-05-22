
@echo off

echo =====================================================
echo ============== DOCKER DATA SCIENCE LAB ==============
echo =====================================================

:: #####################################################:
:: Edit this section:
:: change local_magic_path if you would prefer to specify a different mount location:
set local_magic_path=%cd%\rstudio
:: #####################################################:
:: Probably no need to edit below here:
:: #####################################################:

:: get the local ip address:
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set ip=%%b
set local_ip=%ip:~1%

:: check if the magic directory exists:
:: if it does not exist - this is a first-time run and the dot-files the container created will need to be retained:
:: if it does exist, the user probably wants to continue from a previous session with the dotfiles etc from previously:

set fresh_start=yes
if exist %local_magic_path%\ (
set fresh_start=no
echo Directory %local_magic_path% exists - continuing from previous session.
) else (
set fresh_start=yes
echo Directory %local_magic_path% does not exist - treating as fresh start.
mkdir %local_magic_path%
)

:: docker_magic_home cannot be changed here - it needs to match DOCKER_MAGIC_DIR from the icing dockerfile:
set docker_magic_home=/Volumes/Abyss/rstudio
set volume_string=%local_magic_path%:%docker_magic_home%

echo =====================================================
echo SETUP:
echo local_ip = [%local_ip%]
echo display = ["%local_ip%:0"]
echo local_magic_path = [%local_magic_path%]
echo docker_magic_home = [%docker_magic_home%]
echo fresh_start = [%fresh_start%]
echo =====================================================
echo If you are happy with these settings,
pause

docker run -d -p 8787:8787 -p 3838:3838 -p 8888:8888 --name data_science_lab -e HOST_OS="win" -e "%local_ip%:0" -e MAGIC_FOLDER="%docker_magic_home%" -e FRESH_START="%fresh_start%" -v %volume_string% -e DISABLE_AUTH=true goodsy/docker_data_science_lab:latest
