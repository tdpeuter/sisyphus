{ config, lib, ... }:

{
  imports = [
    ./tdpeuter
  ];

  options.sisyphus.users.wantedGroups = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    example = [ config.users.groups.wheel.name ];
    description = "Groups to which a user should be added";
  };
}
