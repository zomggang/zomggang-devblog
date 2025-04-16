@echo off
:: ========================================
:: Build script for initializing Hugo site
:: Deletes old /public and rebuilds static site
:: ========================================
echo Cleaning old build...
rmdir /s /q public

echo Building Hugo site...
hugo --minify

echo Done. Preview with: hugo server -D
pause
