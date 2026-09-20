# Mattermost NixOS Module

A simple NixOS module for deploying [Mattermost](https://mattermost.com/) with PostgreSQL and NGINX.

## Features

* Mattermost via the native NixOS service
* PostgreSQL database
* NGINX reverse proxy
* WebSocket support
* Optional HTTPS configuration
* Privacy-focused defaults
* Declarative configuration

## Usage

Add the module to your NixOS flake:

```nix
mattermost.url = "git+ssh://git@github.com/shh-k/mattermost-nixos-module.git";
```

Import it:

```nix
mattermost.nixosModules.mattermost
```

Enable it in `configuration.nix`:

```nix
services.my-mattermost = {
  enable = true;

  # Your domain
  domain = "localhost";

  # Enable when HTTPS is configured
  https.enable = false;
};
```

Then rebuild:

```bash
sudo nixos-rebuild switch --flake .#desktop
```

The module configures Mattermost to listen on `127.0.0.1:8065` and NGINX to proxy requests to it.

## Requirements

* NixOS with flakes enabled
* NixOS 26.05 or newer
* A domain if using HTTPS or external access

## Repository

This module is independently maintained from the NixOS configuration that consumes it.
