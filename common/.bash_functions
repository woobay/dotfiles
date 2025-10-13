#!/bin/bash

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~

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
