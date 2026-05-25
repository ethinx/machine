{ pkgs, system, username, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      core.quotepath = false;

      diff = {
        tool = "difftastic";
        external = "difft";
      };

      difftool.diffstatic.cmd = "difft $LOCAL $REMOTE";
      # pull.rebase = true;
      user.email = "965612+ethinx@users.noreply.github.com";
      user.name = "York Wong";

    };

    includes = [
      {
        contents = {
          user = {
            name = "York Wong";
            email = "97939737+nixff@users.noreply.github.com";
          };
          core = {
            sshCommand = "ssh -i ~/.ssh/id_ed25519_nixff";
          };
        };
        condition = "gitdir:~/repo/flomesh-io/";
      }
      {
        contents = {
          user = {
            name = "York Wong";
            email = "97939737+nixff@users.noreply.github.com";
            signingkey = "~/.ssh/id_ed25519_nixff.pub";
          };
          core = {
            sshCommand = "ssh -i ~/.ssh/id_ed25519_nixff";
          };
          gpg = {
            format = "ssh";
          };
        };
        condition = "gitdir:~/repo/nixff/";
      }
    ];
  };
}
