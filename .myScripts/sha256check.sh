#!/usr/local/bin/bash
# This script requires bash 4.4 or higher

#Check if bash version is 4.4 or higher, exit if not
major=$(echo $BASH_VERSION | cut -d "." -f 1)
minor=$(echo $BASH_VERSION | cut -d "." -f 2)
patch=$(echo ${BASH_VERSION%'('*} | cut -d "." -f 3)
if [[ ${major} -lt 4 ]] && [[ ${minor} -lt 4 ]]; then
	echo
	echo "Your version of Bash is ${major}.${minor}.${patch}, but needs to be 4.4 or higher - Program terminated."
	echo
	exit
fi

# Load filenames from current working directory into array
# The readarray -d feature is the one requiring bash version > 4.4
# The empty string '' means that the elements are NULL delimited comming from the find command
readarray -d '' list_of_filenames < <(find * -maxdepth 0 -type f -print0)
array_size=${#list_of_filenames[@]}

# If there are no files for e checksum then exit the program
if [[ $array_size -eq 0 ]]; then
	echo
	echo "There are no suitable files for a checksum test - Program terminated."
	echo
	exit
fi

# Start Sha256 test
echo -e "\nSha256 Checksum Test"
echo -e "--------------------\n"

# Select a file
# The select construct allows easy generation of menus
# https://www.gnu.org/software/bash/manual/html_node/Conditional-Constructs.html#Conditional-Constructs
echo -e "Select a file from the current working directory : \n"
select filename in ${list_of_filenames[@]}; do
	if [ -z $REPLY ] || [ $REPLY -gt $array_size ]; then
		echo -e "\nYou picked an invalid option - Programm terminated."
		exit
	else
		echo -e "\nYou picked option $REPLY) - $filename\n"
		break
	fi
done

# Enter the checksum
read -p "Enter SHA256 checksum : " checksum

# Perform sha256 checksum test
derived_checksum=$(shasum -a 256 $filename | cut -d' ' -f1)
echo -e "Derived checksum      : $derived_checksum\n"

if [[ $checksum == $derived_checksum ]]; then
	echo "-------------------------------------"
	echo "OK - Test successful!"
	echo "====================================="
else
	echo "------------------------------------------"
	echo "ERROR - Sha256 Checksum test did not pass!"
	echo "=========================================="
fi
