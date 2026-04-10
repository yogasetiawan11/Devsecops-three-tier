# 🛤️ Jerney - DevSecOps Three-Tier Blog Platform

![Tech Stack](https://img.shields.io/badge/React-18-61DAFB?style=flat-square&logo=react)
![Tech Stack](https://img.shields.io/badge/Node.js-20-339933?style=flat-square&logo=node.js)
![Tech Stack](https://img.shields.io/badge/PostgreSQL-16-4169E1?style=flat-square&logo=postgresql)

A modern, secure, and scalable three-tier blog platform built with **React**, **Node.js/Express**, and **PostgreSQL**. This project demonstrates DevSecOps best practices including containerization, security hardening, infrastructure automation, and continuous integration/deployment patterns.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Features](#features)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Running with Docker Compose](#running-with-docker-compose)
- [Running Locally](#running-locally)
- [API Documentation](#api-documentation)
- [Security Features](#security-features)
- [Deployment](#deployment)
- [Development](#development)
- [Troubleshooting](#troubleshooting)

---

## 🎯 Overview

**Jerney** is a full-stack blog platform that showcases modern DevSecOps practices. It features:
- A responsive React frontend with a smooth user experience
- A robust Node.js/Express REST API backend
- PostgreSQL database with security-first configuration
- Docker containerization with multi-stage builds
- Security hardening across all layers
- Nginx reverse proxy with SSL/TLS support
- Infrastructure automation scripts for AWS EC2 deployment

---

## 🏗️ Architecture

The application follows a **three-tier architecture**:

```
┌─────────────────────────────────────────────────────────┐
│                    CLIENT LAYER (Browser)                │
├─────────────────────────────────────────────────────────┤
│                   Frontend (React 18)                     │
│             Vite + Nginx (Port 80/443)                   │
├─────────────────────────────────────────────────────────┤
│                 Application Layer                        │
│            Backend API (Node.js/Express)                │
│              (Port 5000, Internal Only)                  │
├─────────────────────────────────────────────────────────┤
│                   Data Layer                             │
│          PostgreSQL Database (Port 5432)                │
│              (Internal Network Only)                     │
└─────────────────────────────────────────────────────────┘
```

All services communicate over a secure internal Docker network with:
- **No external database access** - PostgreSQL only accessible from backend
- **No root users** - All processes run as non-root
- **Read-only filesystems** - Where applicable
- **Capability dropping** - Removes unnecessary Linux capabilities

---

## 💻 Tech Stack

### Frontend
- **React** 18.3.1 - UI framework
- **Vite** 5.4.3 - Fast build tool
- **React Router** 6.26.2 - Client-side routing
- **Axios** 1.7.7 - HTTP client
- **React Icons** 5.3.0 - Icon library
- **React Hot Toast** 2.4.1 - Notifications
- **Date-fns** 3.6.0 - Date utilities

### Backend
- **Node.js** 20.x - Runtime
- **Express** 4.21.0 - Web framework
- **PostgreSQL** 16 - Database driver (pg 8.13.0)
- **CORS** 2.8.5 - Cross-origin support
- **dotenv** 16.4.5 - Environment variables

### DevOps & Infrastructure
- **Docker** - Containerization
- **Docker Compose** - Orchestration
- **Nginx** 1.27 - Web server & reverse proxy
- **Alpine Linux** - Lightweight base images
- **PM2** - Process manager
- **Bash** - Infrastructure automation

---

## ✨ Features

### Blog Functionality
- ✅ Create, read, update, delete (CRUD) blog posts
- ✅ Add and manage comments on posts
- ✅ Real-time updates with toast notifications
- ✅ Responsive design for mobile/tablet/desktop
- ✅ Date formatting and localization

### Security
- ✅ Non-root container execution
- ✅ Read-only filesystems
- ✅ Capability dropping in Docker
- ✅ Environment variable management
- ✅ CORS configuration
- ✅ dumb-init for proper signal handling
- ✅ Principle of least privilege

### DevOps
- ✅ Multi-stage Docker builds (optimized images)
- ✅ Docker Compose orchestration
- ✅ Health checks
- ✅ Automated EC2 setup script
- ✅ Nginx reverse proxy configuration
- ✅ PM2 process management

---

## 📁 Project Structure

```
.
├── docker-compose.yaml           # Main orchestration file
├── .checkov.yaml                 # Security scanning config
├── README.md                      # This file
│
├── frontend/                      # React application
│   ├── Dockerfile                 # Frontend container image
│   ├── nginx.conf                 # Nginx configuration
│   ├── vite.config.js             # Vite build config
│   ├── index.html                 # HTML entry point
│   ├── package.json               # Dependencies
│   └── src/
│       ├── main.jsx               # React entry point
│       ├── App.jsx                # Main component
│       ├── index.css              # Global styles
│       ├── api.js                 # API client
│       ├── components/            # Reusable components
│       │   ├── Navbar.jsx
│       │   ├── PostCard.jsx
│       │   ├── CommentSection.jsx
│       │   └── ConfirmModal.jsx
│       └── pages/                 # Page components
│           ├── Home.jsx
│           ├── CreatePost.jsx
│           ├── EditPost.jsx
│           └── PostDetail.jsx
│
├── backend/                       # Express API server
│   ├── Dockerfile                 # Backend container image
│   ├── package.json               # Dependencies
│   └── src/
│       ├── index.js               # Server entry point
│       ├── db.js                  # Database connection
│       ├── posts.js               # Posts routes
│       └── comments.js            # Comments routes
│
└── deploy/                        # Deployment utilities
    ├── setup.sh                   # EC2 setup script
    └── jerney-nginx.conf          # Production Nginx config
```

---

## 📦 Prerequisites

### For Docker Compose (Recommended)
- **Docker** 20.10+
- **Docker Compose** 2.0+
- Git

### For Local Development
- **Node.js** 20.x+
- **npm** 10.x+
- **PostgreSQL** 15+
- **Nginx** (optional, for frontend)

### For AWS EC2 Deployment
- AWS EC2 instance (Ubuntu 22.04 LTS or later)
- SSH access to the instance
- 2GB+ RAM, 20GB+ storage

---

## 🚀 Quick Start

### Option 1: Docker Compose (Easiest)

1. **Clone or download the project**
   ```bash
   cd Devsecops-three-tier
   ```

2. **Create `.env` file** in the project root:
   ```bash
   DB_USER=jerney_user
   DB_PASSWORD=secure_password_here
   DB_NAME=jerney_db
   ```

3. **Start all services**
   ```bash
   docker-compose up -d
   ```

4. **Access the application**
   - Frontend: http://localhost
   - Backend API: http://localhost:5000

5. **View logs**
   ```bash
   docker-compose logs -f
   ```

6. **Stop services**
   ```bash
   docker-compose down
   ```

---

## 🐳 Running with Docker Compose

### Services Overview

**Database (PostgreSQL)**
- Container: `db-jerney0`
- Port: 5432 (internal only)
- Volume: `pgdata` for persistence
- Security: Non-root, capability dropped, read-only tmpfs

**Backend (Node.js/Express)**
- Container: `backend-jerney0`
- Port: 5000 (internal only, exposed to frontend)
- Security: Non-root, read-only filesystem, capability dropped
- Health check: GET `/api/health`

**Frontend (React/Nginx)**
- Container: `frontend-jerney0`
- Port: 80 (public, http://localhost)
- Built with Vite for optimized production bundle
- Security: Running as nginx user

### Common Docker Compose Commands

```bash
# Start all services
docker-compose up -d

# View running services
docker-compose ps

# View logs
docker-compose logs -f                    # All services
docker-compose logs -f backend            # Specific service

# Rebuild images
docker-compose build

# Stop services (keep volumes)
docker-compose stop

# Remove everything
docker-compose down -v

# Access bash in a container
docker-compose exec backend sh
docker-compose exec database psql -U $DB_USER -d $DB_NAME
```

### Environment Variables

Create a `.env` file in the project root:

```env
# Database
DB_USER=jerney_user              # PostgreSQL username
DB_PASSWORD=your_secure_password # PostgreSQL password
DB_NAME=jerney_db                # Database name

# Backend (optional, set in docker-compose.yaml)
PORT=5000
```

---

## 💻 Running Locally

### Backend Setup

1. **Navigate to backend**
   ```bash
   cd backend
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Create `.env` file** in backend directory:
   ```env
   PORT=5000
   DB_USER=jerney_user
   DB_PASSWORD=password
   DB_HOST=localhost
   DB_PORT=5432
   DB_NAME=jerney_db
   ```

4. **Start backend**
   ```bash
   npm run dev    # Development with hot reload
   # or
   npm start      # Production
   ```

5. **Backend runs at**: http://localhost:5000

### Frontend Setup

1. **Navigate to frontend**
   ```bash
   cd frontend
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Start development server**
   ```bash
   npm run dev
   ```

4. **Frontend runs at**: http://localhost:5173 (Vite default)

5. **Build for production**
   ```bash
   npm run build      # Creates dist/ folder
   npm run preview    # Preview production build
   ```

### Database Setup (PostgreSQL)

```bash
# Connect to PostgreSQL
psql -U postgres

# In psql shell:
CREATE USER jerney_user WITH PASSWORD 'your_password';
CREATE DATABASE jerney_db OWNER jerney_user;
GRANT ALL PRIVILEGES ON DATABASE jerney_db TO jerney_user;
\connect jerney_db
GRANT ALL ON SCHEMA public TO jerney_user;
```

---

## 🔌 API Documentation

### Base URL
- Docker: `http://backend:5000` (internal)
- Local: `http://localhost:5000`
- Production: `https://yourdomain.com/api`

### Endpoints

#### Health Check
```
GET /api/health
```
Response:
```json
{
  "status": "ok",
  "message": "Jerney API is vibing ✨"
}
```

#### Posts

**Get all posts**
```
GET /api/posts
```

**Get single post**
```
GET /api/posts/:id
```

**Create post**
```
POST /api/posts
Content-Type: application/json

{
  "title": "My First Post",
  "content": "This is the content...",
  "author": "John Doe"
}
```

**Update post**
```
PUT /api/posts/:id
Content-Type: application/json

{
  "title": "Updated Title",
  "content": "Updated content..."
}
```

**Delete post**
```
DELETE /api/posts/:id
```

#### Comments

**Get comments for post**
```
GET /api/posts/:postId/comments
```

**Create comment**
```
POST /api/comments
Content-Type: application/json

{
  "post_id": 1,
  "author": "Jane Doe",
  "content": "Great post!"
}
```

**Delete comment**
```
DELETE /api/comments/:id
```

---

## 🔒 Security Features

### Container Security
- **Non-root users**: All processes run as non-root (appuser/nginx)
- **Read-only filesystems**: Backend has read-only root filesystem
- **Capability dropping**: `cap_drop: ALL` removes unnecessary Linux capabilities
- **No new privileges**: `security_opt: no-new-privileges:true`
- **Signal handling**: dumb-init ensures proper PID 1 behavior

### Network Security
- **Internal network**: Database only accessible from backend
- **No exposed ports**: PostgreSQL and backend not exposed to host
- **CORS configuration**: Controlled cross-origin requests
- **Bridge network**: Isolated from host network

### Multi-stage Docker Builds
- Reduces final image size
- Excludes build dependencies from production
- Cleaner separation of concerns

### Code Security
- Environment variables for sensitive data (no hardcoded secrets)
- HTTPS-ready Nginx configuration
- Proper error handling and validation
- Dependency vulnerabilities managed

### Checkov Scanning
- Configuration: `.checkov.yaml`
- Scans Terraform infrastructure code
- Identifies IaC misconfigurations
- Exceptions documented for intentional choices

---

## 🌍 Deployment

### AWS EC2 Deployment

The `deploy/setup.sh` script automates deployment to AWS EC2:

1. **Launch EC2 instance**
   - OS: Ubuntu 22.04 LTS
   - Instance type: t3.small or larger
   - Storage: 20GB+ EBS volume
   - Security group: Allow ports 22, 80, 443

2. **Transfer project files**
   ```bash
   scp -r ./Devsecops-three-tier ec2-user@your-instance-ip:~/Jerney
   ```

3. **Run setup script via SSH**
   ```bash
   ssh ec2-user@your-instance-ip
   bash ~/Jerney/deploy/setup.sh
   ```

4. **Features of setup.sh**
   - Updates system packages
   - Installs Node.js 20.x, PostgreSQL, Nginx
   - Configures PostgreSQL with credentials
   - Builds and optimizes frontend
   - Serves frontend via Nginx
   - Starts backend with PM2
   - Enables auto-restart on reboot
   - Provides access information

5. **Access your blog**
   ```
   http://<your-ec2-public-ip>
   ```

### Production Configuration

**Nginx** (`deploy/jerney-nginx.conf`):
- Reverse proxy for frontend and backend
- SSL/TLS ready
- Gzip compression
- Security headers
- Performance optimization

**PM2** Process Manager:
```bash
pm2 status          # View processes
pm2 logs            # View application logs
pm2 restart all     # Restart services
pm2 saveall         # Save startup script
pm2 startup         # Enable auto-start on reboot
```

---

## 👨‍💻 Development

### Frontend Development

```bash
cd frontend

# Install dependencies
npm install

# Start dev server with hot reload
npm run dev

# Build for production
npm run build

# Preview production build locally
npm run preview

# Lint code
npm run lint
```

**Key files:**
- `src/App.jsx` - Main component
- `src/api.js` - Backend API client
- `src/pages/` - Page components
- `src/components/` - Reusable components
- `vite.config.js` - Build configuration

### Backend Development

```bash
cd backend

# Install dependencies
npm install

# Start with hot reload (nodemon)
npm run dev

# Start production server
npm start

# Lint code
npm run lint
```

**Key files:**
- `src/index.js` - Server setup and middleware
- `src/db.js` - Database connection and initialization
- `src/posts.js` - Posts routes and handlers
- `src/comments.js` - Comments routes and handlers

### Database Management

```bash
# Connect to database
docker-compose exec database psql -U jerney_user -d jerney_db

# Useful SQL commands (in psql):
\dt                    # List tables
\d table_name          # Describe table
\l                     # List databases
\q                     # Quit

# View container logs
docker-compose logs database
```

### Code Quality

```bash
# Frontend linting
cd frontend && npm run lint

# Backend linting
cd backend && npm run lint

# Security scanning (requires Checkov)
checkov -d . -f .checkov.yaml
```

---

## 🛠️ Troubleshooting

### Docker Issues

**Port 80 already in use**
```bash
# Find process using port 80
sudo lsof -i :80
# Kill the process or change port in docker-compose.yaml
```

**Container won't start**
```bash
# View logs
docker-compose logs [service-name]

# Rebuild images
docker-compose build --no-cache
```

**Database connection refused**
```bash
# Check database is running
docker-compose ps database

# Verify environment variables
docker-compose config | grep DB_

# Check backend can access database
docker-compose exec backend ping database
```

### Frontend Issues

**Blank page or 404 errors**
- Clear browser cache
- Verify backend is running: `curl http://localhost:5000/api/health`
- Check browser console for errors

**API calls failing**
- Ensure backend is running
- Check CORS settings in `backend/src/index.js`
- Verify API URLs in `frontend/src/api.js`

### Backend Issues

**Database initialization fails**
- Ensure PostgreSQL is running: `docker-compose ps database`
- Check environment variables in `.env`
- Verify database user has correct permissions

**Port 5000 already in use**
- Change PORT in `.env` or docker-compose.yaml
- Or kill the process: `lsof -i :5000`

### Common Errors

| Error | Solution |
|-------|----------|
| `ECONNREFUSED localhost:5000` | Backend not running. Run `npm run dev` in backend/ |
| `ENOENT: no such file or directory` | Missing `.env` file. Create with DB credentials |
| `Cannot GET /` | Frontend not running. Check Nginx in docker-compose logs |
| `relation "posts" does not exist` | Database not initialized. Check db.js |

---

## 📝 Notes

- All sensitive data (DB password, API keys) should be in `.env` never committed to Git
- Production deployments should use HTTPS/SSL certificates
- PostgreSQL password should be strong (20+ characters, mixed case, numbers, symbols)
- Regular backups of PostgreSQL data recommended
- Monitor PM2 logs on production for errors
- Consider setting up monitoring and alerting for production

---

## 📄 License

This project is provided as-is for educational and DevSecOps demonstration purposes.

---

## 🤝 Support

For issues and questions:
1. Check the [Troubleshooting](#troubleshooting) section
2. Review Docker and application logs
3. Verify `.env` configuration
4. Ensure all prerequisites are installed

---

**Happy blogging with Jerney!** 🛤️✨