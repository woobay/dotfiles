#!/bin/bash


#version=0.32.4
file=/tmp/k9s.tar.gz
url="https://github.com/derailed/k9s/releases/download/v${version}/k9s_Darwin_amd64.tar.gz"

cleanup () {
  rm -rf "$file"
}
trap cleanup EXIT

mkdir -p ~/.local/bin
curl -Lo "$file" "$url" && tar xzf "$file" -C ~/.local/bin k9s
