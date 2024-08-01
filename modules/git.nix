{ pkgs, system, username, ... }:

{
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";

      diff = {
        tool = "difftastic";
        external = "difft";
      };

      difftool.diffstatic.cmd = "difft $LOCAL $REMOTE";
      # pull.rebase = true;
    };

    userEmail = "965612+ethinx@users.noreply.github.com";
    userName = "York Wong";

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
          };
          core = {
            sshCommand = "ssh -i ~/.ssh/id_ed25519_nixff";
          };
        };
        condition = "gitdir:~/repo/nixff/";
      }
    ];
  };
}
