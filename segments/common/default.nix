let
  nur-source = builtins.fetchTarball {
    url = "https://github.com/nix-community/nur-combined/archive/79bf3bf95a287ebd13e6f9db7181d6b3ea0480cb.tar.gz";
    sha256 = "0si0lj6dinipfiqpnnmy3iac08r092alqppa14nc0apj4pl8z2rm";
  };
  nur-no-pkgs = import nur-source { };
  nur.modules = builtins.mapAttrs (_: r: r.modules) nur-no-pkgs.repos;
  nur.overlays = builtins.mapAttrs (_: r: r.overlays) nur-no-pkgs.repos;
in

rec {
  lib = {
    data.lourkeur.keys.ssh.nitrokey = ./id_gpgcard.pub;
    modules = {
      inherit (nur.modules.lourkeur) gnome3-fix-extra-layouts;
      mullvad-vpn = builtins.fetchurl {  # will be in upstream 20.09
        url = "https://raw.githubusercontent.com/xfix/nixpkgs/89f5dc24ed9b6aa15d8314b592184399081844ba/nixos/modules/services/networking/mullvad-vpn.nix";
        sha256 = "0jdhhck1x3r11db23xvl0ii51yp03rnvjbsqn034l48ga6glcics";
      };
    };
    overlays = {
      inherit (nur.overlays.lourkeur) patch-xpra;
    };
  };

  imports = with lib.modules; [
  ];
}
