#! /bin/bash

op1="1.Get the data of Heung-Min Son's Current Club, Appearances, Goals, Assists in players.csv"
op2="2.Get the team data to enter a league position in teams.csv"
op3="3.Get the Top-3 Attendance matches in mateches.csv"
op4="4.Get the team's league position and team's top scorer in teams.csv & players.csv"
op5="5.Get the modified format of date_GMT in matches.csv"
op6="6.Get the data of the winning team by the largest difference on home stadium in teams.csv & matches.csv"
op7="7.Exit"

function menu3 {
read -p "Do you want to know Top-3 attendance data and average attendance? (y/n): " choice
if [ "$choice" = "y"  ]
then
echo "menu3"
fi
}

function menu2 {
read -p "What do you want to get the team data of league_position[1~20] :" choice
cat teams.csv | awk -F, -v var=$choice '$6 == var {printf("%d %s %f\n",$6, $1, $2/($2+$3+$4))}'
}

function menu1 {
read -p "Do you want to get the Heung-Min Son's data? (y/n) :" choice
if [ "$choice" = "y" ]
then
cat players.csv | awk -F, '$1~"Heung-Min" {print ("Team:"$4", Apperance:"$6", Goal:"$7", Assist:"$8)}'
fi
}

function selectMenu {
	echo "[MENU]"
	echo $op1
	echo $op2
	echo $op3
	echo $op4
	echo $op5
	echo $op6
	echo $op7
	read -p "Enter your CHOICE(1~7) : " choice
	return $choice
}

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]
then
	echo "usage: ./oss.sh file1 file2 file3"
	exit
fi  
 
echo "************OSS1 - Project1************"
echo "*        StudentID : 12182891         *"
echo "*        Name : HyeonSeung Seo        *"
echo "***************************************"

while true
do
	selectMenu
	menu=$?
        case $menu in
                1)
                        menu1
			;;

 		2)
			menu2
              		;;
		3)
			menu3
			;;
		7)
                        break
                        ;;
        esac
done
