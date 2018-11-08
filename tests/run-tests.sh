#!/bin/sh

# Functions

print_error () {
    echo "Error: $1"
    exit 1
}

# Install

tools/install.sh

# Tests

[ -d "$HOME/.effix" ]    || print_error ".effix dir is not found"
[ -d "$HOME/bin" ]       || print_error "bin dir is not found"
[ -L "$HOME/bin/effix" ] || print_error "effix symlink is not found"

# Execute

mkdir -p "$HOME/project" && cd "$HOME/project"
git init
echo "Init file" > file.txt
git add file.txt
git commit -m "Initial commit file"
echo "This line should be printed" > file.txt

effix init

# Tests

[ -f "$HOME/project/.effix.conf" ] || print_error "Config file not found"

echo "cat [file]" > "$HOME/project/.effix.conf"

effix test | grep "This line should be printed" || print_error "Effix is not working"
