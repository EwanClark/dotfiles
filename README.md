# 🎯 Dotfiles Setup (`~/.config`)

These dotfiles are managed **inside `~/.config`** using a
**whitelist-style `.gitignore`**.\
Only the folders I explicitly allow are tracked --- everything else is
ignored.\
This keeps configs clean, avoids tracking caches, and makes syncing
between systems easy.

------------------------------------------------------------------------

## 📦 Repository Structure

The repo lives directly inside:

    ~/.config/

Typical structure:

    ~/.config/
      .git/
      .gitignore
      README.md
      hypr/
      fish/
      kitty/
      starship.toml
      spicetify/
      dankmaterialshell/
      ...

Everything not explicitly whitelisted is ignored.

------------------------------------------------------------------------

# 🚀 Cloning on a New System

### 1. Backup existing configs (optional but recommended)

``` bash
mv ~/.config ~/.config_backup
mkdir ~/.config
```

### 2. Clone directly into `~/.config`

``` bash
git clone https://github.com/ewanclark/dotfiles.git ~/.config
```

### 4. Restart!

Some programs will automatically apply the configs.\
It is recomended to restart your computer.

------------------------------------------------------------------------

# ✏️ Adding New Files or Folders to the Dotfiles

The `.gitignore` uses whitelist mode:

    *
    !hypr/**
    !fish/**
    !kitty/**
    !spicetify/**
    !dankmaterialshell/**
    !starship.toml

------------------------------------------------------------------------

### ✔ Add a new folder

1.  Add it to `.gitignore`:

```bash
!fastfetch/**
```

2.  Commit it:

``` bash
git add -A
git commit -m "Track fastfetch configs"
git push
```

------------------------------------------------------------------------

### ✔ Add a single file

1.  Add it to `.gitignore`:

```bash
!somefile.conf
```

2.  Commit it:

``` bash
git add -A
git commit -m "Track somefile.conf"
git push
```

------------------------------------------------------------------------

### ✔ Track a folder but exclude a subfolder/subfile inside it

Example: track `hypr/**` but exclude `hypr/cache/`.

1.  Make sure your whitelist rule exists:

```bash
!hypr/**
```

2.  Add a blacklist rule *after* it:

```bash
hypr/cache/**
```

3.  Remove it from git tracking:

``` bash
git rm -r --cached hypr/cache
```

4.  Commit:

``` bash
git commit -m "Exclude hypr/cache from tracking"
git push
```

------------------------------------------------------------------------

# 🔄 Daily Usage

### Commit updates

``` bash
cd ~/.config
git add -A
git commit -m "Update configs"
git push
```

### Pull updates on another machine

``` bash
cd ~/.config
git pull
```

### Check tracked changes

``` bash
git status
```

------------------------------------------------------------------------

# 🛠  Commands after Cloning

## 📂 Enable Rclone Backup Service

### Make Rclone Config

Create or restore your rclone configuration file at:

```bash
~/.config/rclone/rclone.conf
```

You can either copy an existing `rclone.conf` into this location or generate a new one by running:

```bash
rclone config
```

Follow the interactive setup to create your remotes.


### Enable the timer

``` bash
systemctl --user enable --now backuprclone.timer
```

### Check status

``` bash
systemctl --user status backuprclone.timer
```

### Check timer is running:

``` bash
systemctl --user list-timers
```

------------------------------------------------------------------------

# ⚠️ Important Note

This repository **does not include an install script or dependency management**. It is simply a collection of configuration files. You will need to install the required software/packages manually.

The configs are provided as-is and assume you have the corresponding software already installed on your system.

------------------------------------------------------------------------
