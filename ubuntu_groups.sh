#!/bin/bash

if [ ! -d ~/results ]; then
        echo -e "\nCreating results directory in '$HOME' \n"
        mkdir ~/results
else echo -e "\nSkipping creating results directory\n"
fi

echo -e "Identifying Ubuntu user membership \n"
groups=$(grep -E "ubuntu" /etc/group | cut -d ':' -f 1 | tr ',' '\n')

echo "$groups" > ~/results/ubuntugrps.txt

echo -e "Added these groups to ~/results/ubuntugrps.txt:"

echo -e "$groups \n" 

echo -e "List created in ~/results/ \n"
echo -e "Script has completed \n"
echo -e "Moving you to results directory \n"

cd /home/ubuntu/results/
pwd
