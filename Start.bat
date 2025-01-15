@echo off
cd %~dp0
start powershell -NoProfile -Command "Start-Process powershell -ArgumentList '-ExecutionPolicy Unrestricted -File \"%~dp0sources\setup.ps1\"' -Verb RunAs"
