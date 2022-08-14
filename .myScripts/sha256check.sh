# #!/usr/local/bin/bash
# This script requires bash 4.4 or higher

#Check if bash version is 4.4 or higher, exit if not
MAJOR=$(echo $BASH_VERSION | cut -d "." -f 1)
MINOR=$(echo $BASH_VERSION | cut -d "." -f 2)
PATCH=$(echo ${BASH_VERSION%'('*} | cut -d "." -f 3)
if [[ $MAJOR -lt 4 ]] && [[ $MINOR -lt 4 ]]; then
	echo
	echo "Your version of Bash is $MAJOR.$MINOR.$PATCH, but needs to be 4.4 or higher - Program terminated."
	echo
	exit
fi

# Load filenames from current working directory into array
# The readarray -d feature is the one requiring bash version > 4.4
# The empty string '' means that the elements are NULL delimited comming from the find command
readarray -d '' LIST_OF_FILENAMES < <(find * -maxdepth 0 -type f -print0)
array_size=${#LIST_OF_FILENAMES[@]}

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
select FILENAME in ${LIST_OF_FILENAMES[@]}; do
	if [ -z $REPLY ] || [ $REPLY -gt $array_size ]; then
		echo -e "\nYou picked an invalid option - Programm terminated."
		exit
	else
		echo -e "\nYou picked option $REPLY) - $FILENAME\n"
		break
	fi
done

# Enter the checksum
read -p "Enter SHA256 checksum : " CHECKSUM

# Perform sha256 checksum test
DERIVED_CHECKSUM=$(shasum -a 256 $FILENAME | cut -d' ' -f1)
echo -e "Derived checksum      : $DERIVED_CHECKSUM\n"

if [[ $CHECKSUM == $DERIVED_CHECKSUM ]]; then
	echo "-------------------------------------"
	echo "OK - Test successful!"
	echo "====================================="
else
	echo "------------------------------------------"
	echo "ERROR - Sha256 Checksum test did not pass!"
	echo "=========================================="
fi
