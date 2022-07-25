{ pkgs, ...}:
{
  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + o ; {s, b, d}" = "{spotify, $BROWSER, discord}";
      "super + Return" = "$TERM";
      "super + d" = "rofi -show drun -modi run,drun";
      "{XF86MonBrightnessDown, XF86MonBrightnessUp}" = "light -{U,A} 5";
      "{XF86AudioRaiseVolume, XF86AudioLowerVolume}" = "pulsemixer --max-volume 100 --change-volume {+,-}5";
      "Print" = "flameshot gui";
    };
  };

  systemd.user.services.sxhkd = {
    Unit = {
      Description = "Simple X Hotkey Daemon";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.sxhkd}/bin/sxhkd";
      Restart="on-failure";
      RestartSec="5";
    };

    Install = { WantedBy = [ "graphical-session.target" ]; };
  };
}