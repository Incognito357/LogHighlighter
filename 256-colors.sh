#!/bin/bash
for fgbg in 38 48 ; do
	mod=8
	off=0
	for color in {0..255} ; do
		if [[ $color -gt 15 && $off -eq 0 ]]; then
			mod=6
			off=16
		elif [[ $color -gt 231 ]]; then
			mod=8
			off=232
		fi
		printf "\e[${fgbg};5;${color}m %-8s\e[0m" "$((color))"
		if [ $((($color + 1 - off) % $mod)) == 0 ] ; then
			echo
		fi
	done

	echo
	#RED
	printf "\e[${fgbg};5;52m %-8s\e[${fgbg};5;88m %-8s\e[${fgbg};5;124m %-8s\e[${fgbg};5;1m %-8s\e[${fgbg};5;160m %-8s\e[${fgbg};5;196m %-8s\e[${fgbg};5;9m %-8s\e[0m\n" "R1" "R2" "R3" "#1" "R4" "R5" "#9"
	#YELLOW
	printf "\e[${fgbg};5;58m %-8s\e[${fgbg};5;100m %-8s\e[${fgbg};5;142m %-8s\e[${fgbg};5;3m %-8s\e[${fgbg};5;184m %-8s\e[${fgbg};5;226m %-8s\e[${fgbg};5;11m %-8s\e[0m\n" "RG1" "RG2" "RG3" "#3" "RG4" "RG5" "#11"
	#GREEN
	printf "\e[${fgbg};5;22m %-8s\e[${fgbg};5;28m %-8s\e[${fgbg};5;34m %-8s\e[${fgbg};5;2m %-8s\e[${fgbg};5;40m %-8s\e[${fgbg};5;46m %-8s\e[${fgbg};5;10m %-8s\e[0m\n" "G1" "G2" "G3" "#2" "G4" "G5" "#10"
	#CYAN
	printf "\e[${fgbg};5;23m %-8s\e[${fgbg};5;30m %-8s\e[${fgbg};5;37m %-8s\e[${fgbg};5;6m %-8s\e[${fgbg};5;44m %-8s\e[${fgbg};5;51m %-8s\e[${fgbg};5;14m %-8s\e[0m\n" "GB1" "GB2" "GB3" "#6" "GB4" "GB5" "#14"
	#BLUE
	printf "\e[${fgbg};5;17m %-8s\e[${fgbg};5;18m %-8s\e[${fgbg};5;19m %-8s\e[${fgbg};5;4m %-8s\e[${fgbg};5;20m %-8s\e[${fgbg};5;21m %-8s\e[${fgbg};5;12m %-8s\e[0m\n" "B1" "B2" "B3" "#4" "B4" "B5" "#12"
	#MAGENTA
	printf "\e[${fgbg};5;53m %-8s\e[${fgbg};5;90m %-8s\e[${fgbg};5;127m %-8s\e[${fgbg};5;5m %-8s\e[${fgbg};5;164m %-8s\e[${fgbg};5;201m %-8s\e[${fgbg};5;13m %-8s\e[0m\n" "RB1" "RB2" "RB3" "#5" "RB4" "RB5" "#13"
	#GRAY
	i=0
	for color in {232..255}; do
		if [[ $color -eq 232 ]]; then
			printf "\e[${fgbg};5;0m %-8s" "0"
			i=$((i + 1))
		elif [[ $color -eq 238 ]]; then
			printf "\e[${fgbg};5;8m %-8s" "8"
			i=1
		elif [[ $color -eq 251 ]]; then
			printf "\e[0m\n\e[${fgbg};5;7m %-8s" "7"
			i=1
		fi
		printf "\e[${fgbg};5;${color}m %-8s" "$color"
		i=$((i + 1))
		if [[ $color -eq 255 ]]; then
			printf "\e[${fgbg};5;15m %-8s\e[0m\n" "15"
		fi
		if [[ $(((i + 1) % 8)) == 0 ]]; then
			printf "\e[0m\n"
		fi
	done
	echo
done
