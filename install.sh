# Figure out how much RAM the system has
# then sets it as a variable for hibernation support
ramTotal=$(free -h | awk '/^Mem:/{print $2}' | awk -FG {'print$1'})

# Detect and list the drives.
lsblk -f

# Choice the drive to use :
# 1.
echo "----------"
echo ""
echo "Which drive do we want to use for this installation?"
read driveName

(
   echo g   # Create new GPT partition table
   echo n   # Create new partition (for EFI).
   echo     # Set default partition number.
   echo     # Set default first sector.
   echo +1G # Set +1G as last sector.
   echo n   # Create new partition (for root).
   echo     # Set default partition number.
   echo     # Set default first sector.
   echo -4G # Set -4G as last sector.
   echo n   # Create new partition (for root).
   echo     # Set default partition number.
   echo     # Set default first sector.
   echo     # Set last sector.
   echo t   # Change partition type.
   echo 1   # Pick first partition.
   echo 1   # Change first partition to EFI system.
   echo t   # Change partition type.
   echo 3   # Pick the last partition.
   echo 19  # Change last partition to Swap.
   echo w   # write changes.
) | sudo fdisk $driveName -w always -W always

# List the new partitions.
lsblk -f

# Format the partitions :
echo "----------"
echo ""
echo "Which is the EFI partition?"
read efiName

echo ""
echo "Which is the root partition?"
read rootName

echo ""
echo "Which is the swap partition?"
read swapName

# Create EFI partition
sudo mkfs.fat -F32 -n EFI $efiName

sudo mkswap $swapName    # swap partition
sudo mkfs.ext4 $rootName # /root partition
sudo e2label $rootName NixOS

# 0. Mount the filesystems.
sudo swapon $swapName
sudo mount $rootName /mnt

# Mount the EFI partition.
sudo mkdir /mnt/boot/
sudo mount $efiName /mnt/boot

# Generate Nix configuration
sudo nixos-generate-config --root /mnt

# Copy my base nix configs over
# Change the URL to match where you are hosting your .nix file(s).

echo "Default username and password are in the configuration.nix file"
echo "Password is hashed so it is not plaintext"

curl https://raw.githubusercontent.com/bashfulrobot/x13-nixos/main/etc/nixos/configuration.nix >configuration.nix
sudo mv -f configuration.nix /mnt/etc/nixos/
curl https://raw.githubusercontent.com/bashfulrobot/x13-nixos/main/etc/nixos/firewall.nix >firewall.nix
sudo mv -f firewall.nix /mnt/etc/nixos/
curl https://raw.githubusercontent.com/bashfulrobot/x13-nixos/main/etc/nixos/flake.nix >flake.nix
sudo mv -f flake.nix /mnt/etc/nixos/
curl https://raw.githubusercontent.com/bashfulrobot/x13-nixos/main/etc/nixos/flatpak.nix >flatpak.nix
sudo mv -f flatpak.nix /mnt/etc/nixos/
curl https://raw.githubusercontent.com/bashfulrobot/x13-nixos/main/etc/nixos/flatpak.nix >flatpak.nix
sudo mv -f flatpak.nix /mnt/etc/nixos/
curl https://raw.githubusercontent.com/bashfulrobot/x13-nixos/main/etc/nixos/pantheon-desktop.nix >pantheon-desktop.nix
sudo mv -f pantheon-desktop.nix /mnt/etc/nixos/
curl https://raw.githubusercontent.com/bashfulrobot/x13-nixos/main/etc/nixos/applications.nix >applications.nix
sudo mv -f applications.nix /mnt/etc/nixos/

# Install
sudo nixos-install
