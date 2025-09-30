# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  sisyphus = {
    desktop.hyprland.enable = true;

    hardware = {
      eid.enable = true;
      fingerprint-scanner.enable = true;
      nvidia = {
        enable = true;
        model = "Quadro T2000";
      };
      yubikey.enable = true;
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
      tailscale.enable = true;
    };

    users.tdpeuter.enable = true;

    virtualisation = {
      docker.enable = true;
      virtualbox.enable = true;
    };
  };

  boot = {
    initrd = {
      # Use EFI and YubiKey
      kernelModules = [ "vfat" "nls_cp437" "nls_iso8859-1" "usbhid" ];

      luks = {
        # Enable YubiKey PBA
        yubikeySupport = true;
        devices."encrypted".yubikey = {
          slot = 2;
          twoFactor = false;
          gracePeriod = 10;
          keyLength = 64;
          saltLength = 16;
          storage.device = "/dev/nvme0n1p1";
        };
      };
    };

    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot = {
        enable = true;

        editor = false;
        memtest86.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };

    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;

    plymouth.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  programs.zsh.enable = true;

  services = {
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };

    logind = {
      # Handle the laptop lid switch as follows:
      lidSwitch = "hybrid-sleep";
      lidSwitchExternalPower = "lock";
      lidSwitchDocked = "ignore";

      # Handle the power key
      powerKey = "suspend";
    };


    power-profiles-daemon.enable = false;

    smartd.enable = true;

    thermald.enable = true;

    xserver = {
      # Keyboard layout
      xkb = {
        layout = "us";
        variant = "altgr-intl";
      };
    };

    # Touchpad
    libinput.enable = true;
  };

  networking = {
    hostName = "Tibo-NixTop"; # Define your hostname.
  };

  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_GB.UTF-8"; # LANG
    extraLocaleSettings.LC_TIME = "nl_BE.UTF-8";
  };

  console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment = {
    # Enabled to allow installed binaries in ~/.local/bin
    localBinInPath = true;

    systemPackages = with pkgs; [
      git
      vim-full # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      w3m
      wget
      zenith-nvidia
    ];
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

