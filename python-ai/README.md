# Python AI Service - Flask & Groq

AI processing service that handles all AI inference using the free Groq API.

## Features

- 🧠 Powered by Groq API (completely free)
- 🚀 Fast inference with Mixtral 8x7B
- 🐍 Flask microservice architecture
- 📊 Scalable and lightweight
- ☁️ Container-ready deployment

## Setup

### Prerequisites
- Python 3.9+
- pip package manager

### Installation

```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

### Environment Variables

Create `.env` file:
```
GROQ_API_KEY=your_groq_api_key_here
PORT=5001
FLASK_ENV=development
```

## Running the Service

```bash
# Start Flask development server
python app.py

# Should output:
# 🐍 Python AI service running on http://localhost:5001
```

## API Endpoints

### Health Check
```
GET /health
Response: { status: "healthy", service: "python-ai" }
```

### Analyze Text
```
POST /analyze
Body: { 
  text: "Text to analyze",
  type: "chat"  # optional
}
Response: { 
  result: "Analysis result",
  model: "mixtral-8x7b",
  type: "chat"
}
```

### Generate Content
```
POST /generate
Body: { 
  prompt: "Generation prompt",
  max_tokens: 512  # optional
}
Response: { 
  generated_text: "Generated content",
  model: "mixtral-8x7b"
}
```

## Project Structure

```
python-ai/
├── app.py                 # Flask application
├── requirements.txt       # Python dependencies
├── .env.example          # Environment template
├── Dockerfile            # Docker configuration
├── .gitignore
└── README.md
```

## Dependencies

- **Flask**: Web framework (lightweight alternative to Express)
- **groq**: Official Groq Python SDK
- **python-dotenv**: Environment variable management
- **requests**: HTTP client

## How Groq API Works

1. Free tier includes generous token limits
2. Models: Mixtral 8x7B, Llama 2 70B
3. Ultra-fast inference (50+ tokens/sec)
4. Perfect for real-time applications

### Getting Your Free API Key

1. Visit https://console.groq.com
2. Sign up (free account)
3. Go to "API Keys" section
4. Generate new key
5. Add to `.env` file

## Deployment

### Local Development
```bash
# Activate virtual environment
source venv/bin/activate

# Run app
python app.py
```

### Production
```bash
# Use production WSGI server (gunicorn)
pip install gunicorn
gunicorn -w 4 -b 0.0.0.0:5001 app:app
```

### Docker
```bash
# Build image
docker build -t ai-python:latest .

# Run container
docker run -p 5001:5001 \
  -e GROQ_API_KEY=your_key \
  ai-python:latest
```

### Docker Compose
```bash
cd ..
docker-compose up
```

## Error Handling

Service handles:
- Missing API key (displays warning)
- Invalid requests (400 errors)
- API failures (500 errors)
- Malformed JSON

## Performance Tips

- Groq API is extremely fast
- Connection reuses through persistent client
- Response time typically 500-2000ms
- Free tier handles production loads

## Configuration

### Model Selection
Current: `mixtral-8x7b-32768`
Also available: `llama2-70b-4096`

Change in `create` calls:
```python
response = client.messages.create(
    model="mixtral-8x7b-32768",  # Change here
    max_tokens=1024,
    messages=[...]
)
```

### Customization

Add more endpoints as needed:
```python
@app.route('/custom', methods=['POST'])
def custom():
    # Your logic here
    pass
```

## Troubleshooting

### Module not found
```bash
# Make sure virtual environment is activated
# Reinstall dependencies
pip install -r requirements.txt
```

### GROQ_API_KEY error
- Add key to `.env` file
- Verify key is valid
- Restart service

### Connection refused
- Check if service is running
- Verify port 5001 is available
- Check firewall settings

### Slow responses
- Groq is normally very fast
- Check internet connection
- Verify API key quota
- Monitor CPU usage

## Testing

Quick test from Python:
```python
import requests

response = requests.post('http://localhost:5001/analyze', 
    json={'text': 'What is AI?'})
print(response.json())
```

## Advanced Features

### Streaming Responses
Groq SDK supports streaming for real-time responses. Modify `/generate`:
```python
stream = client.messages.stream(
    model="mixtral-8x7b-32768",
    messages=[...]
)
for chunk in stream:
    # Process streaming response
    pass
```

### Token Counting
Some models provide token counting for optimization.

## Resources

- **Groq Docs**: https://console.groq.com/docs
- **Flask Docs**: https://flask.palletsprojects.com
- **Python Groq SDK**: https://github.com/groq/groq-python
- **Mixtral Model Card**: https://huggingface.co/mistralai/Mixtral-8x7B

---

Built with ❤️ using Python, Flask & Groq
