@echo off
set EXE_NAME=KSeF-PDFGen.exe
set RH_PATH="C:\Program Files (x86)\Programowanie\Resource Hacker\ResourceHacker.exe"
set RC_COMPILER="rc.exe"

:: 1. Kompilacja plików .rc do .res
echo [1/5] Kompilacja zasobów...
%RC_COMPILER% ksef-pdf-gen.rc
%RC_COMPILER% ksef-pdf-gen-robocza.rc
%RC_COMPILER% ksef-pdf-gen-26_1.rc

:: 2. Budowa "czystego" EXE
echo [2/5] Budowa rdzenia aplikacji...
call npm install
call npm run build

if not exist %EXE_NAME% (
    echo [ERROR] Plik %EXE_NAME% nie zostal utworzony!
    pause
    exit /b
)

:: 3. Wersja robocza
echo [3/5] Generowanie wersji roboczej...
%RH_PATH% -open %EXE_NAME% -save KSeF_ROBOCZA.exe -action addoverwrite -res ksef-pdf-gen-robocza.res -mask VERSIONINFO,1,
if exist KSeF_ROBOCZA.exe move /y KSeF_ROBOCZA.exe "q:\EkonomBin\3_wersja_robocza_XE\Ekonom\%EXE_NAME%"

:: 4. Wersja faza testów
echo [4/5] Generowanie wersji testowej 26.1...
%RH_PATH% -open %EXE_NAME% -save KSeF_TEST.exe -action addoverwrite -res ksef-pdf-gen-26_1.res -mask VERSIONINFO,1,
if exist KSeF_TEST.exe move /y KSeF_TEST.exe "q:\EkonomBin\2_wersja_faza_testow\ver_10.26.1\Ekonom\%EXE_NAME%"

:: 5. Wersja finalna
echo [5/5] Generowanie wersji pliku glownego...
%RH_PATH% -open %EXE_NAME% -save %EXE_NAME% -action addoverwrite -res ksef-pdf-gen.res -mask VERSIONINFO,1,

:: Sprz¹tanie plików tymczasowych .res
del *.res

echo.
echo Gotowe!
pause
