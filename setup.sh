#!/bin/bash

# AI Website Setup Script
# This script helps you get started quickly

set -e

echo "🚀 AI Website Setup"
echo "=================="
echo ""

# Check dependencies
echo "✓ Checking dependencies..."

if ! command -v node &> /dev/null; then
    echo "❌ Node.js not installed. Visit https://nodejs.org"
    exit 1
fi

if ! command -v python &> /dev/null; then
    echo "❌ Python not installed. Visit https://www.python.org"
    exit 1
fi

echo "✓ Node.js: $(node --version)"
echo "✓ Python: $(python --version)"
echo ""

# Create .env files from examples
echo "📝 Setting up environment files..."

if [ ! -f ".env" ]; then
    cp .env.example .env
    echo "✓ Created root .env (update GROQ_API_KEY)"
else
    echo "✓ .env already exists"
fi

if [ ! -f "frontend/.env" ]; then
    cp frontend/.env.example frontend/.env
    echo "✓ Created frontend/.env"
else
    echo "✓ frontend/.env already exists"
fi

if [ ! -f "backend/.env" ]; then
    cp backend/.env.example backend/.env
    echo "✓ Created backend/.env (update GROQ_API_KEY)"
else
    echo "✓ backend/.env already exists"
fi

if [ ! -f "python-ai/.env" ]; then
    cp python-ai/.env.example python-ai/.env
    echo "✓ Created python-ai/.env (update GROQ_API_KEY)"
else
    echo "✓ python-ai/.env already exists"
fi

echo ""
echo "📦 Installing dependencies..."

# Install frontend
echo "  → Installing frontend dependencies..."
cd frontend
npm install --silent
cd ..
echo "  ✓ Frontend ready"

# Install backend
echo "  → Installing backend dependencies..."
cd backend
npm install --silent
cd ..
echo "  ✓ Backend ready"

# Setup Python
echo "  → Setting up Python environment..."
cd python-ai
if [ ! -d "venv" ]; then
    python -m venv venv
fi
source venv/bin/activate
pip install -r requirements.txt > /dev/null 2>&1
cd ..
echo "  ✓ Python ready"

echo ""
echo "✅ Setup complete!"
echo ""
echo "📖 Next steps:"
echo "1. Get your free Groq API key: https://console.groq.com"
echo "2. Update GROQ_API_KEY in .env files"
echo "3. Run ./start.sh to launch all services"
echo ""
