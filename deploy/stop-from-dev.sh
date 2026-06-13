#!/bin/bash
#
# ============================================
# Stop the Jerney Blog Platform services on the EC2 instance
# Run this script on the EC2 instance to stop the application
# ============================================
set -e
echo "🛑 Stopping Jerney Blog Platform services..."
echo "============================================="
# Stop the PM2 processes
echo "📦 Stopping PM2 processes..."
pm2 stop all
pm2 delete all
echo "✅ every PM2 process stopped"


echo "🛑 Stopping Nginx..."
sudo systemctl stop nginx
echo "✅ Nginx stopped"

echo "🛑 Stopping PostgreSQL..."
sudo systemctl stop postgresql
echo "✅ PostgreSQL stopped"

echo "🛑 Verifying service statuses..."
sudo systemctl is-active --quiet nginx && echo "❌ Nginx is still running" || echo "✅ Nginx is stopped"
sudo systemctl is-active --quiet postgresql && echo "❌ PostgreSQL is still running" || echo "✅ PostgreSQL is stopped"
echo "✅ All services stopped successfully!"
