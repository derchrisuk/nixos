{ config, pkgs, ... }:

{

  boot = {
    loader.grub.enable = true;
    loader.grub.version = 2;
    loader.grub.device = "/dev/sda";
    initrd.kernelModules = [ "ext4" "zfs" ];
    kernelModules = [ "kvm-intel" "tun" "virtio" ];
    blacklistedKernelModules = [ "snd_pcsp" "pcspkr" "rfkill" ];
    cleanTmpDir = true;

    extraModprobeConfig = ''
      options zfs zfs_arc_max=4294967296
      options zfs zfs_arc_meta_limit=536870912
      options zfs zfs_vdev_cache_size=268435456
      options zfs zfs_prefetch_disable=1
    '';
      
    initrd.luks.devices = [
      { 
        name = "nixroot";
        device = "/dev/disk/by-partlabel/cryptroot";
      }
    ];

    zfs.forceImportRoot = false;
    zfs.forceImportAll = false;
    supportedFilesystems = [ "zfs" ];
    initrd.luks.yubikeySupport = true;
  };

}

