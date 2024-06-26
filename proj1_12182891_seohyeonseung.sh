#! /bin/bash

op1="1.Get the data of Heung-Min Son's Current Club, Appearances, Goals, Assists in players.csv"
op2="2.Get the team data to enter a league position in teams.csv"
op3="3.Get the Top-3 Attendance matches in mateches.csv"
op4="4.Get the team's league position and team's top scorer in teams.csv & players.csv"
op5="5.Get the modified format of date_GMT in matches.csv"
op6="6.Get the data of the winning team by the largest difference on home stadium in teams.csv & matches.csv"
op7="7.Exit"

function menu6 {
	awk -F, '{if (NR > 1) {printf("%s,", $1)}}' teams.csv > teams.txt
	oldIFS=$IFS
	IFS=,
	PS3="Enter your team number: "
	select choice in $(cat teams.txt)
	do
		selected="$choice"
		differ=$(awk -F, -v var=0 -v team="$selected" '$3~team {if($5 - $6 > var) var=($5 - $6)} END {printf("%d", var)}' matches.csv)
		awk -F, -v var=$selected -v diff=$differ '($3~var) && ($5 - $6 == diff) {if (NR > 1) {printf("%s\n%s %d vs %d %s\n\n", $1, $3, $5, $6, $4)}}' matches.csv
		break
	done
}

function menu5 {
	read -p "Do you want to modify the format of date?(y/n): " choice
	cat matches.csv | awk -F"," '{printf "%s \n", $1}' | head -11 | tail -10 | awk '{printf("%s/%s/%s", $3, $1, $2); fflush(); printf(" %s\n", $5)}' | sed -e 's/Aug/08/g'

}

function menu4 {
	read -p "Do you want to get each team's ranking and the highest-scoring player?(y/n): " choice
	awk -F, '{if (NR > 1) {printf("%d-%s,\n", $6, $1)}}' teams.csv > teams.txt
	cat teams.txt | sort -t "-" -k 1 -n > teamsSort.txt
	IFS=,
	for var in $(cat teamsSort.txt | tr -d '\n')
	do
		rank=($(echo $var | cut -d '-' -f1))
		team=($(echo $var | cut -d '-' -f2))
		echo $rank $team
		awk -F, -v str=$team -v orverall=0 -v name="name" '$4~str {if (NR > 1) {if($7 >= overall) {name=$1;overall=$7}}} END {printf("%s %d\n\n", name, overall)}' players.csv
	done
}

function menu3 {
	read -p "Do you want to know Top-3 attendance data and average attendance? (y/n): " choice
	if [ "$choice" = "y"  ]
	then
		echo "***Top-3 Attendance Match***"
		cat matches.csv | sort -t"," -r -k 2 -n | head -3 | awk -F, '{print("\n\n", $3, "vs", $4, "("$1")\n", $2, $7)}'
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
	echo "usage: ./proj1_12182891_seohyeonseung.sh file1 file2 file3"
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
			4)
				menu4
				;;
			5)
				menu5
				;;
			6)
				menu6
				;;
			7)
				echo "Bye!"
                break
                ;;
        esac
done
