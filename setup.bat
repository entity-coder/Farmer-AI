@echo off
REM AI Website Setup Script for Windows

echo.
echo 🚀 AI Website Setup
echo ====================
echo.

REM Check Node.js
where node >nul 2>nul
if errorlevel 1 (
    echo ❌ Node.js not installed. Visit https://nodejs.org
    pause
    exit /b 1
)

REM Check Python
where python >nul 2>nul
if errorlevel 1 (
    echo ❌ Python not installed. Visit https://www.python.org
    pause
    exit /b 1
)

echo ✓ Checking dependencies...
node --version
python --version
echo.

REM Create .env files from examples
echo 📝 Setting up environment files...

if not exist ".env" (
    copy .env.example .env
    echo ✓ Created root .env (update GROQ_API_KEY)
) else (
    echo ✓ .env already exists
)

if not exist "frontend\.env" (
    copy frontend\.env.example frontend\.env
    echo ✓ Created frontend\.env
) else (
    echo ✓ frontend\.env already exists
)

if not exist "backend\.env" (
    copy backend\.env.example backend\.env
    echo ✓ Created backend\.env (update GROQ_API_KEY)
) else (
    echo ✓ backend\.env already exists
)

if not exist "python-ai\.env" (
    copy python-ai\.env.example python-ai\.env
    echo ✓ Created python-ai\.env (update GROQ_API_KEY)
) else (
    echo ✓ python-ai\.env already exists
)

echo.
echo 📦 Installing dependencies...

REM Install frontend
echo   → Installing frontend dependencies...
cd frontend
call npm install
cd ..
echo   ✓ Frontend ready

REM Install backend
echo   → Installing backend dependencies...
cd backend
call npm install
cd ..
echo   ✓ Backend ready

REM Setup Python
echo   → Setting up Python environment...
cd python-ai
if not exist "venv" (
    python -m venv venv
)
call venv\Scripts\activate
pip install -r requirements.txt
cd ..
echo   ✓ Python ready

echo.
echo ✅ Setup complete!
echo.
echo 📖 Next steps:
echo 1. Get your free Groq API key: https://console.groq.com
echo 2. Update GROQ_API_KEY in .env files
echo 3. Run start.bat to launch all services
echo.
pause
