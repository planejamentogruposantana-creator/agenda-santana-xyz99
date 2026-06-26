@echo off
title Servidor Agenda (Pode Minimizar)
cd /d "%~dp0"
echo Sincronizando agenda com a nuvem do GitHub...
git pull --rebase --autostash origin gh-pages
git add .
git commit -m "Auto-sync local"
git push origin gh-pages
echo Iniciando servidor local para a Agenda...
start http://localhost:8000
python -m http.server 8000
