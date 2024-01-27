inputs:
{ config, lib, pkgs, ... }:
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
    environment = { systemPackages = [ inputs.hello.packages.${pkgs.system}.default ]; };
    systemd.services.hello = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.ExecStart =
        "${inputs.hello.packages.${pkgs.system}.default}/bin/hello -g'Hello, ${lib.escapeShellArg cfg.greeter}!'";
    };
  };
}
