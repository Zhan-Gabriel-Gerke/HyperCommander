Hyper Commander
A simple, interactive, menu-driven command-line tool written in Bash. It provides basic system information, file management capabilities, and a utility to find and run executables.

Features
OS Info: Displays detailed operating system information (using uname -a).

User Info: Shows the current logged-in user (using whoami).

File and Directory Operations: A simple file manager to navigate the filesystem and perform operations on files.

Find Executables: Locates an executable file in the system's $PATH and allows you to run it with arguments.

How to Use
Save the script to a file (e.g., hyper_commander.sh).

Open your terminal and navigate to the directory where you saved the file.

Make the script executable:

Bash

chmod +x hyper_commander.sh
Run the script:

Bash

./hyper_commander.sh
Follow the on-screen menus to navigate and perform actions.

Detailed Operations
Main Menu
The main menu provides access to all the core features:

------------------------------
| Hyper Commander            |
| 0: Exit                    |
| 1: OS info                 |
| 2: User info               |
| 3: File and Dir operations |
| 4: Find Executables        |
------------------------------
File and Directory Operations
This section allows you to explore your file system.

Navigation:

It lists all files and directories in the current location, prefixed with 'F' (File) or 'D' (Directory).

Enter a directory name to navigate into it.

Enter 'up' to move to the parent directory.

Enter '0' to return to the main menu.

File Actions:

When you enter a valid file name, a sub-menu appears with options for that specific file:

Delete: Permanently removes the file (rm).

Rename: Changes the file's name (mv).

Make writable: Adds write permissions for all users (chmod a+w).

Make read-only: Removes write permissions for 'others' (chmod o-w).

Back: Returns to the file listing.

Find Executables
This utility helps you find and run programs.

Enter the name of an executable (e.g., ls, python, git).

The script will use the which command to find its location.

If found, you will be prompted to enter arguments for the command.

The script will then execute the command with your provided arguments.

Requirements
A Unix-like operating system with a Bash shell (e.g., Linux, macOS, or Windows with WSL).
