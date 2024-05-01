#! /bin/bash

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]
then
	echo "usage: ./oss.sh file1 file2 file3"
	exit
fi  
 
echo "************OSS1 - Project1************"
echo "*        StudentID : 12182891         *"
echo "*        Name : HyeonSeung Seo        *"
echo "***************************************"

option1="Get the data of Heung-Min Son's Current Club, Appearances, Goals, Assists in players.csv"
option2="Get the team data to enter a league position in teams.csv"
option3="Get the Top-3 Attendance matches in mateches.csv"
option4="Get the team's league position and team's top scorer in teams.csv & players.csv"
option5="Get the modified format of date_GMT in matches.csv"
option6="Get the data of the winning team by the largest difference on home stadium in teams.csv & matches.csv"
option7="Exit"

select  menu in "$option1" "$option2" "$option3" "$option4" "$option5" "$option6" "$option7" 
do
	case $menu in
		$option1)
			read -p "Do you want to get the Heung-Min Son's data? (y/n) :" choice
			if [ "$choice" = "y" ]
			then
				cat players.csv | awk -F, '$1~"Heung-Min" {print ("Team:"$4", Apperance:"$6", Goal:"$7", Assist:"$8)}'
			else
				continue	
			;;
		$option7)
			break
			;;
	esac	
done
