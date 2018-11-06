#!/usr/bin/env bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

__print_error () {
    echo -e "$1"
}

__print_success () {
    echo -e "${GREEN}$1${NC}"
}

__print_info (){
    echo -e "${YELLOW}$1${NC}"
}
