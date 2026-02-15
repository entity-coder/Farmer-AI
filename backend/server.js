const express = require('express');
const cors = require('cors');
const axios = require('axios');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(cors());
app.use(express.json());

// Health check
app.get('/', (req, res) => {
  res.json({ message: 'Backend is running!', status: 'healthy' });
});

// Chat endpoint
app.post('/api/chat', async (req, res) => {
  try {
    const { message } = req.body;

    if (!message) {
      return res.status(400).json({ error: 'Message is required' });
    }

    // Forward to Python AI service
    const pythonServiceUrl = process.env.PYTHON_AI_URL || 'http://localhost:5001';
    const response = await axios.post(`${pythonServiceUrl}/analyze`, {
      text: message,
      type: 'chat'
    });

    res.json({ response: response.data.result });
  } catch (error) {
    console.error('Error:', error.message);
    res.status(500).json({
      error: 'Failed to process request',
      details: error.message
    });
  }
});

// Models endpoint
app.get('/api/models', (req, res) => {
  res.json({
    models: [
      {
        id: 'mixtral-8x7b',
        name: 'Mixtral 8x7B',
        provider: 'Groq',
        free: true
      },
      {
        id: 'llama2-70b',
        name: 'Llama 2 70B',
        provider: 'Groq',
        free: true
      }
    ]
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({ error: 'Internal server error' });
});

app.listen(PORT, () => {
  console.log(`🚀 Backend server running on http://localhost:${PORT}`);
  console.log(`📝 Swagger docs available at http://localhost:${PORT}/docs`);
});
