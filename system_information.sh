#!/bin/bash
# Summary: Provide a menu for users about what information they want to check
# Author: Luis Moreno

# Options for user in an array
options=("Logged in user"
        "Your shell directory"
        "Home directory"
        "Os name and version"
        "Current working directory"
        "Number of logged in users"
        "Show all available shells in your system"
        "Hard disk information"
        "Cpu information"
        "Memory information"
        "File system information"
        "Currently running processes")

# echo options to user. add 1 to index on presentation for experience
for i in "${!options[@]}"; do
    echo "$((i + 1)), ${options[$i]}"
done

# option to exit
echo -e "\n Select 0 to exit" 

# prompt user for option
echo -e "\nChoose an option"

# caputure users selection
read selection

# Subtract one for comparison operation to match array index
minus_one=$((selection - 1))

echo -e "\n"

# based on selection we execute a command or series of commands
case $minus_one in
    0)
        echo "Current logged in user: $(whoami)"
    ;;
    1)
        echo "Current shell directory: $SHELL"
    ;;
    2)
        echo "Home: $HOME"
    ;; 
    3)
        # https://www.commandlinux.com/man-page/man1/lsb_release.1.html
        echo "OS $(lsb_release -d)"
    ;;
    4)
        echo "Current working directory: $(pwd)"
    ;;
    5)
        # https://www.commandlinux.com/man-page/man1/w.1.html
        echo "$(w | head -n 1 | cut -d ',' -f 2) logged in"
    ;;
    6)
        echo "Available shells: $(cat /etc/shells)"
    ;;
    7)
        # https://www.commandlinux.com/man-page/man8/lsblk.8.html
        echo "$(lsblk -f)"
    ;;
    8)
        # https://www.howtoforge.com/linux-lscpu-command/
        echo -e "CPU information: \n"
        echo "$lscpu"
    ;;
    9)
        # https://www.commandlinux.com/man-page/man1/free.1.html
        echo -e "Memory information: \n"
        echo "$free"
    ;;
    10)
        # https://www.commandlinux.com/man-page/man2/mount.2.html
        echo -e "File system information:\n" 
        echo "$mount"
    ;;
    11)
        # https://www.commandlinux.com/man-page/man1/ps.1.html
        echo -e "Running processes"
        echo "$(ps aux)"
    ;;
    0)
        echo $(exit 1)
    ;;
esac
