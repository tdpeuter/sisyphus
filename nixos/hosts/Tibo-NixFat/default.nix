{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules-old/hardware/nvidia.nix
  ];

  sisyphus = {
    users.tdpeuter.enable = true;

    programs = {
      home-manager.enable = true;
      sops.enable = true;
      ssh.enable = true;
      zellij.enable = true;
    };
    services = {
      desktop.gnome.enable = true;
      printing.enable = true;
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
    vim
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
  };

  system.stateVersion = "23.05";

  time.timeZone = "Europe/Brussels";

  # --- Barrier ---

  networking = {
    networkmanager.enable = true;
  };
  
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver = {
    libinput.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
