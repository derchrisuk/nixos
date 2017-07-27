{ config, pkgs, ... }:

{

  hardware = {
    bluetooth.enable = true;
    opengl.extraPackages = [ pkgs.vaapiIntel ];
    
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };

}

