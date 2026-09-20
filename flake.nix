{
  description = "NixOS module for Mattermost";

  outputs = { self, ... }: {
    nixosModules = {
      mattermost = import ./mattermost.nix;
      default = self.nixosModules.mattermost;
    };
  };
}
