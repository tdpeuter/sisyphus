{ config, lib, pkgs, ... }:

{
    home = {
        packages = with pkgs; [
            font-awesome
        ];

        file = {
            ".oh-my-zsh".source = ../../../../stow/zsh/.oh-my-zsh;
        };
    };

    programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableSyntaxHighlighting = true;
        history = {
            expireDuplicatesFirst = true;
            extended = true;
        };
        initExtra = ''
            eval "$(direnv hook zsh)"
        '';
        oh-my-zsh = {
            enable = true;
            custom = "$HOME/.oh-my-zsh";
            plugins = [
                "dirhistory"
                "git"
                "screen"
            ];
            theme = "mrfortem";
        };
        plugins = [
            {
                name = "cmdtime";
                src = pkgs.fetchFromGitHub {
                    owner  = "tom-auger";
                    repo   = "cmdtime";
                    rev    = "ffc72641dcfa0ee6666ceb1dc712b61be30a1e8b";
                    hash = "sha256-v6wCfNoPXDD3sS6yUYE6lre8Ir1yJcLGoAW3O8sUOCg=";
                };
            }
        ];
        shellAliases = {
            cp    = "cp -i"; # Confirm before overwriting something
            df    = "df -h";
            free  = "free -m";
            ll    = "ls -la";
            np    = "nano -w PKGBUILD";
            more  = "less";
            hgrep = "history | grep";

            gs    = "git status";
            
            update = ''
                pushd ~/projects/sisyphus/nixos
                nix flake update
                sudo nixos-rebuild switch --flake .# --show-trace
                popd
            '';
            uu = "update-user";
            update-user = ''
                pushd ~/projects/sisyphus/nixos
                nix build .#homeManagerConfigurations.tdpeuter.activationPackage
                ./result/activate
                popd
            '';
        };
    };
}
