final: prev: {
  icosystem = final.stdenv.mkDerivation {
    name = "icosystem";
    version = "v1.0.0";
    src = final.fetchFromGitea {
      domain = "git.depeuter.dev";
      owner = "tdpeuter";
      repo = "icosystem";
      rev = "ca565dc36d";
      hash = "sha256-GJu0APTkrsFH981Y1RBedOnvVJ5Z79w2WPcLkrc8CH0=";
    };

    installPhase = ''
      mkdir -p $out/share/icons
      cp -R $src $out/share/icons/icosystem
    '';
  };
}
