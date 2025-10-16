Submission Reminder App

This app will check which students have submitted assignments and reminds those who have not submitted. You can also change the assignment name and the days remaining.

This is the setup

You run the setup script to create the folders and files:
bash create_environment.sh

Go into the created folder:
cd submission_reminder_<yourName>

Start the app:
./startup.sh

Update Assignment:

Run:
bash copilot_shell_script.sh
Enter your name, assignment name, and days remaining.
The app will check submissions and show reminders for students who have not submitted.

Folder Structure
create_environment.sh – creates folders and files
copilot_shell_script.sh – updates assignment info
config/ – contains config.env
modules/ – contains functions.sh
app/ – contains reminder.sh
assets/ – contains submissions.txt

This is how it works:

startup.sh; runs reminder.sh
reminder.sh; reads submissions.txt and shows reminders
functions.sh; has the code to check each student