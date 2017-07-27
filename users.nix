{ config, pkgs, ... }:

{

  users = {
    extraUsers.derchris = {
      isNormalUser = true;
      home = "/home/derchris";
      extraGroups = [ "wheel" "networkmanager" "pulseaudio" "lp" "kvm" "audio" "libvirtd" "docker" "vboxusers" ];
      uid = 1000;
      hashedPassword = "$6$GiCINZbvY$3RamTHi8OJrKyt0rF.Bn.uOhdGwos/OeO45st/PKBQNi.F1AJSCNhfwLcL1aqOBYhoz52A/rXAwicK49S4N220";
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP3VMGqSKqxQYbCTc1QPwTc3m8eHPSMqwUgE4D1k9Z95 derchris@air.derchris.local" ];
      #shell = "/run/current-system/sw/bin/zsh";
    };

    extraGroups.docker = { };
    extraGroups.kvm = { };
    extraUsers.root = {
      subGidRanges = [ { count = 65536; startGid = 1000000; } ];
      subUidRanges = [ { count = 65536; startUid = 1000000; } ];
    };
  };

}

