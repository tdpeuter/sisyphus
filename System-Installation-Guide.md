# System Installation Guide

Attach ArchLinux boot key. Boot.

Set the keyboard layout.

```
# loadkeys be-latin1
```

Connect to the internet.

```
# iwctl
[iwd]# station wlan0 connect <network>
```

Escape the menu with ^D. Automatically update the time.

```
# timedatectl set-ntp true
```

Format the disk. 

```
# fdisk -l 
# fdisk /dev/sda
: g
: n, 1, _, +1G
: t, 1, 1
: n, 2, _, +8G
: t, 2, 19
: n, 3, _, _
: w

# pvcreate /dev/sda3
# vgcreate MyGroup /dev/sda3
# lvcreate -l +100%FREE MyGroup -n MyVolume

# mkfs.ext4 /dev/MyGroup/MyVolume
# mkswap /dev/sda2
# mkfs.fat -F 32 /dev/sda1

# mount /dev/MyGroup/MyVolume /mnt
# mkdir /mnt/boot
# mount /dev/sda1 /mnt/boot
```

Enable swap. 

```
# swapon /dev/sda2
```

Install the kernel. Also install keyring because keys will be needed.

```
# pacman -Sy archlinux-keyring
# pacstrap /mnt base linux linux-firmware
```

Make the mounts persistent. 

```
# genfstab -U /mnt >> /mnt/etc/fstab
```

Configure the system.

```
# arch-chroot /mnt
# ln -sf /usr/share/zoneinfo/Europe/Brussels /etc/localtime
# hwclock --systohc
# locale-gen
# echo "LANG=en_GB.UTF-8" >> /etc/locale.conf
# echo "KEYMAP=be-latin1" >> /etc/vconsole.conf
# echo "Laptop-Tibo" >> /etc/hostname
```

Enable hibernation. 

```
# echo "8:2" > /sys/power/resume
```

Create initial ramdisk environment. 

```
# pacman -S vim lvm2
# vim /etc/mkinitcpio.conf
```

Change the file to match the following line: 

`HOOKS=(base udev autodetect modconf block lvm2 filesystems resume keyboard fsck)`

```
# mkinitcpio -P
```

Generate root password. 

```
# passwd
```

Configure boot manager. Also enable hibernation. 

```
# pacman -S grub efibootmgr
# grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
# vim /etc/default/grub
```

Change the file to match the following lines: 

`GRUB_TIMEOUT=0`

`GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet resume=/dev/sda2"`

`GRUB_PRELOAD_MODULES="part_gpt part_msdos lvm"`

```
# grub-mkconfig -o /boot/grub/grub.cfg
```

Add the default user (me). 

```
# useradd -m -G wheel,users,input,video tdpeuter
# passwd tdpeuter
```

Make the system automatically log into that user.

```
# sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
# sudo vim /etc/systemd/system/getty@tty1.service.d/autologin.conf
```
Contents of the file: 

```
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\u' --noclear --autologin tdpeuter - $TERM
```

Install sudo.

```
# pacman -S sudo
# visudo
```

In the file that comes up, uncomment the following line: `%wheel ALL=(ALL:ALL) ALL`

Install a networkmanager so you have bloody internet when you reboot (otherwise rendering your device utterly useless).

```
# pacman -S networkmanager
```

Escape fakeroot with ^D.

Finally, 

```
# reboot
```
