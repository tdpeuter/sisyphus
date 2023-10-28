{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  sisyphus = {
    hardware.nvidia = {
      enable = true;
      model = "Quadro T2000";
    };

    programs = {
      home-manager.enable = true;
      sops.enable = true;
      ssh.enable = true;
    };

    services = {
      pipewire.enable = true;
      tailscale.enable = true;
    };

    users.tdpeuter.enable = true;
  };

  boot = {
    # Encryption
    initrd = {
      # Setup keyfile
      secrets."/crypto_keyfile.bin" = null;

      # Enable swap on luks
      luks.devices."luks-3825c43c-6cc4-4846-b1cc-02b5938640c9" = {
        device = "/dev/disk/by-uuid/3825c43c-6cc4-4846-b1cc-02b5938640c9";
        keyFile = "/crypto_keyfile.bin";
      };
    };

    # Use the systemd-boot EFI boot loader.]
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
    vim
    w3m
    wget
    zenith-nvidia
  ];

  programs = {
    zsh.enable = true;
  };

  hardware.bluetooth.enable = true;
  
  networking.hostName = "Tibo-NixFat";

  services = {
    # Handle the laptop lid switch as follows:
    logind = {
      lidSwitch = "hybrid-sleep";
      lidSwitchExternalPower = "lock";
      lidSwitchDocked = "ignore";
    };

    # Touchpad
    xserver.libinput.enable = true;
  };

  system.stateVersion = "23.05";

  time.timeZone = "Europe/Brussels";

  # --- Barrier ---

  networking = {
    networkmanager.enable = true;
  };

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
