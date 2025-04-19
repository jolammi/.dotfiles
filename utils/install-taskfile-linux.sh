#!/usr/bin/env bash
set -e

TASKFILE_PKG_VERSION="v3.42.1"
TMP_DIR=/tmp/taskfile_tmp

mkdir -p "$TMP_DIR"

# Download tarball and sha265sums
echo "Downloading taskfile tarball and checksum file.."
wget -q -P "$TMP_DIR" "https://github.com/go-task/task/releases/download/${TASKFILE_PKG_VERSION}/task_linux_amd64.tar.gz"
wget -q -P "$TMP_DIR" "https://github.com/go-task/task/releases/download/${TASKFILE_PKG_VERSION}/task_checksums.txt"

# Check sha256sum
#echo "Checking checksum"
cd "$TMP_DIR"
cat "$TMP_DIR"/task_checksums.txt | grep "task_linux_amd64.tar.gz" | sha256sum -c

tar -xzf task_linux_amd64.tar.gz

mkdir -p "$HOME"/bin
mv "$TMP_DIR"/task "$HOME"/bin
rm -rf "$TMP_DIR"

# completion
line='eval "$(task --completion zsh)"'
grep -qxF "$line" "$HOME/.zshrc" || echo "$line" >> "$HOME/.zshrc"
echo "reload zsh to use newest completions"
