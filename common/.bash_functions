#!/bin/bash

BRIGHTNESS_STATE_FILE="$HOME/.cache/brightness_mode"
BRIGHTNESS_DAY=100
BRIGHTNESS_NIGHT=30

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~

kube-ctx() {
    contexts=$(kubectl config get-contexts --output=name)
    selected_context=$(echo "$contexts" | fzf --prompt="Select Kubernetes context: ")
    
    if [[ -n "$selected_context" ]]; then
        kubectl config use-context "$selected_context"
        echo "Switched to context: $selected_context"
    else
        echo "No context selected."
    fi
}

gcloud-ctx() {
projects=$(gcloud projects list --format="value(projectId)" | grep -v '^sys-')
selected_project=$(echo "$projects" | fzf)

if [[ -n "$selected_project" ]]; then
        # Set the selected project as the active project
        gcloud config set project "$selected_project"
        echo "Switched to project: $selected_project"
else
        echo "No project selected."
fi
}

update-go() {
    curl -OL https://golang.org/dl/go$1.darwin-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go$1.darwin-amd64.tar.gz
    go version
}

brightness-toggle() {
    current=$(cat "$BRIGHTNESS_STATE_FILE" 2>/dev/null || echo "night")
    if [ "$current" = "day" ]; then
        target=$BRIGHTNESS_NIGHT
        label="🌙 Night mode ($BRIGHTNESS_NIGHT%)"
        next="night"
    else
        target=$BRIGHTNESS_DAY
        label="☀️  Day mode ($BRIGHTNESS_DAY%)"
        next="day"
    fi

    ddcutil detect --brief | grep -oP '(?<=Display )\d+' | while read -r d; do
        ddcutil setvcp 10 $target --display "$d"
    done

    echo "$next" > "$BRIGHTNESS_STATE_FILE"
    echo "$label"
}

