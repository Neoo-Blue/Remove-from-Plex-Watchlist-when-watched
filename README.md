# 🎬 Plex Watchlist Cleaner 🧹

"Why are the movies and shows we watched still in our watch list? Can they not automatically be removed once we've watched them?"</br>
asked my spouse. Fair question.. Apparently Plex can only remove them if you watch them through Plex Movies or TV Shows. If you watch them through your own libraries they remain in watchlist.

This script automatically removes watched movies and/or TV shows from your Plex Watchlist.</br> 
Keep your watchlist clean and focused on content you haven't seen yet!

---

## ✨ Features
- 👥 **User Selection**: Manage watchlist for any user (requires login credentials)
- 🔎 **Finds and lists**: Retrieves your watchlist and lists movies and/or TV Shows you've already watched
- 🧹 **Watchlist Cleanup**: Removes watched content from Plex Watchlist
- 🗑️ **Purge Mode**: Option to remove ALL items from watchlist at once
- ⏰ **Scheduled Runs**: Configure to run automatically at set intervals
- 🐳 **Docker Support**: Fully containerized with docker-compose configuration
- ℹ️ **Dry run**: `remove_from_watchlist` flag for dry-run or actual removal

---

## 🛠️ Installation

### 1️⃣ Download the Script
```sh
git clone https://github.com/netplexflix/Remove-from-Plex-Watchlist-when-watched.git
cd Remove-from-Plex-Watchlist-when-watched
```
![#c5f015](https://placehold.co/15x15/c5f015/c5f015.png) Or simply download by pressing the green 'Code' button above and then 'Download Zip'.

### 2️⃣ Install Requirements
- Ensure you have [Python](https://www.python.org/downloads/) installed (`>=3.11` recommended)
- Open a Terminal in the script's directory
>[!TIP]
>Windows Users: <br/>
>Go to the script folder (where RFPW.py is).</br>
>Right mouse click on an empty space in the folder and click `Open in Windows Terminal`
- Install the required dependencies:
```sh
pip install -r requirements.txt
```
---

## ⚙️ Configuration

Rename `config.example.yml` to `config.yml` and update where necessary:

### Required
`plex_url:` http://localhost:32400 </br>
`plex_api_key:` [Where to find your plex Token](https://support.plex.tv/articles/204059436-finding-an-authentication-token-x-plex-token/) </br>
`movie_library_name:` e.g. "Movies, Movies4K" </br>
`tv_library_name:` e.g. "TV Shows, Anime" </br>

### Options
`remove_from_watchlist:` Set to `true` to enable removal. `false` for dry-run listing only  </br>
`check_movies:` whether or not to check movies </br>
`check_tv_shows:` whether or not to check TV Shows </br>
`enable_scheduler:` Set to `true` to run automatically at intervals </br>
`run_interval:` How often to run in hours (e.g., `24` = every 24 hours) </br>
`purge_all_watchlist:` Set to `true` to remove ALL items from watchlist (ignores watched status)

### Users
> [!IMPORTANT]
> For any user other than Admin, you'll need to provide the login credentials to edit the watchlist.

`users:` Enter a comma separated list of users to process. You can enter `Admin` for the admin account.</br>
`user_credentials:` Enter the name, username and password for each user (except Admin) you'd like to process.

---

## � Docker / Docker Compose (Recommended)

The easiest way to run this script is using Docker, which handles all dependencies automatically. Everything can be configured through environment variables without touching any files.

### Quick Start with Docker Compose

1. **Clone the repository:**
```sh
git clone https://github.com/netplexflix/Remove-from-Plex-Watchlist-when-watched.git
cd Remove-from-Plex-Watchlist-when-watched
```

2. **Update `docker-compose.yml` with your settings:**

Edit the `environment` section in `docker-compose.yml`:

```yaml
environment:
  PLEX_URL: "http://plex:32400"  # Your Plex server address
  PLEX_API_KEY: "your-plex-token-here"
  MOVIE_LIBRARY_NAME: "Movies"
  TV_LIBRARY_NAME: "TV Shows"
  REMOVE_FROM_WATCHLIST: "true"
  CHECK_MOVIES: "true"
  CHECK_TV_SHOWS: "true"
  ENABLE_SCHEDULER: "true"  # Enable automatic runs
  RUN_INTERVAL: "24"  # Run every 24 hours
  PURGE_ALL_WATCHLIST: "false"  # Set to true to clear entire watchlist
  USERS: "Admin"
```

3. **Run with Docker Compose:**

```sh
docker-compose up -d
```

The container will run automatically and keep running in the background. View logs with:
```sh
docker-compose logs -f plex-watchlist-cleanup
```

4. **Stop the container:**
```sh
docker-compose down
```

### Docker Compose with Multiple Users

If you want to process multiple users with credentials, add them via the `USER_CREDENTIALS` environment variable. Format is pipe-separated user definitions with colon-separated email and password:

```yaml
environment:
  USERS: "Admin,User1,User2"
  USER_CREDENTIALS: "User1:user1@example.com:password1|User2:user2@example.com:password2"
```

### Alternative: Mount Config File

Instead of using environment variables, you can mount your own `config.yml` file:

```yaml
volumes:
  - ./config.yml:/app/config.yml
```

---

## 🚀 Usage (Traditional)

Run the script with:
```sh
python RFPW.py
```

The script will run once and clean up the specified users' watchlists based on your configuration.

### Scheduled/Continuous Runs

To have the script run automatically at intervals, update your `config.yml`:

```yaml
enable_scheduler: true
run_interval: 24  # Run every 24 hours
```

Then run:
```sh
python RFPW.py
```

The script will stay running and execute your cleanup routine every 24 hours. Press `Ctrl+C` to stop.

### Purge All Watchlist

To remove **ALL** items from a user's watchlist (regardless of watch status), set:

```yaml
purge_all_watchlist: true
```

This is useful if you want to completely clear the watchlist without checking what's been watched.

> [!TIP]
> Windows users can create a batch file for quick launching:
> ```batch
> "C:\Path\To\Python\python.exe" "Path\To\Script\RFPW.py"
> pause
> ```


**Sample Output:**
```
Fetching movie watchlist... [██████████] 100%
Scanning 1500 movies... [██████░░░░] 60%

Watched Movies in Watchlist:
- The Matrix (1999)
- Inception (2010)

Watched TV Shows in Watchlist:
- Breaking Bad (2008)

Removing 3 items from watchlist... [██████████] 100%
```


---

## ⚠️ Need Help or have Feedback?
- Join the [Discord](https://discord.gg/VBNUJd7tx3).
- [Open an Issue](https://github.com/yourusername/Remove-from-Plex-Watchlist-when-watched/issues)  

Like this project? Give it a ⭐!  

[![Buy Me A Coffee](https://img.shields.io/badge/Support-%F0%9F%8D%BA-yellow)](https://buymeacoffee.com/neekokeen)
