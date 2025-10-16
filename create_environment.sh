#!/bin/bash
#create an app reminder 
#request user input and make a directory 
read -p "Enter your name:" name
mkdir -p submission_reminder_$name

gania_dir="submission_reminder_$name"
#make subdirectories
mkdir -p "$gania_dir/app"
mkdir -p "$gania_dir/modules"
mkdir -p "$gania_dir/assets"
mkdir -p "$gania_dir/config"

echo '# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2' > $gania_dir/config/config.env

echo "student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Basics, not submitted
Anissa, Shell Navigation, submitted
Leah, Shell Navigation, submitted
Prince, Git, not submitted
Princess, Shell Basics, submitted
King, Shell Navigation, not submitted
Queen, Git, submitted
 " > $gania_dir/assets/submissions.txt

echo '#!/bin/bash

# Submission files and outputing
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    while IFS=, read -r student assignment status; do
        # Remove lead and trail whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment is similar
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}' > $gania_dir/modules/functions.sh

#reminder script to notify students of pending assignments
echo '#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"

check_submissions $submissions_file' > $gania_dir/app/reminder.sh

#If reminder exists
echo '
#!/bin/bash
if [ -f "./app/reminder.sh" ]; then
    ./app/reminder.sh
else
    echo "Failed to create reminder.sh not found in app/ directory"
exit 1
fi
' > $gania_dir/startup.sh

chmod +x $gania_dir/app/reminder.sh
chmod +x $gania_dir/modules/functions.sh
chmod +x $gania_dir/assets/submissions.txt
chmod +x $gania_dir/startup.sh