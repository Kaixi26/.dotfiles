{ lib, pkgs, ... }:
let
  colorschemes = with pkgs.vimPlugins; [
    { plugin = nord-nvim; config = "colorscheme nord"; }
    dracula-vim
    nvcode-color-schemes-vim
  ];
  status-bar = with pkgs.vimPlugins; [
    { plugin = galaxyline-nvim; config = "lua require('statusbar')"; }
      nvim-web-devicons
      barbar-nvim
  ];
  lsp = with pkgs.vimPlugins; [
    { plugin = nvim-lspconfig; config = "lua require('lsp')"; }
    lspsaga-nvim
    completion-nvim
    { plugin = nvim-treesitter; config = "lua require('tsitter')"; }
  ];
  telescope = with pkgs.vimPlugins; [
      telescope-nvim popup-nvim plenary-nvim telescope-fzy-native-nvim
  ];
  whichkey = with pkgs.vimPlugins; [
      which-key-nvim
  ];
in
{
  xdg.configFile = {
    "nvim/lua/config.lua".source = ./lua/config.lua;
    "nvim/lua/statusbar.lua".source = ./lua/statusbar.lua;
    "nvim/lua/lsp.lua".source = ./lua/lsp.lua;
    "nvim/lua/tsitter.lua".source = ./lua/tsitter.lua;
    "nvim/lua/whkey.lua".source = ./lua/whkey.lua;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraConfig = ''
      " Generated by home-manager
      " lua require('config')
    '';

    extraPackages = with pkgs; [
      ripgrep
    ];

    plugins = with pkgs.vimPlugins; [
      vim-polyglot
      #nvim-tree-lua
      nvim-colorizer-lua
    ] ++ lib.lists.flatten [
      colorschemes
      status-bar
      lsp
      telescope
      whichkey
    ];
  };
}