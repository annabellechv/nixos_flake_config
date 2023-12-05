# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, user, ... }:

{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      devices = [ "nodev" ];
      default = "saved";
      efiSupport = true;
      useOSProber = true;
      configurationLimit = 10;
    };
    timeout = 5;
  };

  # Allow unfree package  
  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "nixos"; 		# Define your hostname.
    networkmanager.enable = true;	# Enable networking
  };

  services = {
    printing.enable = true;		# Enable CUPS to print documents.

    blueman.enable = true;

    pipewire = {
      enable = true;

      alsa = { 
        enable = true;
        support32Bit = true;
      };

      pulse.enable = true;
    };

    xserver = {
      enable = true;			# Enable the X11 windowing system.
      layout = "us";
      xkbVariant = "altgr-intl";

      libinput = {
        enable = true; 			# Enable touchpad support.
      };

      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
  };

  programs.hyprland = {			# Enable hyprland on NixOS
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  security.pam.services.swaylock = {};	# Needed for unlock with swaylock
  # Enable sound with pipewire.
  sound.enable = true;
  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
  };
  security.rtkit.enable = true;

  nix = {
    settings = { 
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "video" "wheel" ];
    packages = with pkgs; [
     firefox
    ]; 
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    kitty
  ];

  time.timeZone = "Europe/Paris";	# Set your time zone.

  i18n.defaultLocale = "en_US.UTF-8";	# Select internationalisation properties.

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
