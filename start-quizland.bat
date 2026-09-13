@echo off
cd /d "%~dp0"
echo Starting QuizLand at http://localhost:8080
echo Keep this window open while you use the microphone.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0serve-quizland.ps1"
pause
