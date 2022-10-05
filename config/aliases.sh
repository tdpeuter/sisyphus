#!/usr/bin/env bash

# 
# ~/.config/aliases.sh
# 
# A list of aliases and functions

# =======
# Aliases
# =======

alias cp="cp -i"                            # Confirm before overwriting something
alias df='df -h'                            # Human-readable sizes
alias free='free -m'                        # Show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
alias hgrep='history | grep'                # Search in history
# Move to directory with personal files.
alias Personal='cd ~/Documents/Persoonlijk/'
# Move to directory with uni files.
alias UGent='cd ~/Documents/UGent/Informatica\ J2\ 2022-2023/'
# Move to directory with notes, both uni and personal
alias notes='cd ~/Documents/Persoonlijk/Obsinotes/'
alias vol='~/.scripts/vol.sh'               # Shortcut to volume setter script

# =========
# Functions
# =========

# Run git commands with a specific SSH-key more easily
# Usage: sshgit <path-to-key> <command(s)>
sshgit () {

    # Check arguments
    if [[ $# -lt 2 ]] ; then 
        echo "Requires at least two arguments"
        exit 1
    fi

    ssh_key="$1"
    shift
    GIT_SSH_COMMAND="ssh -i ${ssh_key}" git $@

}

# Copy a directory (to a non-existing destination), interactively
# Usage: cpdir <source> <destination>
cpdir () {

    # Check arguments
    if [[ $# == 2 ]] ; then
        from=$(dirname $1)
        fromfile=$(basename $1)
        to=$(dirname $2)
        tofile=$(basename $2)
    else
        echo "cpdir: Not enough arguments"
        echo "cpdir: Syntaxis: cpdir <source> <destination>"
        return
    fi
    
    # Check file
    if [[ ! -f $1 ]] ; then
        echo "cpdir: Source does not exist: $1"
        return
    fi
    
    echo "Move ${fromfile} from ${from} to ${to} as ${tofile}?"
    echo -n "y/n > "
    read answer

    if [[ ${answer} == "y" ]] ; then
        mkdir -pv $to
        cp $1 $2
        echo "Done"
    elif [[ ${answer} == "n" ]] ; then
        echo "Not copying..."
    else
        echo "Invalid option"
        return
    fi
}

# ex - arrchive extractor
# Usage: ex <file>
ex () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      unrar x $1      ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *.7z)       7z x $1         ;;
            *)
                echo "'$1' cannot be extracted via ex()"
                ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
