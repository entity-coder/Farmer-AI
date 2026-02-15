@echo off
REM Start all services on Windows

echo.
echo 🚀 Starting AI Website Services
echo ================================
echo.

REM Check if setup is done
if not exist "backend\node_modules" (
    echo ❌ Dependencies not installed. Run setup.bat first
    pause
    exit /b 1
)

echo Starting services... (Windows will open 3 new terminal windows)
echo.
echo Terminal 1: Python AI Service (http://localhost:5001)
echo Terminal 2: Node.js Backend (http://localhost:5000)
echo Terminal 3: React Frontend (http://localhost:3000)
echo.

REM Start Python AI Service
start "Python AI Service" cmd /k "cd python-ai && venv\Scripts\activate && python app.py"

REM Wait a bit
timeout /t 2

REM Start Backend
start "Node.js Backend" cmd /k "cd backend && npm start"

REM Wait a bit more
timeout /t 2

REM Start Frontend
start "React Frontend" cmd /k "cd frontend && npm start"

echo.
echo ✓ All services started!
echo.
echo 💡 Frontend will open automatically at http://localhost:3000
echo 📝 Check terminal windows for any errors
echo.
pause
