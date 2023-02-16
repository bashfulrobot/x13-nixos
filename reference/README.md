# NixOs CFG Files

## Credit

- `Install.sh`: <https://gitlab.com/ahoneybun/nyxi-installer>

## Generate a Password

```
sudo mkpasswd -m sha-512
```

## Get Started

Prerequisites:

- Prepare an installation medium.
- Boot the live environment.
- Connect to internet.

## Connect to internet

```sh
> add_network
0
> set_network 0 ssid "myhomenetwork"
OK
> set_network 0 psk "mypassword"
OK
> set_network 0 key_mgmt WPA-PSK
OK
> enable_network 0
OK
```

<https://nixos.org/manual/nixos/stable/index.html#sec-installation-booting-networking>

## Start the installer

```sh
sh <(curl -L https://raw.githubusercontent.com/bashfulrobot/x13-nixos/main/install.sh)
```

The following will happen:

- Clear partition table for `/dev/***`.
- Creates a GPT partition table for `/dev/***`.
- Creates a 1GB EFI partiton at `/dev/***1`.
- Creates a 4GB Swap partition at `/dev/***3`.
- Creates a root partition with the rest of the space at `/dev/***2`.
- Installs GRUB
