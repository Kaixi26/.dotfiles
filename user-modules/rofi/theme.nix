{ config, ... }:
let
  inherit (config.lib.formats.rasi) mkLiteral;

in {
  "*" = {
    al = mkLiteral "#00000000";
    bg = mkLiteral "#000000ff";
    se = mkLiteral "#101010ff";
    fg = mkLiteral "#FFFFFFff";
    ac = mkLiteral "#EC7875ff";
  };

  "configuration" = {
    font = "Iosevka Nerd Font 10";
    show-icons = true;
    icon-theme = "Papirus";
    display-drun = "";
    drun-display-format = "{name}";
    disable-history = false;
    sidebar-mode = false;
  };

  "window" = {
    transparency = "real";
    background-color = mkLiteral "@bg";
    text-color = mkLiteral "@fg";
    border = mkLiteral "0px";
    border-color = mkLiteral "@ac";
    border-radius = mkLiteral "12px";
    width = mkLiteral "35%";
    location = mkLiteral "center";
    x-offset = 0;
    y-offset = 0;
  };

  "prompt" = {
    enabled = true;
    padding = mkLiteral "0.30% 1% 0% -0.5%";
    background-color = mkLiteral "@al";
    text-color = mkLiteral "@bg";
    font = "FantasqueSansMono Nerd Font 12";
  };

  "entry" = {
      background-color = mkLiteral "@al";
      text-color = mkLiteral "@bg";
      placeholder-color = mkLiteral "@bg";
      expand = true;
      horizontal-align = 0;
      placeholder = "Search";
      padding = mkLiteral "0.10% 0% 0% 0%";
      blink = true;
  };

  "inputbar" = {
    children = map mkLiteral [ "prompt" "entry" ];
    background-color = mkLiteral "@ac";
    text-color = mkLiteral "@bg";
    expand = false;
    border = mkLiteral "0% 0% 0% 0%";
    border-radius = mkLiteral "0px";
    border-color = mkLiteral "@ac";
    margin = mkLiteral "0% 0% 0% 0%";
    padding = mkLiteral "1.5%";
  };

  "listview" = {
      background-color = mkLiteral "@al";
      padding = mkLiteral "10px";
      columns = 5;
      lines = 3;
      spacing = mkLiteral "0%";
      cycle = false;
      dynamic = true;
      layout = mkLiteral "vertical";
  };

  "mainbox" = {
    background-color = mkLiteral "@al";
    border = mkLiteral "0% 0% 0% 0%";
    border-radius = mkLiteral "0% 0% 0% 0%";
    border-color = mkLiteral "@ac";
    children = map mkLiteral [ "inputbar" "listview" ];
    spacing = mkLiteral "0%";
    padding = mkLiteral "0%";
  };

  "element" = {
    background-color = mkLiteral "@al";
    text-color = mkLiteral "@fg";
    orientation = mkLiteral "vertical";
    border-radius = mkLiteral "0%";
    padding = mkLiteral "2% 0% 2% 0%";
  };
  
  "element-icon" = {
    background-color = mkLiteral "inherit";
    text-color = mkLiteral "inherit";
    horizontal-align = mkLiteral "0.5";
    vertical-align = mkLiteral "0.5";
    size = mkLiteral "64px";
    border = mkLiteral "0px";
  };
  
  "element-text" = {
    background-color = mkLiteral "@al";
    text-color = mkLiteral "inherit";
    expand = mkLiteral "true";
    horizontal-align = mkLiteral "0.5";
    vertical-align = mkLiteral "0.5";
    margin = mkLiteral "0.5% 0.5% -0.5% 0.5%";
  };
  
  "element selected" = {
    background-color = mkLiteral "@se";
    text-color = mkLiteral "@fg";
    border = mkLiteral "0% 0% 0% 0%";
    border-radius = mkLiteral "12px";
    border-color = mkLiteral "@bg";
  };
}