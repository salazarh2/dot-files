
Arch Linux

# Set partitions for / /home and swap using fdisk
fdisk -l
fdisk /dev/sda
o create a new empty DOS partition table
sda1 /
sda2 swap
sda3 /home
! note: make sure the bootable flag is set in fdisk to / by issuing command "a"

# Format the fs types using mkfs
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda3
mkswap /dev/sda2

# Confirm network connection
ip a
ping

# Mount the installation directories
mount /dev/sda1 /mnt
mkdir /mnt/home
mount /dev/sda3 /mnt/home

# Install packages
pacstrap -i /mnt base

# Generate the fstab file
genfstab -U -p /mnt >> /mnt/etc/fstab

# chroot into the installation environment
arch-chroot /mnt

# Install packages
pacman -S openssh grub-bios linux-headers

# edit locales
vi /etc/locale.gen

# generate locales
locale-gen

# Create a simlink to the zoneinfo
ln -sf /usr/share/zoneinfo/America/Monterrey /etc/localtime

# Set the hardware clock
hwclock --systohc --utc

# Enable sshd if it was installed previously
systemctl enable sshd.service

# Set root password
passwd

# Install grub
grub-install --target=i386-pc --recheck /dev/sda

# something something just do it...
cp usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo

# Generate grub configuration file
grub-mkconfig -o /boot/grub/grub.cfg

# Exit the chroot environment
exit

# Unmount installation partition
umount /mnt/home
umount /mnt

# Reboot!


After initial reboot
remove the installation media

# Enable DHCP services
systemctl enable dhcpcd.service
