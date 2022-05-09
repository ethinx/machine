# The machine

My nix flake configuration for personal machines, for macOS (nix-darwin) and non-NixOS Linux system (home-manager) :P

## Inspiration
[kclejeune/system](https://github.com/kclejeune/system.git)
[MatthiasBenaets/nixos-config](https://github.com/MatthiasBenaets/nixos-config)
[mitchellh/nixos-config](https://github.com/mitchellh/nixos-config)

## How-to

### Install nix

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Enable `nix-command` and `flakes` feature

```bash
echo "experimental-features = nix-command flakes" >> $HOME/.config/nix/nix.conf
```

### macOS

Install [nix-darwin](https://github.com/kclejeune/system)

```bash
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer
```

Clone this repo, build and switch

```bash
git clone https://github.com/ethinx/machine.git
cd machine
darwin-rebuild switch --flake '.#macos-arm64'
```

then change shell manually

```bash
chsh -s $HOME/.nix-profile/bin/fish
```

### Linux

Install [home-manager](https://github.com/nix-community/home-manager), refer to the [standalone installation section](https://nix-community.github.io/home-manager/index.html#sec-install-standalone) of the manual

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-shell '<home-manager>' -A install

echo '. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"' >> .bashrc
```

As [fish](https://fishshell.com/) is the default shell in this flake config, in non-NixOS Linux system, please add fish to `/etc/shells` before switching profile

```bash
echo "$HOME/.nix-profile/bin/fish" >> /etc/shells
```

Clone this repo, build and switch

```bash
git clone https://github.com/ethinx/machine.git
cd machine
home-manager switch --flake '.#linux-arm64'
```

then change shell manually

```bash
chsh -s $HOME/.nix-profile/bin/fish
```
