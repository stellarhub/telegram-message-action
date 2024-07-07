#!/bin/bash

# This script helps to find chat IDs that the Bot is added

# Check out the repo https://github.com/barrychum/keyvault.git
# I created a script to secure your API key / token
# which you can integrate into your scripts
# BOT_TOKEN=$(get-keyvalue.sh "my key")
BOT_TOKEN="your telegram token"

# Function to get updates and extract chat details
get_chat_ids() {
    # Get updates from the bot
    response=$(curl -s "https://api.telegram.org/bot${BOT_TOKEN}/getUpdates")

    # Extract chat IDs using jq and remove nulls
    chat_ids=$(echo "$response" | jq -r '.result[] | select(.message.chat.id != null) | .message.chat.id')

    # Print unique chat IDs
    unique_ids=$(echo "$chat_ids" | sort | uniq)

    printf "\n"

    for id in $unique_ids; do
        if [ "$id" -lt 0 ]; then
            chat_message=$(echo "$response" | jq -r --arg id "$id" '.result[] | select(.message.chat.id == ($id | tonumber)) | .message.chat | {id, title, type}')
            chat_id=$(echo "$chat_message" | jq -r '.id')
            chat_title=$(echo "$chat_message" | jq -r '.title // empty' | uniq)
            chat_type=$(echo "$chat_message" | jq -r '.type' | uniq)
            printf "chat id : %s\n" "$chat_id"
            printf "title   : %s\n" "$chat_title" 
            printf "type    : %s\n" "$chat_type"
        else
            chat_message=$(echo "$response" | jq -r --arg id "$id" '.result[] | select(.message.chat.id == ($id | tonumber)) | .message.chat | {id, type}')
            chat_id=$(echo "$chat_message" | jq -r '.id' | uniq)
            chat_type=$(echo "$chat_message" | jq -r '.type' | uniq)
            printf "chat id : %s\n" "$chat_id"
            printf "type    : %s\n" "$chat_type"
        fi
        printf "\n"
    done
}

# Check if jq is installed
if ! command -v jq &>/dev/null; then
    echo "jq could not be found. Please install jq to use this script."
    exit
fi

# Run the function
get_chat_ids
