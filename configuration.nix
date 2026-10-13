{ config, pkgs, ... }:

{
  # ============================================================================
  # Imports
  # ============================================================================

  imports = [
    ./hardware-configuration.nix
    ./partitions.nix
    ./steam
  ];

  # Home Manager configuration for the main user.
  home-manager.users.matuz = import ./home/matuz.nix;


  # ============================================================================
  # Bootloader
  # ============================================================================

  boot.loader = {
    # Allow NixOS to modify EFI boot variables.
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;

      # "nodev" is used because GRUB is installed in EFI mode.
      device = "nodev";

      # Enable GRUB's EFI support.
      efiSupport = true;

      # Automatically detect other operating systems, such as Windows.
      useOSProber = true;

      # Keep only the 5 most recent generations in the GRUB menu.
      configurationLimit = 5;
    };
  };


  # ============================================================================
  # Nix
  # ============================================================================

  nix = {
    # Enable the modern nix command and flakes.
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Automatically clean old Nix store generations once a week.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5d";
    };
  };

  # Allow dynamically linked binaries to run through Nix's compatibility layer.
  programs.nix-ld.enable = true;

  # Allow packages with unfree licenses (e.g. proprietary software).
  nixpkgs.config.allowUnfree = true;


  # ============================================================================
  # Networking
  # ============================================================================

  networking = {
    # Hostname shown on the network and in the shell prompt.
    hostName = "nixos";

    # NetworkManager handles Ethernet and Wi-Fi connections.
    networkmanager.enable = true;

    # Uncomment if you need a proxy:
    #
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Uncomment if you want to configure Wi-Fi using wpa_supplicant
    # instead of NetworkManager.
    #
    # wireless.enable = true;
  };


  # ============================================================================
  # Localization
  # ============================================================================

  # Time zone used by the system.
  time.timeZone = "America/Santarem";

  # Default locale.
  i18n.defaultLocale = "en_US.UTF-8";

  # Use Brazilian Portuguese for region-specific formatting while keeping
  # English as the primary language.
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT    = "pt_BR.UTF-8";
    LC_MONETARY       = "pt_BR.UTF-8";
    LC_NAME           = "pt_BR.UTF-8";
    LC_NUMERIC        = "pt_BR.UTF-8";
    LC_PAPER          = "pt_BR.UTF-8";
    LC_TELEPHONE      = "pt_BR.UTF-8";
    LC_TIME           = "en_US.UTF-8";
  };


  # ============================================================================
  # Keyboard
  # ============================================================================

  # Keyboard layout used by X11.
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


  # ============================================================================
  # User Account
  # ============================================================================

  users.users.matuz = {
    isNormalUser = true;
    description = "Matuz";

    # networkmanager - manage network connections
    # wheel         - allows sudo access
    extraGroups = [
      "networkmanager"
      "wheel"
    ];

    # Additional packages installed specifically for this user.
    packages = with pkgs; [];

    # Default shell.
    shell = pkgs.zsh;
  };

  # Automatically log in as Matuz on the first virtual console.
  services.getty.autologinUser = "matuz";


  # ============================================================================
  # Shell
  # ============================================================================

  programs.zsh.enable = true;


  # ============================================================================
  # Desktop Environment / Window Manager
  # ============================================================================

  programs.hyprland = {
    enable = true;

    # UWSM is disabled. Enable this if you decide to manage Hyprland
    # sessions through Universal Wayland Session Manager.
    withUWSM = false;

    # Enable XWayland so X11 applications can run under Hyprland.
    xwayland.enable = true;
  };


  # ============================================================================
  # System Packages
  # ============================================================================

  environment.systemPackages = with pkgs; [
    wget
  ];

  # ============================================================================
  # Optional Services
  # ============================================================================

  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;

  home.packages = with pkgs; [
    libsecret
  ];
  
  # ============================================================================
  # Optional Programs / Services
  # ============================================================================

  services.gvfs.enable = true;
  services.tumbler.enable = true;
  
  # # ============================================================================
  # NixOS State Version
  # ============================================================================

  # This determines the default behavior for stateful data and compatibility.
  #
  # IMPORTANT:
  # Do not change this just because you upgrade NixOS. Keep it at the version
  # from which the system was originally installed unless you specifically
  # understand the consequences of changing it.
  system.stateVersion = "26.05";
}
