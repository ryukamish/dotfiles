#!/usr/bin/env bash

RED="\e[31m"  GREEN="\e[32m"    RESET="\e[0m"

# Function to print error messages
# takes an argument
err_msg() {
  printf '\n%b' "${RED}ERROR${RESET}: $1"
}

# Function to print success and wait for keypress
# takes an argument
cmd_done() {
  printf '\n%b' "${GREEN}SUCCESS${RESET}: $1" \
    && printf '\n%b' "${GREEN}DONE!${RESET} Press any key..." \
    && bash -c 'read -n 1 -s'
}
