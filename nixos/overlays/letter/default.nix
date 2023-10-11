final: prev: {
  letter = final.stdenv.mkDerivation {
    name = "letter";
    version = "v1.0.0";
    src = final.fetchFromGitea {
      domain = "git.depeuter.dev";
      owner = "tdpeuter";
      repo = "letter";
      rev = "v1.0.0";
      hash = "sha256-2HaXZMIYSauqj9Cy7rRzYGyuYLno9AHAXpWsyD+BdtE=";
    };

    installPhase = ''
      mkdir -p $out/share/fonts
      cp -R $src/ttf $out/share/fonts/letter
    '';
  };
}
