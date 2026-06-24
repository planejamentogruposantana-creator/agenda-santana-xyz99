@echo off
title Servidor Agenda (Pode Minimizar)
cd /d "%~dp0"
echo Iniciando servidor local para a Agenda...
start http://localhost:8000
python -m http.server 8000
