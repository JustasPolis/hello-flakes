{ config, lib, pkgs }:
let cfg = config.services.hello;
in {
  options.services.hello = {
    enable = lib.mkEnableOption "hello service";
    greeter = lib.mkOption {
      type = lib.types.str;
      default = "world";
    };
  };

  config = lib.mkIf cfg.enable {
    environment = { systemPackages = [ pkgs.hello ]; };
    systemd.services.hello = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.ExecStart =
        "${pkgs.hello}/bin/hello -g'Hello, ${lib.escapeShellArg cfg.greeter}!'";
    };
  };
}
