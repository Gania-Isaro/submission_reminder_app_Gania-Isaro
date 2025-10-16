#!/bin/bash

read -p "Enter your name: " name

name=$(echo "$name" | tr '[:upper:]' '[:lower:]')

if [ -z "$name" ]; then
    echo "name cannot be empty"
    exit 1
fi

if [[ ! $name =~ ^[a-z]+$ ]]; then
    echo "name is invalid"
    exit 1
fi

dir="submission_reminder_$name"
submissions_file="$dir/assets/submissions.txt"
config_file="$dir/config/config.env"


if [ ! -d "$dir" ]; then
    echo "Directory does not exist"
    exit 1
fi

read -p "Enter the assignment name: " assignment
read -p "Enter the number of days remaining for submission: " days

if [[ -z $assignment ]]; then
    echo "assignment should not be empty"
    exit 1
fi
if ! [[ "$days" =~ ^[0-9]+$ ]]; then
    echo "days should not be empty"
    exit 1
fi

if [[ ! $assignment =~ ^[a-zA-Z0-9\ ]+$ ]]; then
    echo "assignment is not allowed"
    exit 1
fi

matched_assignment=$(grep -i ", *$assignment," "$submissions_file" | awk -F',' '{print $2}' | head -n1 | xargs)
if [[ -z $matched_assignment ]]; then
    echo "Assignment '$assignment' is not available in submission file"
    exit 1
fi

cat <<EOF > $config_file
ASSIGNMENT="$matched_assignment"
DAYS_REMAINING=$days
EOF

read -p "Do you want to run the app? (y/n): " run

if [[ $run =~ ^[Yy]$ ]]; then
   echo "The app is running..."
   cd "$dir"
   ./startup.sh
else
   echo "Run the app later by navigating to the file '$dir' and executing './startup.sh'"
fi