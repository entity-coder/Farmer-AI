# Frontend - React AI Application

Modern React landing page and chatbot interface for the AI-powered website.

## Features

- ⚡ Lightning-fast UI built with React
- 🎨 Beautiful Tailwind CSS design
- 💬 Real-time AI chat interface
- 📱 Fully responsive design
- 🔄 Live API integration

## Setup

```bash
# Install dependencies
npm install

# Start development server
npm start

# Build for production
npm run build
```

## Environment Variables

Create `.env` file:
```
REACT_APP_API_URL=http://localhost:5000
REACT_APP_ENVIRONMENT=development
```

## Available Scripts

- `npm start` - Runs development server on http://localhost:3000
- `npm build` - Creates production build
- `npm test` - Runs tests

## Project Structure

```
src/
├── App.js          # Main component with landing page and chat
├── App.css         # Styling
├── index.js        # Entry point
└── index.css       # Global styles
```

## Dependencies

- **react**: UI library
- **axios**: HTTP client
- **tailwindcss**: CSS framework

## Deployment

### Docker Build
```bash
docker build -t ai-frontend:latest .
docker run -p 3000:3000 ai-frontend:latest
```

### Docker Compose
```bash
cd ..
docker-compose up
```

## Features Explained

### Landing Page
- Hero section with CTA
- Feature cards for key benefits
- Technology stack display
- Call-to-action button to start chatting

### Chat Interface
- Clean, modern design
- Real-time message sending
- Loading states
- Error handling
- Response display

## Styling

Uses Tailwind CSS from CDN for easy setup. All styles are inline using Tailwind classes for maximum flexibility.

## API Integration

The app communicates with backend on `/api/chat` endpoint:

```javascript
POST /api/chat
{
  message: "Your question here"
}

Response:
{
  response: "AI generated answer"
}
```

## Tips

- Design is fully responsive - works on mobile, tablet, desktop
- Tailwind CSS provides utility classes for easy customization
- Axios is configured with proxy to backend
- Error boundaries handle API failures gracefully

---

Built with ❤️ using React & Tailwind CSS
