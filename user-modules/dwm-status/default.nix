{ pkgs, ... }:
{

  
  home.packages = [ pkgs.dwm-status ];
  services.dwm-status = {
    enable = true;
    extraConfig = {
      separator = "  ";
      time.format = "%H:%M";
      cpu_load.template = "CPU {CL1}%";
      audio.template = "墳 {VOL}%";
      battery.update_interval = 60;
    };
    order = [ "audio" "cpu_load" "battery" "time" ];
  };
}