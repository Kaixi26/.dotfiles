{ ... }:
{
    services.redshift = {
        enable = true;

        temperature.day = 5500;
        temperature.night = 3700;

        latitude = 41.55;
        longitude = 8.42;

        tray = true;
    };
}