# Full-Stack Website with AI Integration

A modern full-stack website with Node.js backend, React frontend, and Python AI integration using the free Groq API.

## Features

- **Frontend**: React landing page with modern UI
- **Backend**: Node.js/Express REST API
- **AI Integration**: Groq API for free AI capabilities
- **Python**: AI processing and backend utilities
- **Docker**: Cloud-ready containerization
- **Responsive**: Mobile-friendly design

## Project Structure

```
project/
├── frontend/              # React app (port 3000)
├── backend/               # Node.js/Express (port 5000)
├── python-ai/             # Python AI service (port 5001)
├── docker-compose.yml     # Multi-container orchestration
└── README.md
```

## Quick Start

### Local Development

1. **Frontend**
   ```bash
   cd frontend
   npm install
   npm start
   ```

2. **Backend**
   ```bash
   cd backend
   npm install
   npm start
   ```

3. **Python AI Service**
   ```bash
   cd python-ai
   pip install -r requirements.txt
   python app.py
   ```

### Using Docker

```bash
docker-compose up
```

## Environment Variables

Create `.env` files in `backend/` and `python-ai/`:

**backend/.env**
```
PORT=5000
GROQ_API_KEY=your_groq_api_key_here
PYTHON_AI_URL=http://python-ai:5001
NODE_ENV=development
```

**python-ai/.env**
```
GROQ_API_KEY=your_groq_api_key_here
PORT=5001
```

## Get Free API Keys

1. **Groq API** (Free tier available):
   - Visit: https://console.groq.com
   - Sign up and get your free API key
   - Great for LLM inference with free quota

## API Endpoints

### Backend (Node.js)
- `GET /` - Health check
- `POST /api/chat` - Chat with AI
- `GET /api/models` - Available AI models

### Python AI Service
- `GET /health` - Health check
- `POST /analyze` - Analyze text with AI
- `POST /generate` - Generate content with AI

## Technologies Used

- **Frontend**: React, Axios, Tailwind CSS
- **Backend**: Node.js, Express, Groq SDK
- **AI**: Groq API (free tier)
- **Python**: Flask, Groq SDK
- **Deployment**: Docker, Docker Compose

## Next Steps

1. Sign up for free Groq API key
2. Update `.env` files with your API key
3. Run locally or deploy with Docker

