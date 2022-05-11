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
      pull.rebase = true;
    };

    userEmail = "eth2net@gmail.com";
    userName = "York Wong";

    includes = [
      {
        contents.user = {
          name = "York Wong";
          email = "yowang@flomesh.cn";
        };
        condition = "gitdir:~/repo/flomesh-io";
      }
    ];
  };
}
