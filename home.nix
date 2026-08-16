{ config, pkgs, ... }:
{
  home.stateVersion = "26.05";

  home.packages = [
    pkgs.clang-tools
    pkgs.curl
    pkgs.fastfetch
    pkgs.htop
    pkgs.git-graph
  ];

  home.file = {
    ".config/starship.toml".source = ./starship/starship.toml;
    ".config/alacritty/alacritty.toml".source = ./alacritty/alacritty.toml;
  };

  home.sessionVariables = {
    RCUTILS_COLORIZED_OUTPUT = 1;
  };

  home.sessionPath = [
    "$HOME/bin"
  ];

  programs.alacritty = {
    enable = true;
  };
  programs.bash = {
    enable = true;

    bashrcExtra = ''
      source "${./bash/functions.sh}"
      if [[ -f "$HOME/.config/bash/local_aliases.sh" ]]; then
        source "$HOME/.config/bash/local_aliases.sh"
      fi
    '';

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";

      dotfiles = "cd ${config.home.homeDirectory}/.dotfiles";
      reloadrc = "source ~/.bashrc";

      dl = "cd ~/Downloads";
      dt = "cd ~/Desktop";
      doc = "cd ~/Documents";

      ls = "ls --color=auto";
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";

      vim = "nvim";
    };

    initExtra = ''
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
    '';
  };
  programs.lazygit = {
    enable = true;
    settings = {
      os = {
        editPreset = "nvim";
      };
    };
  };
  programs.nvchad = {
    enable = true;
    extraPackages = with pkgs; [
      black
      lua-language-server
      nixfmt
      stylua
      ripgrep
    ];
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.tmux = {
    enable = true;

    baseIndex = 1; # Start window numbering at 1 instead of 0
    newSession = true; # Automatically spawn a session if trying to attach and none exist
    escapeTime = 10; # Prevents delay when pressing Esc
    keyMode = "vi"; # Use vi keys in copy mode
    mouse = true; # Enable mouse support for scrolling and resizing

    # Install tmux plugins via Nix
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      vim-tmux-navigator
      {
        plugin = power-theme;
        extraConfig = "set -g @tmux_power_theme 'everforest'";
      }
    ];

    # Add custom, raw tmux configuration lines
    extraConfig = ''
      # Keybinds
      bind = setw synchronize-panes
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
