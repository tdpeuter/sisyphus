{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  sisyphus = {
    hardware.nvidia = {
      enable = true;
      model = "RTX 2060";
    };

    networking.openconnect-sso.enable = true;

    programs = {
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

    virtualisation.virtualbox.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    w3m
    wget
    zenith-nvidia
  ];

  programs.zsh.enable = true;

  hardware.bluetooth.enable = true;

  networking = {
    hostName = "Tibo-NixDesk";
    networkmanager.enable = true;
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  };

  system.stateVersion = "23.05";

  time.timeZone = "Europe/Brussels";

  nix = {
    # Allow Nix Flakes
    # Keep derivations so shells don't break (direnv)
    # If the disk has less than 100MiB, free up to 2GiB by garbage-collecting.
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (2048 * 1024 * 1024)}
    '';
    # Scheduled garbage-collect
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    package = pkgs.nixFlakes;
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };
}
