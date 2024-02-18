{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  sisyphus = {
    desktop.gnome.enable = true;

    hardware.nvidia = {
      enable = true;
      model = "RTX 2060";
      gui-settings = true;
    };

    networking = {
      networkmanager.enable = true;
      openconnect-sso.enable = true;
    };

    nix = {
      flakes.enable = true;
      gc.onFull.enable = true;
    };

    programs = {
      direnv.enable = true;
      home-manager.enable = true;
      sops.enable = true;
      ssh.enable = true;
    };

    services = {
      pipewire.enable = true;
      printing.enable = true;
      openrgb.enable = true;
    };

    users.tdpeuter.enable = true;

    virtualisation = {
      docker.enable = true;
      virtualbox.enable = true;
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    git
    vim-full
    w3m
    wget
    zenith-nvidia
  ];

  programs = {
    steam.enable = true;
    zsh.enable = true;
  };

  hardware.bluetooth.enable = true;

  networking.hostName = "Tibo-NixDesk";

  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
  };

  system.stateVersion = "23.11";

  time.timeZone = "Europe/Brussels";

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };
}
