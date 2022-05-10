#!/bin/bash
# Name : Jinwon Lee; Student ID: 261048866; email: jinwon.lee@mail.mcgill.ca; department: Computer Science;


exist=0
dir1=$1
dir2=$2
difference=0

if [[ $# -ne 2 ]] #It checks if two input parameters are given`
then
	echo "Error: expected two input parameters."
	echo "Usage: ./deltad.bash <originaldirectory> <comparisondirectory>"
	exit 1
elif [[ ! -d $1 ]] #It checks if the first argument directory exists
then
	echo "Error: Input parameter #1 '$1' is not a directory"
	echo "Usage: ./deltad.bash <originaldirectory> <comparisondirectory>"
	exit 2
elif [[ ! -d $2 ]] #It checks if the second argument directory exists
then
	echo "Error: Input parameter #2 '$2' is not a directory"
	echo "Usage: ./deltad.bash <originaldirectory> <comparisondirectory>"
	exit 2
elif [[ $(basename $1) = $(basename $2) ]] #It checks if they are the same directory
then
	if [[ $1 -ef $2 ]]
	then
		echo "Error: They are the same directory"
		echo "Usage: ./deltad.bash <originaldirectory> <comparisondirectory>"
		exit 2
	fi

fi	

for i in $(ls $1) #It takes the files in the first argument directory and iterates through.
do
	if [[ -d $i ]] #If it is a directory, then skip it.
	then
		continue
	fi
	for j in $(ls $2) #It iterates through the second argument directory.
	do
		if [[ -d $j ]] #It checks if it is a directory
		then
			continue
		elif [[ $i = $j ]] #If the names are equal check if they have the same content.
		then
			diff $1/$i $2/$j > /dev/null
			if [[ $(echo $?) -eq 1 ]]
			then
				echo "$dir1/$i differs"
			fi
			exist=1
			difference=1
		fi
	done
	if [[ $exist -eq 1 ]] #if the file exists, then skip. Otherwise, print which file is missing.
	then
		exist=0
		continue
	elif [[ ! -d $1/$i ]]
	then
		echo "$dir2/$i is missing"
		difference=1
	fi
	
done


exist=0
for i in $(ls $2) #It iterates through the second argument directory to check 
								#If any files are missing.
do
	if [[ -d $i ]] #It makes sures that it is not a directory
	then
		continue
	fi
	for j in $(ls $1) #It iterates through the first argument directory
	do
		if [[ -d $j ]] #Makes sure that it is not a directory
		then
			continue
		elif [[ $i = $j ]] #If the names are the same, then it implies that the same file exist
		then               #This is because we already did a nested for loop above once.
			exist=1
		fi
	done
	
	if [[ $exist -eq 1 ]] #It checks if the file exists or not.
				#If the file doesn't exist, print a message.
	then
		exist=0
		continue
	elif [[ ! -d $2/$i ]]
	then
		echo "$dir1/$i is missing"
		difference=1
	fi
done


if [[ $difference -eq 0 ]] #Checks if there are any difference in the two input directories.
then			   #If there were no difference, then exist 0, otherwise exit 3.
	exit 0
else
	exit 3
fi


