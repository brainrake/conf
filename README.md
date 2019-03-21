# configuration files

## boostrap

on a fresh NixOS install,
- `git clone` this repo
- edit `/etc/nixos/configuration.nix` and import eg. `/root/conf/etc/nixos/configuration.nix`
- `nixos-rebuild switch`


## setup

somewhere in your home directory
- `git clone` this repo
- edit `/etc/nixos/configuration.nix` and change the import to eg. `/home/ssdd/conf/etc/nixos/configuration.nix`
- `nixos-rebuild switch`

```
./link-home
```
