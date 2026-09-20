{ config, lib, ... }:

let
  cfg = config.services.my-mattermost;
in
{
  options.services.my-mattermost = {
    enable = lib.mkEnableOption "Mattermost";

    domain = lib.mkOption {
      type = lib.types.str;
      default = "localhost";
      example = "chat.example.com";
      description = "Domain name used for Mattermost.";
    };

    https.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable HTTPS for Mattermost.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.mattermost = {
      enable = true;

      siteUrl =
        if cfg.https.enable
        then "https://${cfg.domain}"
        else "http://${cfg.domain}";

      host = "127.0.0.1";
      port = 8065;

      database = {
        create = true;
        peerAuth = true;
        name = "mattermost";
        user = "mattermost";
        host = "localhost";
      };

      telemetry = {
        enableDiagnostics = false;
        enableSecurityAlerts = true;
      };
    };

    services.nginx = {
      enable = true;

      recommendedProxySettings = true;

      virtualHosts.${cfg.domain} = {
        forceSSL = cfg.https.enable;

        locations."/" = {
          proxyPass = "http://127.0.0.1:8065";
          proxyWebsockets = true;
        };
      };
    };
  };
}