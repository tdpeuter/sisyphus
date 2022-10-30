#!/usr/bin/env bash
# Remove unused dependencies that are not explicitly installed
# Usage: [sudo] cleandependencies

# Retrieve a list of all packages that are not explicitly installed and are not needed by anything else.
# Note that optional dependencies also do not get removed.
# function getList () {
# grep "Name\|Required By\|Optional For\|Install Reason" <<< $(pacman -Qi) | 
# 	tr '\n' ';' | sed "s/$/\n/" |
# 	sed "s/  */ /g" | 
# 	sed "s/Name/\nName/g" | 
# 	sed "s/\(Name\|Required By\|Optional For\|Install Reason\) : //g" | 
#	grep "Installed as a dependency for another package" |
#	grep "^[^;]*;None;None" | 
#	cut -f 1 -d ';'
# } ; export -f getList

current_amount=$(pacman -Qdtq | wc -l)
# Keep looping while there are unusded dependencies. 
# Stop when the next amount is the same, probably because the action was canceled.
while [[ ${current_amount} -ne 0 && ${current_amount} -ne ${previous_amount:=0} ]] ; do
	previous_amount=${current_amount}
	pacman -R $(pacman -Qdtq)
	current_amount=$(pacman -Qdtq | wc -l)
done

