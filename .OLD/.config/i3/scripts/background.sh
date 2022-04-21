#!/bin/bash

background=$(ls ~/.local/share/backgrounds/ | grep "^bg.[^.]*$")

xsetroot -solid "#333333"
feh --bg-scale ".local/share/backgrounds/$background"
