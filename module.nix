inputs:
{ config, lib, pkgs, ... }:
let
  # Shorter name to access final settings a 
  # user of hello.nix module HAS ACTUALLY SET.
  # cfg is a typical convention.
  cfg = config.services.hello;
in {
  # Declare what settings a user of this "hello.nix" module CAN SET.
  options.services.hello = {
    enable = lib.mkEnableOption "hello service";
    greeter = lib.mkOption {
      type = lib.types.str;
      default = "world";
    };
  };

  # Define what other settings, services and resources should be active IF
  # a user of this "hello.nix" module ENABLED this module 
  # by setting "services.hello.enable = true;".
  config = lib.mkIf cfg.enable {
    environment = { systemPackages = [ pkgs.hello ]; };
    systemd.services.hello = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.ExecStart =
        "${pkgs.hello}/bin/hello -g'Hello, ${lib.escapeShellArg cfg.greeter}!'";
    };
  };
}
