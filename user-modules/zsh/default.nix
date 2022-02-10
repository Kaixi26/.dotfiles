{ ... }:
{
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    history.path = ".cache/zsh/history";
    history.share = false;
    initExtra = ''
      autoload -U colors && colors
      PS1="%B%{$fg[magenta]%}%1~ ⊨%{$reset_color%}%b "
      PATH=$PATH:~/.dotfiles/scripts/
    '';
    shellAliases = {
      v = "nvim";
    };
    profileExtra = ''
    '';
  };
}