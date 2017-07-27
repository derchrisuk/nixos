{ config, pkgs, ... }:

{

  programs = {
    ssh.startAgent = false;
    ssh.setXAuthLocation = true;
    bash = {
      interactiveShellInit = ''
        source ${pkgs.gitAndTools.gitFull}/share/git/contrib/completion/git-prompt.sh
        source ${pkgs.gitAndTools.gitFull}/share/git/contrib/completion/git-completion.bash
        alias pbcopy='xsel -b -i'
        alias pbpaste='xsel -b -o'
        alias rebuild='sudo nixos-rebuild switch'
        rbtohex() {
          ( od -An -vtx1 | tr -d ' \n' )
        }

        hextorb() {
          ( tr '[:lower:]' '[:upper:]' | sed -e 's/\([0-9A-F]\{2\}\)/\\\\\\x\1/gI'| xargs printf )
        }
      '';
      enableCompletion = true;
    };

    #zsh.enable = true;
  };

}

