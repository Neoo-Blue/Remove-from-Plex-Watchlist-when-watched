# Quick Start Guide

## 🐳 Recommended: Docker Compose (Easiest)

### Step 1: Edit docker-compose.yml
Open `docker-compose.yml` and update these lines:

```yaml
environment:
  PLEX_URL: "http://your-plex-server:32400"  # Change to your Plex URL
  PLEX_API_KEY: "your-api-key-here"  # Your Plex token
  ENABLE_SCHEDULER: "true"  # Enable automatic runs
  RUN_INTERVAL: "24"  # Run every 24 hours
```

[Find your Plex API Key](https://support.plex.tv/articles/204059436-finding-an-authentication-token-x-plex-token/)

### Step 2: Run
```bash
docker-compose up -d
```

### Step 3: View Logs
```bash
docker-compose logs -f plex-watchlist-cleanup
```

### Step 4: Stop
```bash
docker-compose down
```

That's it! 🎉

---

## 🐍 Traditional: Python Script

### Step 1: Install Dependencies
```bash
pip install -r requirements.txt
```

### Step 2: Create Config
```bash
cp config.example.yml config.yml
```

### Step 3: Edit config.yml
```yaml
plex_url: http://localhost:32400
plex_api_key: YOUR_PLEX_API_KEY
enable_scheduler: true
run_interval: 24
```

### Step 4: Run
```bash
python RFPW.py
```

---

## ⚙️ Configuration Options

| Setting | Type | Example | Description |
|---------|------|---------|-------------|
| `PLEX_URL` | URL | `http://localhost:32400` | Your Plex server address |
| `PLEX_API_KEY` | String | `abc123xyz` | Plex authentication token |
| `MOVIE_LIBRARY_NAME` | String | `"Movies, Movies4K"` | Movie library name(s), comma-separated |
| `TV_LIBRARY_NAME` | String | `"TV Shows"` | TV library name(s), comma-separated |
| `REMOVE_FROM_WATCHLIST` | Boolean | `true` or `false` | Enable actual removal (false = dry-run) |
| `CHECK_MOVIES` | Boolean | `true` or `false` | Check movies |
| `CHECK_TV_SHOWS` | Boolean | `true` or `false` | Check TV shows |
| `ENABLE_SCHEDULER` | Boolean | `true` or `false` | Enable automatic scheduling |
| `RUN_INTERVAL` | Number | `24` | Hours between runs |
| `PURGE_ALL_WATCHLIST` | Boolean | `true` or `false` | Remove ALL items (ignores watch status) |
| `USERS` | String | `"Admin,User1"` | Comma-separated usernames |

---

## 🔧 Common Use Cases

### Use Case 1: Daily Cleanup (Runs Every 24 Hours)
```yaml
ENABLE_SCHEDULER: "true"
RUN_INTERVAL: "24"
REMOVE_FROM_WATCHLIST: "true"
```

### Use Case 2: Dry-Run (See What Would Be Removed)
```yaml
REMOVE_FROM_WATCHLIST: "false"
```

### Use Case 3: Purge Entire Watchlist Once
```yaml
ENABLE_SCHEDULER: "false"
PURGE_ALL_WATCHLIST: "true"
```

### Use Case 4: Process Multiple Users
```yaml
USERS: "Admin,User1,User2"
USER_CREDENTIALS: "User1:user1@example.com:pass1|User2:user2@example.com:pass2"
```

### Use Case 5: Run Every Hour
```yaml
ENABLE_SCHEDULER: "true"
RUN_INTERVAL: "1"
```

---

## 🆘 Troubleshooting

### Script won't start
- Check `PLEX_API_KEY` is correct
- Verify `PLEX_URL` is accessible
- Check `MOVIE_LIBRARY_NAME` and `TV_LIBRARY_NAME` match your library names exactly

### Items not being removed
- Set `REMOVE_FROM_WATCHLIST: "false"` first to see what would be removed
- Check if items are actually marked as watched in Plex

### Docker container keeps restarting
- Check logs: `docker-compose logs plex-watchlist-cleanup`
- Verify all required environment variables are set

### Credentials not working
- Format: `User1:email@example.com:password`
- Use `USER_CREDENTIALS: "User1:email:pass|User2:email:pass"`
- Make sure emails/passwords are correct

---

## 📊 Example Log Output

```
==================================================
Processing Admin's watchlist...
Processing Admin account...

Fetching movie watchlist for Admin...
Processing |██████████| 100.0% (25/25)

Scanning 1500 movies in Movies library for Admin...
Processing |████░░░░░░| 45.3% (680/1500)

Watched Movies in Admin's Watchlist:
 - The Matrix (1999)
 - Inception (2010)

Removing 2 movies from Admin's watchlist...
Removing movies from Admin's watchlist |██████████| 100.0% (2/2)

Summary:
Total movies removed from watchlists: 2
Total TV shows removed from watchlists: 0
==================================================
```

---

For more details, see [README.md](README.md) or [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md)
