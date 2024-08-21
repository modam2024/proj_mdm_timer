@echo off
echo move to a project root...
cd C:\pyDjangoDEV\proj_mdm_timer

echo Activating virtual environment...
CALL .venv\Scripts\activate

echo Starting Django server...
python serve.py

echo Done.