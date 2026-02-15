#!/bin/bash

# Start all services on Unix/Linux/macOS

echo ""
echo "🚀 Starting AI Website Services"
echo "================================"
echo ""

# Check if setup is done
if [ ! -d "backend/node_modules" ]; then
    echo "❌ Dependencies not installed. Run ./setup.sh first"
    exit 1
fi

echo "Starting services... (3 new terminal windows/tabs will open)"
echo ""
echo "Service 1: Python AI Service (http://localhost:5001)"
echo "Service 2: Node.js Backend (http://localhost:5000)"
echo "Service 3: React Frontend (http://localhost:3000)"
echo ""

# Function to start service in background and display in terminal
start_service() {
    local name=$1
    local cmd=$2
    echo "Starting $name..."
    
    if command -v gnome-terminal &> /dev/null; then
        gnome-terminal -- bash -c "$cmd; bash"
    elif command -v xterm &> /dev/null; then
        xterm -e "$cmd" &
    elif command -v open &> /dev/null; then
        open -a Terminal <(echo "$cmd")
    else
        echo "Please run the following in a new terminal:"
        echo "$cmd"
    fi
}

# Start Python service
start_service "Python AI Service" "cd $(pwd)/python-ai && source venv/bin/activate && python app.py"
sleep 2

# Start Backend
start_service "Node.js Backend" "cd $(pwd)/backend && npm start"
sleep 2

# Start Frontend
start_service "React Frontend" "cd $(pwd)/frontend && npm start"

echo ""
echo "✓ All services started!"
echo ""
echo "💡 Frontend will open automatically at http://localhost:3000"
echo "📝 Check terminal windows for any errors"
echo ""
