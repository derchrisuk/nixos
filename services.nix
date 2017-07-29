{ config, pkgs, ... }:

{

  services = {
    openssh.enable = true;
    openssh.forwardX11 = true;
    xserver.enable = true;
    xserver.layout = "us";
    xserver.xkbOptions = "eurosign:e";
    xserver.synaptics.enable = false;
    xserver.startDbusSession = true;
    
    xserver.windowManager.i3 = {
      enable = true;
      configFile = /home/derchris/.config/i3/config;
    };

    xserver.displayManager.slim = {
      enable = true;
      defaultUser = "derchris";
      extraConfig = ''
        sessionstart_cmd    ${pkgs.xorg.sessreg}/bin/sessreg -a -l tty$(fgconsole) %user
        sessionstop_cmd     ${pkgs.xorg.sessreg}/bin/sessreg -d -l tty$(fgconsole) %user
      '';
    };

    locate = {
      enable = true;
      interval = "daily";
    };

    zfs.autoSnapshot = {
      enable = true;
      flags = "-k -p --utc";
    };

    logind.extraConfig = ''
      HandleLidSwitch=ignore
      HandlePowerKey=suspend
      KillUserProcesses=yes
      KillExcludeUsers=derchris
    '';

    printing.enable = true;
    printing.gutenprint = true;
    cron.enable = true;
    fprintd.enable = true;

    journald.extraConfig = ''
      SystemMaxUse=2G
    '';

    haveged.enable = true;
    thermald.enable = false;

    acpid = {
      enable = true;
      lidEventCommands = ''
        if grep -q closed /proc/acpi/button/lid/LID/state; then
          date >> /tmp/i3lock.log
          scrot /tmp/screen_locked.png
          mogrify -scale 10% -scale 1000% /tmp/screen_locked.png
          DISPLAY=":0.0" XAUTHORITY=/home/derchris/.Xauthority ${pkgs.i3lock}/bin/i3lock -i /tmp/screen_locked &>> /tmp/i3lock.log
          systemctl suspend
        fi
      '';
    };

    tlp = {
      enable = true;
      extraConfig = ''
        START_CHARGE_THRESH_BAT0=75
        STOP_CHARGE_THRESH_BAT0=90
      '';
    };

    ntp.enable = false;

    chrony = {
      enable = true;
      servers = ["0.de.pool.ntp.org" "1.de.pool.ntp.org" ];
    };

    nscd.enable = false;

    redshift = {
      enable = true;
      latitude = "48";
      longitude = "11";
      temperature = {
        day = 3500;
        night = 3500;
      };
      brightness = {
        day = "1.0";
        night = "0.7";
      };
    };

    pcscd.enable = true;
    #dbus.packages = [ pkgs.gnome.GConf ];

    udev.extraRules = ''
      ACTION!="add|change", GOTO="u2f_end"
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0113|0114|0115|0116|0120|0402|0403|0406|0407|0410", MODE="0660", GROUP="users", TAG+="uaccess"
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="f1d0", TAG+="uaccess"
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1e0d", ATTRS{idProduct}=="f1d0", TAG+="uaccess"
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="096e", ATTRS{idProduct}=="0880", TAG+="uaccess"
      LABEL="u2f_end"
    '';

    synergy = {
        client.enable = true;
        client.autoStart = false;
        client.screenName = "box";
        client.serverAddress = "192.168.1.16:24800";
    };

    #actkbd = {
    #  enable = true;
    #  bindings = [
    #    { keys = [ 113 ]; events = [ "key" ]; command = "${pkgs.alsaUtils}/bin/amixer -q set Master toggle"; }
    #    { keys = [ 114 ]; events = [ "key" "rep" ]; command = "${pkgs.alsaUtils}/bin/amixer -q set Master ${config.sound.mediaKeys.volumeStep}- unmute"; }
    #    { keys = [ 115 ]; events = [ "key" "rep" ]; command = "${pkgs.alsaUtils}/bin/amixer -q set Master ${config.sound.mediaKeys.volumeStep}+ unmute"; }
    #  ];
    #};
  };

}

