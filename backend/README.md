# Backend - Node.js Express API

RESTful API server that orchestrates between the frontend and Python AI service.

## Features

- 🚀 Fast Express.js server
- 🔌 RESTful API design
- 🤝 CORS enabled for frontend communication
- 🐍 Python service integration
- 📝 Error handling & logging
- ☁️ Cloud-ready architecture

## Setup

```bash
# Install dependencies
npm install

# Start server
npm start

# Development mode with auto-reload
npm run dev
```

## Environment Variables

Create `.env` file:
```
PORT=5000
NODE_ENV=development
GROQ_API_KEY=your_groq_api_key_here
PYTHON_AI_URL=http://localhost:5001
```

## API Endpoints

### Health Check
```
GET /
Response: { message: "Backend is running!", status: "healthy" }
```

### Chat with AI
```
POST /api/chat
Body: { message: "Your question" }
Response: { response: "AI generated answer" }
```

### Get Available Models
```
GET /api/models
Response: {
  models: [
    { id: "mixtral-8x7b", name: "Mixtral 8x7B", provider: "Groq", free: true },
    { id: "llama2-70b", name: "Llama 2 70B", provider: "Groq", free: true }
  ]
}
```

## Project Structure

```
backend/
├── server.js              # Main server file
├── package.json           # Dependencies
├── .env.example          # Environment template
└── Dockerfile            # Docker configuration
```

## Dependencies

- **express**: Web framework
- **cors**: Cross-origin resource sharing
- **dotenv**: Environment variable management
- **axios**: HTTP client for Python service
- **groq-sdk**: Groq AI SDK

## How It Works

1. Frontend sends chat message to `/api/chat`
2. Backend receives and validates message
3. Forwards request to Python AI service at `/analyze`
4. Python service uses Groq API for response
5. Response is returned to frontend

## Deployment

### Local Development
```bash
npm install
npm run dev
```

### Production
```bash
npm install
NODE_ENV=production npm start
```

### Docker
```bash
# Build
docker build -t ai-backend:latest .

# Run
docker run -p 5000:5000 \
  -e GROQ_API_KEY=your_key \
  -e PYTHON_AI_URL=http://python-ai:5001 \
  ai-backend:latest
```

### Docker Compose
```bash
cd ..
docker-compose up
```

## Error Handling

The server includes error handling for:
- Missing environment variables
- Python service unavailability
- Invalid requests
- API failures

## Performance

- Lightweight Express setup
- Minimal middleware overhead
- Connection pooling through axios
- Proper error handling to prevent crashes

## Configuration

### CORS
Enabled for all origins in development. Configure in production:
```javascript
app.use(cors({
  origin: 'https://yourdomain.com'
}));
```

### Python Service Communication
- Default URL: `http://localhost:5001`
- Customizable via `PYTHON_AI_URL` env variable
- Supports both local and cloud deployments

## Tips

- Always set `GROQ_API_KEY` before running
- Monitor Python service health
- Use proper error messages in responses
- Test endpoints with cURL or Postman
- Enable verbose logging in development

---

Built with ❤️ using Node.js & Express
