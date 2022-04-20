# User Specific Setup Guide

Set paralell downloads. 

```
$ sudo vim /etc/pacman.conf
```

Uncomment the following line. 

`ParallelDownloads = 5`

Install connection applications. 

```
$ sudo pacman -S network-manager-applet blueman
$ sudo pacman -S pulseaudio pulseaudio-alsa pulseaudio-bluetooth
```

Setup a desktop environment. 

```
$ sudo pacman -S sway swaylock-effects-git swayidle i3status alacritty
```

Install yay for easy package management. 

```
$ sudo pacman -S base-devel git
$ cd /opt
$ sudo git clone https://aur.archlinux.org/yay.git
$ sudo chown -R username:users .yay
$ cd yay
$ makepkg -si
```
