#!/bin/bash

# Name: Jinwon Lee; Student ID:261048866; email: jinwon.lee@mail.mcgill.ca; department: Computer Science;


gettime(){ #This function will create the date of today in YYYYMMDD
set $(date)
year=$6
case $2 in   #It checks which month today is
	"Jan") month="01";;
	"Feb") month="02";;
	"Mar") month="03";;
	"Apr") month="04";;
	"May") month="05";;
	"Jun") month="06";;
	"Jul") month="07";;
	"Aug") month="08";;
	"Sep") month="09";;
	"Oct") month="10";;
	"Nov") month="11";;
	"Dec") month="12";;
esac

if [[ $3 -lt 10 ]] #If the date is one digit, add 0 in front of it 
then 
	day="0$3"
else
	day=$3
fi
today=$year$month$day   #gives today's date in YYYYMMDD
}

gettime

if [[ $# -ne 2 ]] #It checks if there are 2 arguments given
then
	echo "Error: Expected two input parameters."
	echo "Usage: $0 <backupdirectory> <fileordirttobackup>"
	exit 1

elif [[ ! -d $1 ]] #It checks if the 1st argument is a directory
then 
	echo "Error: The directory '$1' does not exist"
	exit 2

elif [[ ! -f $2 ]]  #It checks if the 2nd argument is a file
then
	if [[ ! -d $2 ]] #It checks if the 2nd argument is a directory. 
	then  		
		echo "Error: The directory or file '$2' does not exist"
		exit 2
	fi	
elif [[ ! -d $2 ]] #It checks if the 2nd argument is a directory
then
	if [[ ! -f $2 ]] #It checks if the 2nd argument is a file.
	then
		echo "Error: The directory or file '$2' does not exist"
		exit 2	
	fi

fi

dir1="basename $1"
dir2="basename $2"
name=$($dir2).$today.tar #This will be the name of tar file name.
if [[ $($dir1) = $($dir2) ]] #It checks if two given arguments have the same basename.
then
	if [[ -d $2 && $1 -ef $2 ]] #It checks if the two arguments have the same path.
	then		
		echo "Error: Both arguments are the same directory"
		exit 2
	fi
fi


same=1

for i in $(ls $1) #It checks if there already exists a same filename
do
	if [[ $i = $name ]]
	then
		same=0
		break
	fi
done

if [[ $same -eq 0 ]] #If there is a same filename, then it asks user if they want to overwirte.
			#If yes, then overwrite. If no, then do not overwrite.
then
	echo "Backup file '$name' already exists. Overwrite? (y/n)"
	read userinput
	if [[ $userinput = y ]]
	then
		tar -cf $1/$name $2 2> /dev/null
		exit 0
	else
		exit 3

	fi	
else 
	tar -cf $1/$name $2 2> /dev/null
	exit 0

fi

