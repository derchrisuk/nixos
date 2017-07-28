{ config, pkgs, ... }:

let
  packageGroups = import ./package-groups.nix {
    inherit pkgs;
  };
in

{
  imports =
    [ 
      ./boot.nix
      ./environment.nix
      ./hardware-configuration.nix
      ./hardware.nix
      ./networking.nix
      ./programs.nix
      ./services.nix
      ./system.nix
      ./users.nix
      ./virtualisation.nix
    ];

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
    #consoleUseXkbConfig = true;
  };

  time.timeZone = "Europe/Berlin";

  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
    dmenu.enableXft = true;
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      powerline-fonts
      corefonts
      inconsolata
      ubuntu_font_family
      vistafonts
      terminus_font
      proggyfonts
      dejavu_fonts
      font-awesome-ttf
      source-code-pro
      source-sans-pro
      source-serif-pro
      hack-font
    ];
  };

  security.sudo.extraConfig = ''
    Defaults    !tty_tickets
    Defaults    timestamp_timeout=30
  '';

  security.sudo.wheelNeedsPassword = false;
  security.audit.enable = false;
  security.rngd.enable = false;
  #security.polkit.enable = false;

  nix.binaryCaches = [ "https://hydra.mayflower.de/" "https://cache.nixos.org/" ];
  nix.binaryCachePublicKeys = [
    "hydra.mayflower.de:9knPU2SJ2xyI0KTJjtUKOGUVdR2/3cOB4VNDQThcfaY="
    "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
  ];

  nix.extraOptions = ''
    auto-optimise-store = true
  '';

  nix.useSandbox = true;
  powerManagement.enable = true;

  #sound.mediaKeys = {
  #  enable = true;
  #  volumeStep = "5%";
  #};

}

