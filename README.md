# dotfiles

## Usage

The bash script `setup.sh` sets all the config.

## Structure

I am thinking of making directories named `config` & `bin` for the time being.
After, when it grows in size I will add accordingly.

## Packages

List of (explicitly) installed packages:

- `bluetui` - a TUI for managing bluetooth devices
- `eza` - a modern replacement for `ls`
- `imv` - CLI based image viewer aimed at tiling window managers
- `libappindicator` - needed for tray to work on waybar
- `satty` - annotation tool for screenshot
- `snapper` - utility for creating snapshots of system
- `wifitui-bin` - a TUI for managing wifi devices
- `wiremix` - a TUI for managing audio devices
- `wireplumber` - modular session/policy manager for PipeWire
- `yt-dlp` - [youtube-dl](https://github.com/ytdl-org/youtube-dl/) fork with
  additional features and fixes
- `zathura` - a lightweight and minimalistic document viewer

## System

There are things which make this setup even better. These include `encryption`
& `hibernation`. For encryption it is obvious why it is important and as for
hibernation, it makes continuing where the system was left is a handy thing to
have.

For `encryption` [Arch Wiki](https://wiki.archlinux.org/title/Dm-crypt) is a
good place. It includes preparation, encryption, configuration, etc. are
included. A lot of this is already done in the `setup.sh` script and a lot of
commands are taken blogs mentioned in Links.

### Partition Setup

The partition is

The partition has two partitions:
  1. Boot partition
  2. Root partition (crypt)

The root partition is where all the mountpoint live. It is a `btrfs` filesystem
with subvolumes for root, home, log and cache.

#### Proper suspend

Until, specifically not making a file inside `/etc/systemd/sleep.conf.d`
directory machine will not go to deep sleep. This is especially annoying when I
want to just want to close the lid and it goes to suspend. Another thing, if
`HandleLidSwitch=suspend-then-hibernate` is not set up in
`/etc/systemd/logind.conf` file closing lid only triggers
[`hyprlock`](https://github.com/hyprwm/hyprlock/) to lock the system not
suspend and then hibernate it.

### Hibernation

I am using swapfile for hibernation. It lives inside crypt partition which
means that in order to see what data is compressed in that swapfile, the
partition has to be decrypted.

#### Hibernation on BTFS filesystem

For creating a `swapfile`

```bash 
btrfs subvolume create /swap 
btrfs filesystem mkswapfile --size 32g --uuid clear /swap/swapfile 
swapon -p 0 /swap/swapfile
```

After making the swapfile it is necessary for the machine to know where is the
partition. This can be done by adding to `/etc/fstab` file with:

```bash 
/swap/swapfile none swap defaults,pri=0 0
```

Above command is interpreted as first entry is location, second is mountpoint,
third is what type of partition, fourth is the default mountpoint applied with
`pri=0` which means it has lowest priority for multiple swapfiles; it will only
be used when higher priority swapfiles are unavailable or are full, fifth and
sixth are for backup and filesystem check by `fsck`. Don't want the file as
backup because it doesn't have persistent data.

Next, comes the `HOOKS` in `/etc/mkinitcpio.conf` file. For hibernation to
work, resume hook has to be added after `filesystems` and before `fsck` hooks.
After which `mkinitcpio -P` will do the final work.

This should create a `swapfile` on the filesystem with resume from hibernation.

### Security

#### Filesytem

For security on filesystem I have encrypted the partition but attacks happen
when connected to internet most of the time. Firewall with `ufw` seems to the
way to go.

#### Firewall

For the first one `22/tcp` means ssh connections. This allows ssh connections
but if the attack frequency increase it blocks them. Others, 80 and 443 are for
internet ports. And, by default all incoming are blocked and only outgoing is
allowed.

```bash
ufw limit 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw default deny incoming
ufw default allow outgoing
# For ProtonVPN
ufw allow in on proton0
ufw allow out in proton0
```

#### Network

I have gone with blocking all incoming and outgoing and allowed ports for
[`ProtonVPN`](https://protonvpn.com). Firewall also should be setup with `ufw
allow 80/tcp` and `ufw allow 443/tcp`.

### Snapshots

`BTRFS` gives ability to create snapshots for directories. This is helpful when
for example, a system update breaks the system. Snapshots can be used to go
back to the time when the system was not updated and continue to debug or
stay on that update.

## Links

- [LUKS2 encrypted BTRFS system partition with Limine/Snapper integration and hibernate to swapfile](https://gist.github.com/yovko/512326b904d120f3280c163abfbcb787)
- [LUKS2 encrypted system with different home and root partition](https://gist.github.com/mjnaderi/28264ce68f87f52f2cabb823a503e673)

## License

Released under [MIT License](https://mit-license.org/).
