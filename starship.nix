{ pkgs, home, ...}:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      hostname.ssh_symbol = "";
      username.format = "[$user]($style)@";
    };
  };
}
