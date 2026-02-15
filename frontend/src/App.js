import React, { useState } from 'react';
import axios from 'axios';
import './App.css';

function App() {
  const [message, setMessage] = useState('');
  const [response, setResponse] = useState('');
  const [loading, setLoading] = useState(false);
  const [showChat, setShowChat] = useState(false);

  const handleChat = async (e) => {
    e.preventDefault();
    if (!message.trim()) return;

    setLoading(true);
    try {
      const res = await axios.post('/api/chat', { message });
      setResponse(res.data.response);
      setMessage('');
    } catch (error) {
      setResponse('Error: ' + (error.response?.data?.error || error.message));
    }
    setLoading(false);
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-600 to-purple-700">
      {/* Navigation */}
      <nav className="bg-white bg-opacity-10 backdrop-blur-md sticky top-0 z-50">
        <div className="max-w-6xl mx-auto px-4 py-4 flex justify-between items-center">
          <h1 className="text-3xl font-bold text-white">AI Studio</h1>
          <button
            onClick={() => setShowChat(!showChat)}
            className="bg-white text-blue-600 px-6 py-2 rounded-lg font-semibold hover:bg-gray-100 transition"
          >
            {showChat ? 'Close Chat' : 'Try AI'}
          </button>
        </div>
      </nav>

      {/* Hero Section */}
      {!showChat && (
        <div className="max-w-6xl mx-auto px-4 py-20">
          <div className="text-center mb-20">
            <h2 className="text-5xl md:text-6xl font-bold text-white mb-6">
              Welcome to AI Studio
            </h2>
            <p className="text-xl text-gray-100 mb-8 max-w-2xl mx-auto">
              Experience the power of artificial intelligence. Built with Node.js, React, and free AI APIs for instant access to cutting-edge AI capabilities.
            </p>
            <button
              onClick={() => setShowChat(true)}
              className="bg-white text-blue-600 px-8 py-4 rounded-lg font-bold text-lg hover:bg-gray-100 transition shadow-lg"
            >
              Start Chatting with AI
            </button>
          </div>

          {/* Features */}
          <div className="grid md:grid-cols-3 gap-8 mb-16">
            <FeatureCard
              icon="⚡"
              title="Lightning Fast"
              description="Powered by Groq API for ultra-fast AI inference"
            />
            <FeatureCard
              icon="🆓"
              title="Completely Free"
              description="Use the best free AI services without cost"
            />
            <FeatureCard
              icon="☁️"
              title="Cloud Ready"
              description="Docker containerized and ready for deployment"
            />
          </div>

          {/* Tech Stack */}
          <div className="bg-white bg-opacity-10 backdrop-blur-md rounded-2xl p-8 border border-white border-opacity-20">
            <h3 className="text-2xl font-bold text-white mb-6">Technology Stack</h3>
            <div className="grid md:grid-cols-4 gap-4">
              {['React', 'Node.js', 'Python', 'Groq AI'].map((tech) => (
                <div key={tech} className="bg-white bg-opacity-10 p-4 rounded-lg text-center">
                  <p className="text-white font-semibold">{tech}</p>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}

      {/* Chat Interface */}
      {showChat && (
        <div className="max-w-2xl mx-auto px-4 py-8">
          <div className="bg-white rounded-2xl shadow-2xl p-8">
            <h2 className="text-3xl font-bold text-gray-800 mb-6">AI Chat</h2>

            <div className="bg-gray-50 rounded-lg p-6 mb-6 min-h-40 max-h-96 overflow-y-auto">
              {response ? (
                <div className="space-y-4">
                  <div className="bg-blue-100 p-4 rounded-lg">
                    <p className="text-gray-800">{response}</p>
                  </div>
                </div>
              ) : (
                <p className="text-gray-400 text-center py-12">
                  No response yet. Ask me something!
                </p>
              )}
            </div>

            <form onSubmit={handleChat} className="flex gap-3">
              <input
                type="text"
                value={message}
                onChange={(e) => setMessage(e.target.value)}
                placeholder="Ask me anything..."
                className="flex-1 px-4 py-3 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-blue-500"
                disabled={loading}
              />
              <button
                type="submit"
                disabled={loading}
                className="bg-blue-600 text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-700 transition disabled:bg-gray-400"
              >
                {loading ? 'Sending...' : 'Send'}
              </button>
            </form>

            <p className="text-sm text-gray-500 mt-4 text-center">
              Powered by Groq AI • Node.js Backend
            </p>
          </div>
        </div>
      )}
    </div>
  );
}

function FeatureCard({ icon, title, description }) {
  return (
    <div className="bg-white bg-opacity-10 backdrop-blur-md rounded-xl p-6 border border-white border-opacity-20 hover:bg-opacity-20 transition">
      <div className="text-4xl mb-4">{icon}</div>
      <h3 className="text-xl font-bold text-white mb-2">{title}</h3>
      <p className="text-gray-100">{description}</p>
    </div>
  );
}

export default App;
