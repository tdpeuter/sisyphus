final: prev: {
  spotify-adblock = final.rustPlatform.buildRustPackage rec {
    name = "spotify-adblock";
    version = "v1.0.3";
    src = final.fetchFromGitHub {
      owner = "abba23";
      repo = "spotify-adblock";
      rev = "5a3281d";
      sha256 = "sha256-UzpHAHpQx2MlmBNKm2turjeVmgp5zXKWm3nZbEo0mYE=";
    };

    cargoHash = "sha256-oHfk68mAIcmOenW7jn71Xpt8hWVDtxyInWhVN2rH+kk=";

    buildInputs = with final; [
      cargo
      rustc
    ];
  };
#  spotify-wrapper = final.writeScriptBin "spotify-with-adblock" ''
#    #!/bin/sh
#    LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify
#  '';
#  spotify = prev.spotify.overrideAttrs (something: rec {
#    installPhase = ''
#      echo no
#    '';

#    desktopItem = something.desktopItem.override (desktop: {
#      exec = "LD_PRELOAD=/usr/local/lib/spotify-adblock.so ${desktop.exec}";
#    });
#
#    installPhase = builtins.replaceString [
#      "${something.desktopItem}"
#    ] [
#      "${desktopItem}"
#    ] something.installPhase;
#  });
}
