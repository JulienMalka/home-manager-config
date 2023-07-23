{ config, pkgs, lib, ... }:

{
  imports = [
    ./neovim
    ./starship.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jmalka";
  home.homeDirectory = "/home/infres/jmalka";

  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.nerdfonts
    pkgs.fira-code
    pkgs.fira-code-symbols
    pkgs.font-awesome
  ];

  programs.git = {
    enable = true;
    userName = "Julien Malka";
    userEmail = "julien@malka.sh";
  };

  programs.lazygit.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      export PATH=$PATH:$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin/
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

