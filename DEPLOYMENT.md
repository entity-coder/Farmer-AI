# Deployment Guide

Complete guide to deploy your AI website to various platforms.

## Prerequisites

- GitHub/GitLab account (for version control)
- Docker installed (for containerization)
- Cloud provider account (Azure, AWS, Heroku, etc.)
- Groq API key

---

## Option 1: Local Deployment (Development)

### Step 1: Initialize Git
```bash
git init
git add .
git commit -m "Initial commit"
```

### Step 2: Setup Environment
```bash
# Windows
setup.bat

# Linux/macOS
chmod +x setup.sh && ./setup.sh
```

### Step 3: Configure API Key
Edit `.env` files and add your Groq API key:
```
GROQ_API_KEY=your_key_from_console.groq.com
```

### Step 4: Start Services
```bash
# Windows
start.bat

# Linux/macOS
chmod +x start.sh && ./start.sh
```

Visit http://localhost:3000

---

## Option 2: Docker Deployment (Single Machine)

### Prerequisites
- Docker Desktop installed
- Docker Compose installed

### Step 1: Configure Environment
```bash
cp .env.example .env
# Edit .env and add GROQ_API_KEY
```

### Step 2: Build and Run
```bash
# Build images
docker-compose build

# Start all services
docker-compose up

# Or in background
docker-compose up -d
```

### Step 3: Access Services
- Frontend: http://localhost:3000
- Backend: http://localhost:5000
- Python AI: http://localhost:5001

### Step 4: Manage Services
```bash
# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Remove volumes
docker-compose down -v
```

---

## Option 3: Azure Container Instances

### Prerequisites
- Azure CLI installed
- Azure subscription

### Step 1: Create Resource Group
```bash
az group create \
  --name ai-website \
  --location eastus
```

### Step 2: Create Container Registry
```bash
az acr create \
  --resource-group ai-website \
  --name aiwebsiteregistry \
  --sku Basic
```

### Step 3: Build and Push Images
```bash
# Frontend
az acr build \
  --registry aiwebsiteregistry \
  --image ai-frontend:latest \
  ./frontend

# Backend
az acr build \
  --registry aiwebsiteregistry \
  --image ai-backend:latest \
  ./backend

# Python AI
az acr build \
  --registry aiwebsiteregistry \
  --image ai-python:latest \
  ./python-ai
```

### Step 4: Deploy Containers
```bash
# Frontend
az container create \
  --resource-group ai-website \
  --name ai-frontend \
  --image aiwebsiteregistry.azurecr.io/ai-frontend:latest \
  --ports 3000 \
  --registry-login-server aiwebsiteregistry.azurecr.io \
  --registry-username <username> \
  --registry-password <password>

# Backend
az container create \
  --resource-group ai-website \
  --name ai-backend \
  --image aiwebsiteregistry.azurecr.io/ai-backend:latest \
  --ports 5000 \
  --environment-variables \
    GROQ_API_KEY=your_key \
    PYTHON_AI_URL=http://ai-python:5001

# Python AI
az container create \
  --resource-group ai-website \
  --name ai-python \
  --image aiwebsiteregistry.azurecr.io/ai-python:latest \
  --ports 5001 \
  --environment-variables \
    GROQ_API_KEY=your_key
```

---

## Option 4: Heroku Deployment

### Prerequisites
- Heroku CLI installed
- Heroku account

### Step 1: Create Heroku Apps
```bash
# Create Frontend app
heroku create ai-website-frontend

# Create Backend app
heroku create ai-website-backend

# Create Python app
heroku create ai-website-python
```

### Step 2: Set Environment Variables
```bash
# Backend config
heroku config:set \
  -a ai-website-backend \
  GROQ_API_KEY=your_key \
  PYTHON_AI_URL=https://ai-website-python.herokuapp.com

# Python config
heroku config:set \
  -a ai-website-python \
  GROQ_API_KEY=your_key
```

### Step 3: Deploy
```bash
# Frontend
cd frontend
heroku git:remote -a ai-website-frontend
git push heroku main

# Backend
cd ../backend
heroku git:remote -a ai-website-backend
git push heroku main

# Python
cd ../python-ai
heroku git:remote -a ai-website-python
git push heroku main
```

---

## Option 5: AWS Elastic Container Service (ECS)

### Prerequisites
- AWS CLI configured
- AWS account with ECS permissions

### Step 1: Create ECR Repositories
```bash
aws ecr create-repository --repository-name ai-frontend
aws ecr create-repository --repository-name ai-backend
aws ecr create-repository --repository-name ai-python
```

### Step 2: Push Images
```bash
# Get login token
aws ecr get-login-password --region us-east-1 | \
  docker login --username AWS --password-stdin \
  <account-id>.dkr.ecr.us-east-1.amazonaws.com

# Push images
docker tag ai-frontend:latest \
  <account-id>.dkr.ecr.us-east-1.amazonaws.com/ai-frontend:latest
docker push <account-id>.dkr.ecr.us-east-1.amazonaws.com/ai-frontend:latest

# Repeat for backend and python-ai
```

### Step 3: Create ECS Cluster
```bash
aws ecs create-cluster --cluster-name ai-website
```

### Step 4: Create Task Definitions and Services
See AWS ECS documentation for detailed steps.

---

## Option 6: DigitalOcean Deploy

### Prerequisites
- DigitalOcean account
- doctl CLI installed

### Step 1: Create Droplet
```bash
doctl compute droplet create ai-website \
  --region sfo3 \
  --image docker-20-04 \
  --size s-1vcpu-1gb
```

### Step 2: SSH into Droplet
```bash
ssh root@<your-droplet-ip>
```

### Step 3: Clone and Deploy
```bash
git clone your-repo
cd ai-website

# Setup
docker-compose up -d

# Use reverse proxy (nginx)
# See nginx configuration below
```

### Step 4: SSL Certificate (Let's Encrypt)
```bash
# Using Certbot
certbot certonly --standalone -d yourdomain.com
```

---

## Production Tips

### 1. Use Environment Variables
Store all secrets in environment variables, never in code.

### 2. Use Reverse Proxy
Setup Nginx or Apache for production:

```nginx
server {
    listen 80;
    server_name yourdomain.com;

    location / {
        proxy_pass http://localhost:3000;
    }

    location /api {
        proxy_pass http://localhost:5000;
    }

    location /ai {
        proxy_pass http://localhost:5001;
    }
}
```

### 3. Enable HTTPS
Always use SSL/TLS in production.

### 4. Monitor Services
```bash
# Check logs
docker-compose logs -f

# Monitor container stats
docker stats
```

### 5. Setup Backups
- Database backups (if applicable)
- Configuration backups
- Code repository backups

### 6. Update Dependencies
Regularly update dependencies for security:
```bash
# Frontend
npm update

# Backend
npm update

# Python
pip install --upgrade -r requirements.txt
```

---

## Scaling Considerations

### Horizontal Scaling
- Load balancer (Nginx, HAProxy, ALB)
- Multiple backend instances
- Caching layer (Redis)

### Vertical Scaling
- Larger compute instances
- More memory/CPU
- Database optimization

### Database
- Add persistent database (PostgreSQL, MongoDB)
- Connection pooling
- Regular backups

---

## Performance Optimization

### Frontend
- Minify and compress assets
- Enable gzip compression
- HTTP/2 support
- CDN for static files

### Backend
- Connection pooling
- Caching strategies
- Rate limiting
- Compression middleware

### Python AI Service
- Model caching
- Request batching
- Response compression
- Load balancing between replicas

---

## Security Checklist

- [ ] Environment variables configured securely
- [ ] HTTPS/TLS enabled
- [ ] API rate limiting implemented
- [ ] Input validation enabled
- [ ] CORS properly configured
- [ ] No hardcoded secrets
- [ ] Regular security updates
- [ ] Firewall rules configured
- [ ] Monitoring and logging enabled
- [ ] Backup strategy in place

---

## Troubleshooting Deployment

### Services won't start
1. Check logs: `docker-compose logs`
2. Verify environment variables
3. Check port availability
4. Verify API keys

### Connection issues
1. Check network connectivity
2. Verify service URLs in env vars
3. Check firewall rules
4. Test with curl

### Performance issues
1. Monitor resource usage
2. Check API quotas
3. Optimize database queries
4. Enable caching

---

## Support & Resources

- **Docker Docs**: https://docs.docker.com
- **Azure Docs**: https://docs.microsoft.com/azure
- **AWS Docs**: https://docs.aws.amazon.com
- **Heroku Docs**: https://devcenter.heroku.com
- **Groq Docs**: https://console.groq.com/docs

---

## Next Steps

1. Choose deployment platform
2. Follow platform-specific steps
3. Configure environment variables
4. Test thoroughly
5. Monitor in production
6. Scale as needed

Good luck with your deployment! 🚀
