{ config, pkgs, ... }:

{

  system = {
    stateVersion = "17.03";
    activationScripts = {
      i3config = ''
        ${pkgs.coreutils}/bin/mkdir -p /home/derchris/.config/i3/
        ${pkgs.coreutils}/bin/ln -snf /etc/i3config /home/derchris/.config/i3/config
      '';
      vimrc = ''
        ${pkgs.coreutils}/bin/ln -snf /etc/vimrc /home/derchris/.vimrc
      '';
      lock = ''
        ${pkgs.coreutils}/bin/mkdir -p /home/derchris/bin/
        ${pkgs.coreutils}/bin/cp /etc/lock /home/derchris/bin/lock.sh
        ${pkgs.coreutils}/bin/chmod +x /home/derchris/bin/lock.sh
      '';
      xresources = ''
        ${pkgs.coreutils}/bin/ln -snf /etc/xresources /home/derchris/.Xresources
      '';
    };
  };

}

