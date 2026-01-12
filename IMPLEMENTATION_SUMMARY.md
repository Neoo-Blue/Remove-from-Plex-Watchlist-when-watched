# Implementation Summary: Enhanced Plex Watchlist Cleanup

## Changes Made

### 1. **Purge All Watchlist Feature** ✅
Added a new `purge_watchlist()` function that removes ALL items from a user's watchlist regardless of watch status.

**Configuration:**
```yaml
purge_all_watchlist: false  # Set to true to remove entire watchlist
```

When enabled, the script will completely clear specified users' watchlists instead of checking for watched content.

---

### 2. **Interval Scheduling** ✅
Integrated APScheduler to enable automatic runs at configurable intervals.

**Configuration:**
```yaml
enable_scheduler: false  # Set to true for continuous scheduling
run_interval: 24  # Run every N hours (e.g., 24 = daily)
```

**Usage:**
- When `enable_scheduler: true` and `run_interval: 24`, the script runs every 24 hours automatically
- The script stays running in the background until you press `Ctrl+C`
- Perfect for server/container environments

---

### 3. **Docker & Docker Compose Support** ✅

#### New Files Created:
- **`Dockerfile`** - Containerizes the application with Python 3.11
- **`docker-compose.yml`** - Full configuration with all environment variables
- **`docker-entrypoint.sh`** - Bash script that generates config.yml from environment variables
- **`.dockerignore`** - Optimizes Docker build

#### Environment Variables (configured via docker-compose.yml):
```
PLEX_URL              - Plex server address
PLEX_API_KEY          - Plex authentication token
MOVIE_LIBRARY_NAME    - Movie library name(s)
TV_LIBRARY_NAME       - TV library name(s)
REMOVE_FROM_WATCHLIST - Enable/disable removal (true/false)
CHECK_MOVIES          - Check movies (true/false)
CHECK_TV_SHOWS        - Check TV shows (true/false)
ENABLE_SCHEDULER      - Enable scheduled runs (true/false)
RUN_INTERVAL          - Hours between runs (e.g., 24)
PURGE_ALL_WATCHLIST   - Purge entire watchlist (true/false)
USERS                 - Comma-separated usernames
USER_CREDENTIALS      - User credentials (optional, for non-admin users)
```

#### Quick Start:
```bash
docker-compose up -d
```

All configuration is done through `docker-compose.yml` - no need to edit Python files or config.yml!

---

## Updated Files

### RFPW.py
- Added imports: `time`, `os`, `APScheduler`
- Added `purge_watchlist()` function
- Modified `main()` to:
  - Support scheduler with `run_interval` and `enable_scheduler` config
  - Handle `purge_all_watchlist` mode
  - Wrap core logic in `run_cleanup()` function
  - Stay running when scheduler is enabled

### requirements.txt
- Added `apscheduler>=3.10.0` for scheduling support

### config.example.yml
- Added scheduler options:
  - `enable_scheduler: false`
  - `run_interval: 24`
  - `purge_all_watchlist: false`

### README.md
- Updated features list to include new capabilities
- Added comprehensive Docker/Docker Compose section
- Added "Scheduled/Continuous Runs" usage example
- Added "Purge All Watchlist" usage example

---

## Usage Examples

### Example 1: Docker Compose - Daily Cleanup (Recommended)
```yaml
# In docker-compose.yml
environment:
  PLEX_API_KEY: "your-token"
  ENABLE_SCHEDULER: "true"
  RUN_INTERVAL: "24"
  USERS: "Admin"
```
Run: `docker-compose up -d` - Runs automatically every 24 hours!

---

### Example 2: Docker Compose - Purge All Watchlist
```yaml
environment:
  PLEX_API_KEY: "your-token"
  PURGE_ALL_WATCHLIST: "true"
  USERS: "Admin,User1"
```
Run: `docker-compose up` - Removes all items from each user's watchlist

---

### Example 3: Traditional - Scheduled Runs
```yaml
# config.yml
enable_scheduler: true
run_interval: 12  # Every 12 hours
remove_from_watchlist: true
users: Admin
```
Run: `python RFPW.py` - Stays running, executes every 12 hours

---

### Example 4: Traditional - One-time Cleanup
```yaml
# config.yml
enable_scheduler: false
remove_from_watchlist: true
users: Admin
```
Run: `python RFPW.py` - Runs once and exits

---

## Benefits

✅ **No File Editing Required with Docker** - Everything via environment variables
✅ **Automatic Scheduling** - No need for cron jobs or scheduled tasks
✅ **Complete Watchlist Purge** - New purge_all_watchlist option
✅ **Container Ready** - Docker & Docker Compose support included
✅ **Backwards Compatible** - Traditional config.yml still works
✅ **Production Ready** - Logging configuration included

---

## Next Steps (Optional)

1. Test locally with `docker-compose up`
2. Deploy to your Docker host (Unraid, Synology, etc.)
3. Monitor with `docker-compose logs -f`
4. Adjust `RUN_INTERVAL` as needed for your workflow
