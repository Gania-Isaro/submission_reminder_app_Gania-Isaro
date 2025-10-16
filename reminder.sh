#!/bin/bash

source ./config/config.env
source ./modules/functions.sh

# Submissions file
submissions_file="./assets/submissions.txt"

echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"

check_submissions $submissions_file
