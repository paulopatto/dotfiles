# Tmux configs

[TMux](https://tmux.github.io/) is a "terminal multiplexer: it enables a number of terminals (or windows), each running a separate program, to be created, accessed, and controlled from a single screen. TMux may be detached from a screen and continue running in the background, then later reattached."

tmux is an ISC-licensed alternative to [GNU Screen](https://wiki.archlinux.org/title/GNU_Screen). Although similar, there are many differences between the programs, as noted on the [tmux FAQ page](https://github.com/tmux/tmux/wiki/FAQ).

## Installation

[Install](https://github.com/tmux/tmux/wiki/Installing) the tmux package.

Ubuntu:

```sh
sudo apt install tmux
```

Fedora:

```sh
sudo dnf install tmux
```

macOS:

```sh
brew install tmux
```

## Configuration

By default, tmux looks for user-specific configuration at `$XDG_CONFIG_HOME/tmux/tmux.conf` followed by `$HOME/.config/tmux/tmux.conf`, as of 3.2. A global configuration file may be provided at /etc/tmux.conf though by default Arch does not ship such a file.

---

## References

- [Arch Linux: TMux manual page](https://wiki.archlinux.org/title/tmux#Clipboard_integration)

