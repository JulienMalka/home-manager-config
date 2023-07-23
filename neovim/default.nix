{ pkgs, home, ... }:
let
  onedarker = pkgs.vimUtils.buildVimPlugin {
    pname = "onedarker";
    version = "1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "lunarvim";
      repo = "onedarker.nvim";
      rev = "2d02768b6801d0acdef7f6e1ac8db0929581d5bc";
      sha256 = "sha256-admAB4ybJpN/4+MtZd9CEQKZEq8nBZJsLiB6gUUylrc=";
    };
  };
  coc-ccls = pkgs.vimUtils.buildVimPlugin {
    pname = "coc-ccls";
    version = "0.0.5";
    src = pkgs.fetchFromGitHub {
      owner = "Maxattax97";
      repo = "coc-ccls";
      rev = "9337fcd75b833d42aa9940dc8f5e2233c9ea6a97";
      sha256 = "sha256-yETLuSLSL47hxGh05tQyDTczk+N/M34tNNhyHVF45t0=";
    };
  };


  git-conflicts = pkgs.vimUtils.buildVimPlugin {
    pname = "git-conflicts";
    version = "2023-02-22";
    src = pkgs.fetchFromGitHub {
      owner = "akinsho";
      repo = "git-conflict.nvim";
      rev = "v1.0.0";
      sha256 = "sha256-tBKGjzKK/SftivTgdujk4NaIxz8sUNyd9ULlGKAL8x8=";
    };
  };
in
{
  home.sessionVariables = { EDITOR = "vim"; };

  home.packages = with pkgs; [ nixfmt git fd tree-sitter gh ripgrep ccls ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    coc = {
      enable = true;
      settings = {
        rust-analyzer.enable = true;
        rust-analyzer.cachePriming.enable = true;
        rust-analyzer.cargo.allFeatures = true;
        rust-analyzer.checkOnSave.allTargets = true;
        rust-analyzer.procMacro.enable = true;

        coc.preferences.formatOnSaveFiletypes = [ "nix" "rust" "sql" ];
        languageserver = {
          nix = {
            command = "rnix-lsp";
            filetypes = [
              "nix"
            ];
          };
          ccls = {
            command = "ccls";
            filetypes = [ "c" "cpp" "objc" "objcpp" ];
            rootPatterns = [ ".ccls" "compile_commands.json" ".vim/" ".git/" ".hg/" ];
            initializationOptions = {
              cache = {
                directory = "/tmp/ccls";
              };
            };
          };
        };
      };
    };

    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      #theme
      onedarker

      # LSP
      nvim-lspconfig

      plenary-nvim

      #Telescope
      telescope-nvim

      nvim-web-devicons


      git-conflicts

      (nvim-treesitter.withPlugins (ps: with ps; [
        tree-sitter-nix
        tree-sitter-python
      ]))


      bufferline-nvim
      nvim-colorizer-lua
      pears-nvim
      nvim-tree-lua

      vim-lastplace
      vim-nix
      vim-nixhash
      vim-yaml
      vim-toml
      vim-airline
      vim-devicons
      zig-vim
      vim-scriptease
      semshi
      coc-prettier
      coc-rust-analyzer
      coc-ccls
      rust-vim
    ];

    extraPackages = with pkgs; [ rust-analyzer rnix-lsp ];

    extraConfig = ''
      luafile ${./settings.lua}
    '';
  };
}
