# Devsecops Three-Tier Application - Error Documentation

## Error Summary

When running `docker compose up`, the application failed to serve web content. Accessing `http://localhost:80` resulted in:

```
curl: (56) Recv failure: Connection reset by peer
```

## Root Cause

### Problem: Non-root User Binding to Privileged Port

The error occurred because:

1. **Linux privileged ports**: Ports below 1024 (including port 80) require root/CAP_NET_BIND_SERVICE privileges
2. **Dockerfile configuration**: The frontend Dockerfile (`frontend/Dockerfile:28`) ran nginx as non-root user:
   ```dockerfile
   USER nginx
   ```
3. **Port mismatch**: The nginx config listened on port 80 but the container couldn't bind to it as unprivileged user

### Why This Happened

- The original Dockerfile was designed for security (running as non-root)
- But nginx in Docker needs either:
  - Root privileges to bind to port < 1024
  - Or configure nginx to use a high port (8080+) and map it externally via docker-compose

## Solution

### Changes Made

1. **Updated nginx port** (`frontend/nginx.conf`):
   ```nginx
   listen 8080;  # Changed from port 80
   ```

2. **Updated Dockerfile expose** (`frontend/Dockerfile`):
   ```dockerfile
   EXPOSE 8080  # Changed from 80
   ```

3. **Docker compose mapping** (`docker-compose.yaml`):
   ```yaml
   ports:
     - "80:8080"  # Maps host port 80 to container port 8080
   ```

This solution:
- Keeps non-root security (nginx runs as `nginx` user)
- Uses unprivileged port 8080 inside container
- Maps host port 80 to container port 8080 externally

## Alternative Solutions (Not Used)

### Option 1: Use nginx:alpine with root (Less Secure)
```dockerfile
# Run as root - NOT RECOMMENDED
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### Option 2: Linux Capability
```yaml
# In docker-compose.yaml
security_opt:
  - no-new-privileges:true
cap_add:
  - NET_BIND_SERVICE
```

### Option 3: sysctl for unprivileged ports
```bash
# On host: sysctl -w net.ipv4.ip_unprivileged_port_start=80
```

We chose Option 3 (port mapping) as it's the most secure and portable solution.

## Verification

After fix:
```bash
$ curl http://localhost:80
<!DOCTYPE html>...
$ curl http://localhost/api/posts
[]
```

All services running:
```bash
$ docker ps
jerney-frontend   Up    80/tcp -> 0.0.0.0:80->8080/tcp
jerney-backend    Up    5000/tcp
jerney-database   Up    5432/tcp (healthy)
```

## Other Issues Encountered

### 1. Database Volume with Wrong Credentials

**Error**: `password authentication failed for user "jerney_user"`

**Cause**: PostgreSQL volume persisted old database with different user credentials

**Solution**: 
```bash
docker compose down -v  # Remove volumes
docker compose up -d     # Recreate
```

### 2. Username Mismatch

**Error**: `role "jerney_user" does not exist`

**Cause**: PostgreSQL environment `POSTGRES_USER: jerney-user` (hyphen) vs backend `DB_USER: jerney_user` (underscore)

**Solution**: Fixed username to use consistent `jerney_user` (underscore)

## Security Note

The current fix maintains security best practices:
- nginx runs as non-root user
- Backend uses read-only root filesystem
- security_opt prevents privilege escalation
- Non-essential capabilities removed