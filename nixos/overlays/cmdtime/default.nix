final: prev: {
  cmdtime = final.stdenv.mkDerivation {
    name = "cmdtime";
    version = "v0.0.0";
    src = final.fetchFromGitHub {
      owner = "tom-auger";
      repo = "cmdtime";
      rev = "ffc72641dcfa0ee6666ceb1dc712b61be30a1e8b";
      hash = "sha256-v6wCfNoPXDD3sS6yUYE6lre8Ir1yJcLGoAW3O8sUOCg=";
    };

    installPhase = ''
      mkdir -p $out/share/cmdtime
      cp $src/cmdtime.plugin.zsh $out/share/cmdtime/cmdtime.plugin.zsh
    '';
  };
}
