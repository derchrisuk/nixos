{ config, pkgs, ... }:

{

  networking = {
    hostId = "01d376a7";
    hostName = "box";
    wireless = {
        enable = true;
        userControlled.enable = true;
        userControlled.group = "wheel";
        networks = {
          "kackbratze_2.4GHz" = {
            pskRaw = "94618f87ae9e253d7cd427ec676fbbf6d40fb7a7b1b8a2ec9b7b360b1b5a4a16";
            priority = 30;
          };
          "kackbratze_5GHz" = {
            pskRaw = "637e9e937801443455b299a9e1686e18d3c4266c52a3230bd1173b81b04b1f1d";
            priority = 40;
          };
          "muccc.legacy-2.4GHz" = {
            pskRaw = "ce4000df1aa355d20f83a5604ec89d99cb78e1815c0cf33ea4547fc67370a494";
            priority = 10;
          };
          "muccc.legacy-5GHz" = {
            pskRaw = "ecbf794fae3beff2d77700727fdd18cca86229264a6614c2fe8530af5a3cc579";
            priority = 20;
          };
          "muenchen.freifunk.net" = { 
            priority = 5;  
          };
        };
        interfaces = [ "wlp2s0" ];
    };
    networkmanager.enable = false;
    firewall.enable = false;
    firewall.allowedTCPPorts = [ 22 ];
    firewall.allowedUDPPorts = [ 53 ];
    connman.enable = true;
  };

}

