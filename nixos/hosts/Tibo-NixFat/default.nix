{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware/nvidia.nix

    ../../modules/apps/virtualbox
    ../../modules/des/gnome
  ];
  
  boot = {
    # Use the systemd-boot EFI boot loader.]
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };

    initrd = {
      # Setup keyfile
      secrets."/crypto_keyfile.bin" = null;

      # Enable swap on luks
      luks.devices."luks-3825c43c-6cc4-4846-b1cc-02b5938640c9" = {
        device = "/dev/disk/by-uuid/3825c43c-6cc4-4846-b1cc-02b5938640c9";
        keyFile = "/crypto_keyfile.bin";
      };
    };
  };

  networking = {
    hostName = "Tibo-NixFat";
    networkmanager.enable = true;
  };
  
  # Set your time zone.
  time.timeZone = "Europe/Brussels";
  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
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

  # Enable Bluetooth.
  hardware.bluetooth.enable = true;
  
  services = {
    logind = {
      lidSwitch = "hybrid-sleep";
      lidSwitchExternalPower = "lock";
      lidSwitchDocked = "ignore";
    };

    # Enable touchpad support (enabled default in most desktopManager).
    xserver = {
      libinput.enable = true;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
  
  system.stateVersion = "23.05";
}

