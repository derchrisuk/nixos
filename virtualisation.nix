{ config, pkgs, ... }:

{

  virtualisation = {
    libvirtd.enable = true;
    lxc.enable = true;
    lxc.defaultConfig = ''
      lxc.network.type = veth
      lxc.network.link = virbr0
      lxc.network.flags = up
      lxc.aa_profile = unconfined
    '';
    virtualbox.host.enable = true;
    docker.enable = true;
    docker.enableOnBoot = true;
    docker.storageDriver = "devicemapper";
  };

}

