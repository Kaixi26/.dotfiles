{ pkgs, ... }:
{
  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;
    config = {
      "colors" = {
        background = "#282A2E";
        background-alt = "#373B41";
        foreground = "#C5C8C6";
        primary = "#F0C674";
        secondary = "#8ABEB7";
        alert = "#A54242";
        disabled = "#707880";
      };
      "bar/top" = {
        monitor = "\${env:MONITOR:eDP-1}";
        width = "100%";
        height = "2.5%";
        line-size = "3";
        radius = 0;
        modules-left = "xworkspaces";
        modules-center = "date";
        modules-right = "pulseaudio cpu battery";
        separator = " | ";
        font-0 = "hack:size=8";
        tray-position = "right";
        padding-right = "5";
      };
      "module/date" = {
        type = "internal/date";
        internal = "60";
        date = "%d.%m.%y";
        time = "%H:%M";
        label = "%time% %date%";
      };
      "module/xworkspaces" = {
        type = "internal/xworkspaces";
        label-active = "%name%";
        label-active-background = "\${colors.background-alt}";
        label-active-underline= "\${colors.primary}";
        label-active-padding = "1";
        label-occupied = "%name%";
        label-occupied-padding = "1";
        label-urgent = "%name%";
        label-urgent-background = "\${colors.alert}";
        label-urgent-padding = "1";
        label-empty = "";
        label-empty-foreground = "\${colors.disabled}";
        label-empty-padding = "1";
      };
      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        format-volume-prefix = "VOL ";
        format-volume-prefix-foreground = "\${colors.primary}";
        format-volume = "<label-volume>";
        label-volume = "%percentage%%";
        label-muted = "muted";
        label-muted-foreground = "\${colors.disabled}";
      };
      "module/cpu" = {
        type = "internal/cpu";
        interval = "2";
        format-prefix = "CPU ";
        format-prefix-foreground = "\${colors.primary}";
        label = "%percentage:2%%";
      };
      "module/battery" = {
        type = "internal/battery";
        full-at = "99";
        battery = "BAT0";
        adapter = "ADP1";
        poll-interval = "5";
      };
    };
    script = ''
      polybar top &
    '';
  };
}
