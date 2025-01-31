#!/bin/bash
# a simple Dir/file(s) Compressing script
# Written by Kasun Sajith (contact me:) kasun@idearigs.com/+94 78 8080 441) on 1st of feb 2025 at IIT PDU
clear

# fetching some info from the OS
date=$(date)
user=$(whoami)
pwd=$(pwd)
host=$(hostname)

# Check if 'zip' command is available
if ! command -v zip &>/dev/null; then
    echo "zip is not installed on your $host system. Installing now..."
    sleep 2

    # Update package list
    sudo apt update -y

    # Install zip
    sudo apt install zip -y

    echo "zip has been installed successfully."
    sleep 2
    clear
else
    echo
fi


# Tool welcome
echo "================================================="
echo "    ZIPZY - dir/file compress tool   V.1.0       "
echo "================================================="

# welcome user
echo "Hello,$user Welcome to ZIPZY V.1.0.You're currently in $pwd"
sleep 2
echo

#prompt for number of directories
read -p "[+] Enter the number of Directories to create: " dir_count


# Initializing an array to store dir names
declare -a directories

# Error Handling
if [ "$dir_count" -eq "$dir_count" ] 2>/dev/null; then
    echo # Nothing will happen if input = numeric
else
    echo "[*] Invalid Input!"
    exit
fi

# loop to get dir names from user
for ((i=1; i<=dir_count; i++))
do
        read -p "[+] Enter a name for directory $i : " dir_name
        echo
        directories+=("$dir_name")
        mkdir -p "$dir_name"  #Create the dir
done

# loop through each directory to creat files and add content
for dir in "${directories[@]}"
do
        read -p "[+] How Many files do you want to create in $dir : " file_count

        # Error Hnadling
        if [ "$file_count" -eq "$file_count" ] 2>/dev/null; then
                echo
        else
                echo "[*] Invalid Option!"
                exit
        fi

        for ((j=1; j<=file_count; j++))
        do
                read -p "[+] Enter a name for file $j in $dir : " file_name
                echo
                read -p "[+] Enter the content for $file_name : " file_content
                echo
                echo "$file_content" > "$dir/$file_name"  # Creates the file with content in dir
        done
done

# Files & dir created successfully message
echo "All the file(s) and Directory(ies) are created successfully!!!"
echo
sleep 2

#ask user for zip file name
read -p "[+] Enter the name for output zip file (Without .zip extention): " zip_name
echo
sleep 2

# creating the zip file
zip -r "${zip_name}.zip" "${directories[@]}"
sleep 1
echo

# Finish message on terminal
echo "All the files and directories Created and Zipped into '${zip_name}.zip' at $date."
sleep 2
tree
sleep 2

echo "You can use the command :[ unzip ${zip_name}.zip ] to unzip & [ unzip -l ${zip_name}.zip ] to view the content inside without extracting!"
sleep 2
echo "Read the $pwd/zip.logs file to view Zipzy Logs!"
sleep 2
echo

# logging the events
echo "[+] A user named($user), Created a ${zip_name}.zip file which Contain $dir_count Directory(s) at $date.in $pwd" >> "$pwd/zip.logs"
