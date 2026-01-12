#!/bin/bash

# Generate config.yml from environment variables
cat > config.yml << EOF
plex_url: ${PLEX_URL:-http://localhost:32400}
plex_api_key: ${PLEX_API_KEY}
movie_library_name: "${MOVIE_LIBRARY_NAME:-Movies}"
tv_library_name: "${TV_LIBRARY_NAME:-TV Shows}"
remove_from_watchlist: ${REMOVE_FROM_WATCHLIST:-true}
check_movies: ${CHECK_MOVIES:-true}
check_tv_shows: ${CHECK_TV_SHOWS:-true}

# Scheduler options
enable_scheduler: ${ENABLE_SCHEDULER:-false}
run_interval: ${RUN_INTERVAL:-24}
purge_all_watchlist: ${PURGE_ALL_WATCHLIST:-false}

users: ${USERS:-Admin}

EOF

# Add user credentials if provided
if [ -n "$USER_CREDENTIALS" ]; then
    echo "user_credentials:" >> config.yml
    echo "$USER_CREDENTIALS" | while IFS='|' read -r user creds; do
        IFS=':' read -r username password <<< "$creds"
        echo "  \"$user\":" >> config.yml
        echo "    username: \"$username\"" >> config.yml
        echo "    password: \"$password\"" >> config.yml
    done
fi

# Run the application
python RFPW.py
