inputs:
{ config, lib, ... }:
let
  cfg = config.services.hello;
  system = "x86_64-linux";
in {
  options.services.hello = {
    enable = lib.mkEnableOption "hello service";
    greeter = lib.mkOption {
      type = lib.types.str;
      default = "world";
    };
  };

  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = [ inputs.hello.packages.${system}.default ];
    };
    systemd.services.hello = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.ExecStart =
        "${inputs.hello.packages.${system}.default}/bin/hello -g'Hello, ${
          lib.escapeShellArg cfg.greeter
        }!'";
    };
  };
}
