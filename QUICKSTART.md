# Quick Start Guide

## 🚀 Setup Instructions

### Prerequisites
- Node.js 18+ (download from https://nodejs.org)
- Python 3.9+ (download from https://www.python.org)
- Docker & Docker Compose (optional, for containerized deployment)

### Free AI API Setup

**Get Groq API Key (FREE):**
1. Visit https://console.groq.com
2. Sign up for free account
3. Navigate to API Keys section
4. Generate a new API key
5. Copy and save your key

### Local Development Setup

#### Step 1: Frontend Setup
```bash
cd frontend
npm install
```

Create `.env` file in `frontend/`:
```
REACT_APP_API_URL=http://localhost:5000
```

#### Step 2: Backend Setup
```bash
cd backend
npm install
```

Create `.env` file in `backend/`:
```
PORT=5000
NODE_ENV=development
GROQ_API_KEY=your_groq_api_key_here
PYTHON_AI_URL=http://localhost:5001
```

#### Step 3: Python AI Service Setup
```bash
cd python-ai
python -m venv venv

# On Windows:
venv\Scripts\activate

# On macOS/Linux:
source venv/bin/activate

pip install -r requirements.txt
```

Create `.env` file in `python-ai/`:
```
GROQ_API_KEY=your_groq_api_key_here
PORT=5001
FLASK_ENV=development
```

### Running Everything

**Open 3 Terminal Windows:**

**Terminal 1 - Python AI Service:**
```bash
cd python-ai
source venv/bin/activate  # or venv\Scripts\activate on Windows
python app.py
# Should show: 🐍 Python AI service running on http://localhost:5001
```

**Terminal 2 - Node.js Backend:**
```bash
cd backend
npm start
# Should show: 🚀 Backend server running on http://localhost:5000
```

**Terminal 3 - React Frontend:**
```bash
cd frontend
npm start
# Should open http://localhost:3000 automatically
```

Visit http://localhost:3000 and click "Try AI" to chat!

---

## 🐳 Docker Deployment

### Quick Deploy with Docker Compose

1. Create `.env` file in root directory:
```
GROQ_API_KEY=your_groq_api_key_here
```

2. Run:
```bash
docker-compose up --build
```

3. Access:
- Frontend: http://localhost:3000
- Backend: http://localhost:5000
- Python AI: http://localhost:5001

### Stop Services
```bash
docker-compose down
```

---

## 🌐 Cloud Deployment

### Deploy to Azure Container Instances

```bash
# Build images
docker build -t ai-frontend frontend/
docker build -t ai-backend backend/
docker build -t ai-python python-ai/

# Push to Azure Container Registry
az acr build --registry myregistry -t ai-frontend:latest frontend/
az acr build --registry myregistry -t ai-backend:latest backend/
az acr build --registry myregistry -t ai-python:latest python-ai/

# Deploy using docker-compose
az container create \
  --resource-group mygroup \
  --name ai-app \
  --file docker-compose.yml
```

### Deploy to Docker Hub

```bash
docker tag ai-frontend:latest username/ai-frontend:latest
docker push username/ai-frontend:latest

docker tag ai-backend:latest username/ai-backend:latest
docker push username/ai-backend:latest

docker tag ai-python:latest username/ai-python:latest
docker push username/ai-python:latest
```

---

## 📝 API Documentation

### Backend Endpoints

- **GET** `/` - Health check
- **POST** `/api/chat` - Send message to AI
- **GET** `/api/models` - List available models

### Python AI Service Endpoints

- **GET** `/health` - Health check
- **POST** `/analyze` - Analyze text with AI
- **POST** `/generate` - Generate content

---

## ❓ Troubleshooting

### Backend can't connect to Python service
- Make sure Python service is running on port 5001
- Check PYTHON_AI_URL in backend .env

### Frontend shows "Error: Network Error"
- Ensure backend is running on port 5000
- Check REACT_APP_API_URL in frontend .env
- Clear browser cache (Ctrl+Shift+Delete)

### "GROQ_API_KEY not set" error
- Add GROQ_API_KEY to all .env files
- Restart services after updating .env

### Python service won't start
- Verify Python 3.9+ installed: `python --version`
- Activate virtual environment before running
- Run `pip install -r requirements.txt`

---

## 📚 Project Structure

```
.
├── frontend/              # React UI (Port 3000)
│   ├── public/
│   ├── src/
│   │   ├── App.js        # Main landing page
│   │   ├── index.js
│   │   └── index.css
│   └── package.json
├── backend/               # Node.js API (Port 5000)
│   ├── server.js
│   └── package.json
├── python-ai/             # Python AI Service (Port 5001)
│   ├── app.py
│   └── requirements.txt
├── docker-compose.yml     # Multi-container orchestration
└── README.md
```

---

## 🎯 Next Steps

1. ✅ Set up Groq API key
2. ✅ Install dependencies locally
3. ✅ Run all three services
4. ✅ Test the chat interface
5. ✅ Deploy with Docker
6. ✅ Scale to production

---

## 📖 Resources

- **Groq API Docs**: https://console.groq.com/docs
- **React Docs**: https://react.dev
- **Node.js Docs**: https://nodejs.org/docs
- **Python Flask**: https://flask.palletsprojects.com
- **Docker Docs**: https://docs.docker.com

---

## 💡 Tips

- Keep your GROQ_API_KEY secure - never commit to git
- Use different API keys for development and production
- Monitor API usage on Groq console to stay within free tier
- Test locally before deploying to cloud

Enjoy building! 🎉
