#!/bin/bash
# Description: This script prompts a user to select scp or ssh and prompted for destination ip and user
# If ssh selected. The user is prompted for password and connected to remote server
# If scp is selected the user is prompted to select direction of copy and the is executed
# Author: Luis Moreno
# Date: 9/2/2023

#Prompt user to select ssh or scp
echo "Hi $(whoami),"
echo "Would you like to use ssh or scp?"
echo "[1] ssh"
echo "[2] scp"

#Capture user input
read selected_command

# while neither is 1 or 2 prompt again
while [[ "$selected_command" -ne 2 &&  "$selected_command" -ne 1 ]]; 
do
    echo "Please select 1 for ssh or 2 for scp"
    echo "[1] ssh"
    echo "[2] scp"
    read selected_command
done

#capture remote user
echo "What is your remote user?"
read remote_user

#capture remote address
echo "What is the address of the remote server?"
read remote_address


#if command selection is 1 ssh into server if selection is 2 use scp command
case "$selected_command" in
    2)
        #prompt user for direction
        echo "What direction to you want to copy?"
        echo "[1] local to remote ⬆️"
        echo "[2] remote to local ⬇️"

        #capture direction
        read direction

        #while direction is not 1 or 2 prompt user for direction
        while [[ "$direction" -ne 2 &&  "$direction" -ne 1 ]]; 
        do
            echo "[1] Select 1 to copy a file to the remote server"
            echo "[2] Select 2 to copy a file from the remote server"
            read direction
        done

        #Prompt and read source location
        echo "What is the source location, including file name"
        read source_location
        
        #prompt and read destination location
        echo "What is the destination location"
        read destination_location

        #set destination location for execution and execute
        case "$direction" in
            1)  
                #Default remote destination is home
                default_destination="~"
                #If no destination is provided we set to default
                destination_location="${destination_location:-$default_destination}"

                #execute
                scp $source_location $remote_user@$remote_address:$destination_location
            ;;
            2)
                #Default local destination is current 
                default_destination="."
                #If no destination is provided we set to default
                destination_location="${destination_location:-$default_destination}"

                #execute scp
                scp $remote_user@$remote_address:$source_location $destination_location
            ;;
        esac
    ;;  
    1) 
        #SSH to remote 
        ssh $remote_user@$remote_address
    ;;
esac