{ ... }:
let
  window = {
      padding.x = 2;
      padding.y = 5;
      title = "Alacritty";
      class.instance = "Alacritty";
      class.general = "Alacritty";
      opacity = 0.98;
  };

  colors-nord = rec {
    primary.background = "#2e3440";
    primary.foreground = "#d8dee9";
    primary.dim_foreground = "#a5abb6";

    cursor.text = primary.background;
    cursor.cursor = primary.foreground;

    vi_mode_cursor.text = primary.background;
    vi_mode_cursor.cursor = primary.foreground;

    selection.text = "CellForeground";
    selection.background = "#4c566a";

    search.matches.foreground = "CellBackground";
    search.matches.background = "#88c0d0";
    search.bar.background = "#434c5e";
    search.bar.foreground = "#d8dee9";

    normal.black = "#3b4252";
    normal.red = "#bf616a";
    normal.green = "#a3be8c";
    normal.yellow = "#ebcb8b";
    normal.blue = "#81a1c1";
    normal.magenta = "#b48ead";
    normal.cyan = "#88c0d0";
    normal.white = "#e5e9f0";

    dim.black = "#373e4d";
    dim.red = "#94545d";
    dim.green = "#809575";
    dim.yellow = "#b29e75";
    dim.blue = "#68809a";
    dim.magenta = "#8c738c";
    dim.cyan = "#6d96a5";
    dim.white = "#aeb3bb";

    bright.black = "#4c566a";
    bright.red = "#bf616a";
    bright.green = "#a3be8c";
    bright.yellow = "#ebcb8b";
    bright.blue = "#81a1c1";
    bright.magenta = "#b48ead";
    bright.cyan = "#8fbcbb";
    bright.white = "#eceff4";
  };

  key_bindings = map (x: { mods = "Alt|Shift"; } // x) [
    { key = "C"; action = "Copy"; }
    { key = "V"; action = "Paste"; }
    { key = "R"; action = "ResetFontSize"; }
    { key = "L"; action = "IncreaseFontSize"; }
    { key = "H"; action = "DecreaseFontSize"; }
    { key = "K"; action = "ScrollLineUp"; }
    { key = "J"; action = "ScrollLineDown"; }
  ];

in
{

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "alacritty";

      inherit window;

      colors = colors-nord;

      cursor.style = "Block";

      inherit key_bindings;
    };
  };

}