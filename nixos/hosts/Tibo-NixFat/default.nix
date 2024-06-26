{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  sisyphus = {
    desktop.sway.enable = true;

    hardware = {
      eid.enable = true;
      nvidia = {
        enable = true;
        model = "Quadro T2000";
      };
      yubikey.enable = true;
    };

    networking = {
      networkmanager.enable = true;
      # openconnect-sso.enable = true;
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
      tailscale.enable = true;
    };

    users.tdpeuter.enable = true;

    virtualisation = {
      docker.enable = true;
      virtualbox.enable = true;
    };
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
    vim-full
    w3m
    wget
    zenith-nvidia
  ];

  programs = {
    zsh.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  
  networking.hostName = "Tibo-NixFat";

  services = {
    # Handle the laptop lid switch as follows:
    logind = {
      lidSwitch = "hybrid-sleep";
      lidSwitchExternalPower = "lock";
      lidSwitchDocked = "ignore";
    };

    xserver.xkb = {
      # Keyboard layout
      layout = "us";
      variant = "altgr-intl";
    };

    # Touchpad
    libinput.enable = true;
  };

  system.stateVersion = "24.05";

  time.timeZone = "Europe/Brussels";

  # --- Barrier ---

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    useXkbConfig = true; # use xkbOptions in tty.
  };
}
