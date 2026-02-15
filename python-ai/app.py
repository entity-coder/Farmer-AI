from flask import Flask, request, jsonify
from groq import Groq
import os
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)
PORT = os.getenv('PORT', 5001)
GROQ_API_KEY = os.getenv('GROQ_API_KEY')

# Initialize Groq client
client = Groq(api_key=GROQ_API_KEY)

@app.route('/health', methods=['GET'])
def health():
    return jsonify({'status': 'healthy', 'service': 'python-ai'})

@app.route('/analyze', methods=['POST'])
def analyze():
    try:
        data = request.json
        text = data.get('text', '')
        request_type = data.get('type', 'chat')

        if not text:
            return jsonify({'error': 'Text is required'}), 400

        # Use Groq API for AI analysis
        message = client.messages.create(
            model="mixtral-8x7b-32768",
            max_tokens=1024,
            messages=[
                {"role": "user", "content": text}
            ]
        )

        response_text = message.content[0].text

        return jsonify({
            'result': response_text,
            'model': 'mixtral-8x7b',
            'type': request_type
        })

    except Exception as e:
        return jsonify({
            'error': 'Failed to process request',
            'details': str(e)
        }), 500

@app.route('/generate', methods=['POST'])
def generate():
    try:
        data = request.json
        prompt = data.get('prompt', '')
        max_tokens = data.get('max_tokens', 512)

        if not prompt:
            return jsonify({'error': 'Prompt is required'}), 400

        message = client.messages.create(
            model="mixtral-8x7b-32768",
            max_tokens=max_tokens,
            messages=[
                {"role": "user", "content": prompt}
            ]
        )

        return jsonify({
            'generated_text': message.content[0].text,
            'model': 'mixtral-8x7b'
        })

    except Exception as e:
        return jsonify({
            'error': 'Failed to generate content',
            'details': str(e)
        }), 500

if __name__ == '__main__':
    if not GROQ_API_KEY:
        print("⚠️  GROQ_API_KEY not set. Please configure it in .env")
    print(f"🐍 Python AI service running on http://localhost:{PORT}")
    app.run(debug=True, port=int(PORT))
