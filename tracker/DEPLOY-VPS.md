# Deploying Tracker to Your VPS

This guide walks you through getting the **tracker** app (frontend + API + SQLite) running on a Linux VPS.

---

## 1. What you need on the VPS

- **OS**: Linux (Ubuntu 22.04 LTS or similar).
- **Node.js**: v20 (LTS). Install via [NodeSource](https://github.com/nodesource/distributions) or your distro’s package manager.
- **Optional**: `nginx` (to serve the frontend and reverse‑proxy to the API), `certbot` (for HTTPS).

```bash
# Example (Ubuntu): Node 20
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
```

---

## 2. Get the code onto the VPS

**Option A – Git (recommended)**  
If the project is in a Git repo (GitHub/GitLab/etc.):

```bash
# On VPS
git clone https://github.com/YOUR_USER/tracker.git
cd tracker
```

**Option B – Upload from your PC**  
From your Windows machine (PowerShell), using SCP:

```powershell
# Replace YOUR_VPS_IP and /home/user with your VPS IP and path
scp -r e:\_root\tracker\client e:\_root\tracker\api user@YOUR_VPS_IP:/home/user/tracker/
```

Or use **rsync** (if available) to exclude `node_modules` and build artifacts:

```powershell
rsync -avz --exclude node_modules --exclude dist --exclude build e:\_root\tracker\ user@YOUR_VPS_IP:/home/user/tracker/
```

---

## 3. Backend (api) on the VPS

```bash
cd /home/user/tracker/api   # or your path
npm ci
```

**Environment variables**  
Create `.env` in `api`:

```env
DATABASE_URL="file:./prisma/dev.db"
PORT=4000
JWT_SECRET="your-long-random-secret-at-least-32-chars"
```

- Use a **strong random value** for `JWT_SECRET` in production.
- For SQLite, `file:./prisma/dev.db` is fine; use an absolute path if you run the app from another directory.

**Prisma**

```bash
npx prisma generate
npx prisma db push
```

**Run (for testing)**

The API already defines `build` and `start` scripts (`build: tsc`, `start: node dist/index.js`), so:

```bash
npm run build   # tsc → dist/
npm start       # node dist/index.js
```

For local iteration you can also use `npm run dev` (nodemon on `src/index.ts`).

Keep the process running under a process manager for production (see step 6).

---

## 4. Frontend (client) on the VPS

**Set the API URL for production**  
When building, the frontend must know the public URL of your API (e.g. `https://api.yourdomain.com/graphql` or `https://yourdomain.com/api/graphql`).

Create `.env.production` in `client` (or set the variable before `npm run build`):

```env
VITE_API_URL=https://your-api-domain.com/graphql
```

Replace with your real API URL. If the API is on the same domain (e.g. behind nginx at `/graphql`), use e.g. `https://yourdomain.com/graphql`.

**Build**

```bash
cd /home/user/tracker/client
npm ci
npm run build
```

Output will be in `dist/`. You’ll serve these static files with nginx (or another web server).

---

## 5. Serve the app with Nginx (recommended)

Install nginx (and certbot if you want HTTPS):

```bash
sudo apt update
sudo apt install nginx certbot python3-certbot-nginx
```

**Example config** (`/etc/nginx/sites-available/tracker`):

- Replace `yourdomain.com` and `/home/user/tracker` with your domain and paths.
- This serves the frontend and proxies `/graphql` to the API on `localhost:4000`.

```nginx
server {
    listen 80;
    server_name yourdomain.com;

    root /home/user/tracker/client/dist;
    index index.html;
    location / {
        try_files $uri $uri/ /index.html;
    }

    location /graphql {
        proxy_pass http://127.0.0.1:4000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Enable and reload:

```bash
sudo ln -s /etc/nginx/sites-available/tracker /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx
```

Then set in the frontend:

```env
VITE_API_URL=https://yourdomain.com/graphql
```

Rebuild the frontend after changing `VITE_API_URL`.

**HTTPS with Let’s Encrypt**

```bash
sudo certbot --nginx -d yourdomain.com
```

---

## 6. Keep the API running (process manager)

Use **PM2** so the API restarts on crash and on reboot:

```bash
sudo npm install -g pm2
cd /home/user/tracker/api
pm2 start dist/index.js --name tracker-api
pm2 save
pm2 startup   # follow the command it prints to enable on boot
```

Adjust the start command if your entry file is different (e.g. `src/index.ts` with ts-node).

---

## 7. Checklist

| Step | Action |
|------|--------|
| 1 | Install Node 20 and (optionally) nginx + certbot on VPS |
| 2 | Clone or upload project to VPS |
| 3 | In `api`: `.env` with `DATABASE_URL`, `PORT`, `JWT_SECRET`; run `npm ci`, `prisma generate`, `prisma db push` |
| 4 | In `client`: set `VITE_API_URL` (e.g. in `.env.production`), then `npm ci` and `npm run build` |
| 5 | Configure nginx to serve `client/dist` and proxy `/graphql` to `http://127.0.0.1:4000` |
| 6 | Run API with PM2 (or similar) and enable startup on boot |
| 7 | Point your domain’s DNS to the VPS and (optional) run certbot for HTTPS |

---

## 8. Optional: Docker

The repo includes a Dockerfile for the frontend. It expects a `build` output directory and a `start` script; by default Vite outputs to `dist` and there may be no `start` script. For a quick path, use the manual build + nginx approach above. If you want to use Docker later, we can align the Dockerfile with `dist` and add a small static server.

---

## Troubleshooting

- **Frontend can’t reach API**: Ensure `VITE_API_URL` was set **before** `npm run build`, and that nginx (or your setup) proxies the same path as in `VITE_API_URL`.
- **CORS**: If you serve frontend and API from the same domain (e.g. nginx proxy), CORS is usually not an issue. If they differ, configure CORS in the Express app in `api`.
- **502 Bad Gateway**: API not running or not on the port nginx is proxying to. Check `pm2 status` or your process manager and `curl http://127.0.0.1:4000/graphql`.
