{ lib, pkgs, username, ... }:

let
  # Keep macOS tools authoritative; expose only stable Nix profiles to GUI apps.
  guiPath = [
    "/usr/bin"
    "/bin"
    "/usr/sbin"
    "/sbin"
    "/usr/local/bin"
    "/run/current-system/sw/bin"
    "/nix/var/nix/profiles/default/bin"
    "/etc/profiles/per-user/${username}/bin"
    "/Users/${username}/.nix-profile/bin"
  ];
in
{
  environment = {
    shells = with pkgs; [
      bash
      zsh
      fish
      "/etc/profiles/per-user/${username}/bin/fish"
    ]; # list of acceptable shells in /etc/shells

    shellAliases = { };
  };

  system.primaryUser = username;

  # GUI agents and their direct tools do not run shell startup files.
  launchd.user.envVariables = {
    BASH_ENV = "/Users/${username}/.config/shell/nix.sh";
    PATH = guiPath;
  };

  # Persist PATH before Finder and Dock start; launchctl setenv alone is too late.
  system.activationScripts.postActivation.text = ''
    /bin/launchctl config user path ${lib.escapeShellArg (lib.concatStringsSep ":" guiPath)}

    # SMAppService login items get a sanitized PATH; Vibe Usage scans /usr/local/bin.
    /usr/bin/install -d -m 0755 /usr/local/bin
    for name in node npx; do
      link="/usr/local/bin/$name"
      if [ ! -e "$link" ] && [ ! -L "$link" ]; then
        /bin/ln -s "/etc/profiles/per-user/${username}/bin/$name" "$link"
      fi
    done
  '';
}
