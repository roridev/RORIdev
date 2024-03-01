# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Use X11 Instead of Wayland until either I switch from NVDA 
  # or NVDA *and* LWJGL supports it fully. 
  services.xserver.displayManager.gdm.wayland = false;

  # Configure keymap in X11
  services.xserver = {
    layout = "br";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

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
  # services.xserver.libinput.enable = true;

  hardware.opengl = {
     enable = true;
     driSupport = true;
     driSupport32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    forceFullCompositionPipeline = true;
    # Experimental, Fixes the Corruption BS
    powerManagement.enable = true;
  };
 
  # Set default shell as ZSH
  programs.zsh.enable = true;
  environment.shells = with pkgs; [zsh];

  # GnuPG
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alikindsys = {
    isNormalUser = true;
    description = "alikindsys";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
 };

  system.autoUpgrade = {
     enable = true;
     dates = "02:00";
     randomizedDelaySec = "5min";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.optimise = {
     automatic = true;
     dates = ["02:30"];
  };

  home-manager.users.alikindsys = {pkgs, ...} : {
     nixpkgs.config.allowUnfree = true;

     home.packages = with pkgs; [
      firefox
      thunderbird
      prismlauncher
      git
      rustup
      typst
      neovim
      zsh
      discord
      keepassxc
      obs-studio
      btop
      zoxide
      spotify
      eza
      jetbrains-toolbox
     ];
    
    programs.zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };

    programs.starship = {
      enable = true;
      settings = {
        add_newline = true;
        format = 
''
 $username[@](bg:#F5A9B8 fg:#333333)$hostname | ($nix_shell )$directory 
( $git_commit $git_branch ($git_state )($git_status )$git_metrics
)❯ '';
	username = {
          format = "[$user]($style)";
	  style_user = "bg:#5BCEFA fg:#333333";
	  style_root = "bg:#C9510C fg:#FAFAFA";
	  show_always = true;
	};
	directory = {
	  format = "([$read_only]($read_only_style) )[ $path]($style)";
	  style = "#F5A9B8";
	  before_repo_root_style = "#FAFAFA";
	  repo_root_style = "#5BCEFA";
	  read_only_style = "#C9510C";
	  read_only = "";
	  truncation_symbol = "<many>/";
	};
	hostname = {
          format = "[$ssh_symbol $hostname]($style)";
	  style = "bg:#FFFFFF fg:#333333";
	  ssh_only = false;
	  ssh_symbol = "";
	};
	git_commit = {
          format = "[ $hash]($style)";
	  style = "#4078C0";
	  commit_hash_length = 7;
	  only_detached = false;
	};
	git_state = {
	  disabled = false;
	  format = "$state [$progress_current](#4078C0) of [$progress_total](#6CC644)";
	  rebase = "[ REBASING](bg:#c9510c fg:#fafafa)";
	  merge = "[ MERGING](#c9510c)";
	  cherry_pick = "[ CHERRY](#D2042D)";
	  revert = "[REVERTING](#4078c0)";
	  bisect = "[BISECTING](#4078c0)";
	};
	git_branch = {
	  format = " $branch";
	  style = "#4078C0";
	};
	git_status = {
          format = "( ($conflicted )$ahead_behind)";
	  conflicted = "[](bg:#C9510C fg:#fafafa)";
	  ahead = "[$count](bg:#6cc644 fg:#fafafa)";
	  behind = "[$count](bg:#6cc644 fg:#fafafa)";
	  diverged = "[$ahead_count](bg:#6cc644 fg:#fafafa) [$behind_count](bg:#4078c0 fg:#fafafa)";
	  up_to_date = "[OK](fg:#6cc644)";
	};
	git_metrics = {
          disabled = false;
	  added_style = "#5BCEFA";
	  deleted_style = "#F5A9B8";
	};
      };
    };

    programs.git = {
      enable = true;
      userName = "alikindsys";
      userEmail = "alice@blocovermelho.org";
      aliases = {
        track = "add";
	untrack = "rm --cached";
	unstage = "reset HEAD -- ";
	reject = "restore --source=HEAD --staged --worktree -- ";
	discard = "restore -- ";
	staged = "diff --cached";
	unstaged = "diff";
	peek = "switch --detach";
	detach = "switch --detach HEAD^0";
	back = "switch \"-\"";
	unpulled = "range-diff @...@{u}";
	unpushed = "range-diff @{push}...@";
	trunklog = "log --oneline --graph --first-parent";
	branchlog = "!git log --oneline --graph $1^-";
      };
      extraConfig = {
        rebase.missingCommitCheck = "error";
        rerere = {
	  enabled = true;
	  autoUpdate = true;
        };
        diff.algorithm = "patience";
        pull.ff = "only";
        merge = {
	  ff = false;
	  conflictStyle = "diff3";
        };
        commit = {
          verbose = true;
        };
      };
    };

    programs.zsh = {
      enable = true;
      shellAliases = {
        glog="git log --oneline --graph";
        gloga="git log --oneline --graph --all";
        gss="git status --short";
	ls="eza";
	ll="eza -l";
      };
      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; tags =  [as:plugin]; }
          { name = "zsh-users/zsh-syntax-highlighting"; tags = [as:plugin]; }
          { name = "zsh-users/zsh-history-substring-search"; tags = [as:plugin]; }
          { name = "heapbytes/heapbytes-zsh"; tags = [as:theme depth:1]; }
	];
      };
    };
    
   # environment.shells = with pkgs; [zsh];

    home.stateVersion = "23.11";
  };
  
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["Iosevka" "FiraCode" "JetBrainsMono"]; })
  ];

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "alikindsys";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     jdk11
     jdk17
     jre8
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
