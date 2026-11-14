# dotfiles-sway

Dotfiles for my ThinkPad E420: Gentoo (OpenRC, no systemd) + Sway on pure Wayland, themed after Hsin (Wuthering Waves).

## Stack

| Part | Choice |
|------|--------|
| OS | Gentoo, OpenRC |
| Compositor | Sway |
| Bar | Waybar (Nerd Font icons, hover tooltips, calendar, Wi-Fi menu) |
| Notifications | mako |
| Terminal | kitty |
| Lock | swaylock (fox emblem) |
| Launcher | wofi |
| Fetch | fastfetch (fox-tweaked Gentoo logo) |
| Login | greetd + tuigreet in a Sway greeter with a fox-rain animation |
| Bootloader | GRUB with a custom Wuthering-hsin theme |

## Palette

| Role | Color |
|------|-------|
| Background | `#1e1416` |
| Text | `#eedec8` |
| Accent red | `#e03e3e` |
| Gold | `#ecc587` |
| Light gold | `#f4d9a6` |

## Layout

This is a bare repo whose work tree is `$HOME`.

```sh
alias config='git --git-dir=$HOME/.cfg --work-tree=$HOME'
config status
config add <file>
config commit -m "..."
config push
```


## Install on a new machine

```sh
git clone --bare git@github.com:alwaysneverr/dotfiles-sway.git $HOME/.cfg
alias config='git --git-dir=$HOME/.cfg --work-tree=$HOME'
config checkout
config config status.showUntrackedFiles no
```

If checkout complains about existing files, move them aside and retry.

## Notes

- Needs a Nerd Font for the Waybar and swaylock icons.
- The old i3 setup lives on the `arch-i3wm` branch.
- System-level files (greetd, GRUB, inittab, lid handling) are kept outside this repo.

## System-level changes (outside this repo)

These live in `/etc` and `/boot`, so they aren't tracked here.

### greetd + tuigreet

- Gentoo ships no OpenRC script for greetd, so I wrote `/etc/init.d/greetd` (`need elogind`, `provide display-manager`, logs to `/var/log/greetd.log`). It runs as the `greetd` user.
- greetd launches a tiny Sway session (`/etc/greetd/sway-config`) instead of a bare tty. It holds two kitty windows:
  - `foxbg`: fullscreen, borderless, runs `foxrain`, a custom Python truecolor animation of falling pixel-art foxes.
  - `greeter`: floating and centered, runs tuigreet through `/usr/local/bin/greeter-ui`.
- tuigreet tweaks:
  - Hsin colors via `--theme`.
  - Custom greeting and time format.
  - `--remember` and `--remember-session`.
  - `--asterisks` with a Nerd Font GitLab glyph as the password character.
  - Fixed width of 56.
- The session command is `/usr/local/bin/start-sway`, which does `exec dbus-run-session sway`.
- The `c1` getty in `/etc/inittab` is commented out so greetd owns tty1, and OpenRC runs with `--quiet` to keep boot spam off the screen.
- A kitty `initial_window_width/height` (in cells) avoids a startup resize race that sometimes placed the login box in the lower right.

### GRUB

- Theme: Wuthering-hsin, based on [vinceliuice/Wuthering-grub2-themes](https://github.com/vinceliuice/Wuthering-grub2-themes), renamed and edited by me.
- Background: rebuilt from Hsin art as a 1920x1080 baseline JPEG, because GRUB can't read progressive JPEGs.
- `/etc/default/grub`:
  - `GRUB_THEME` points at the theme.
  - `GRUB_GFXMODE=1366x768,auto`.
  - `GRUB_CMDLINE_LINUX_DEFAULT="quiet loglevel=3 rd.udev.log_level=3 vt.global_cursor_default=0"`.
- After `grub-mkconfig`, a `sed` removes the `echo Loading ...` lines so nothing prints between the menu and boot.
- After a GRUB package update, run `grub-install /dev/sda` (BIOS), and press `z` in `dispatch-conf` to keep my `/etc/default/grub`.
