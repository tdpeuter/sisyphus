{ config, lib, pkgs, pkgs-unstable, ... }:

let
  cfg = config.sisyphus.users.tdpeuter;
  user = config.users.users.tdpeuter.name;
  signatures = {
    default = ''
      Met vriendelijke groeten
      Tibo De Peuter
    '';
    UGent = ''
      Met vriendelijke groeten
      Tibo De Peuter
      
      Student 2Ba/3Ba Informatica
    '';
    MrFortem = ''
      Kind regards
      MrFortem Fiducia
    '';
  };
in {
  config = lib.mkIf cfg.enable {
    home-manager.users.tdpeuter = lib.mkIf config.sisyphus.programs.home-manager.enable {
      accounts.email.accounts = {
        Telenet = {
          address  = "tibo.depeuter@telenet.be";
          userName = "tibo.depeuter@telenet.be";
          imap = {
            host = "imap.telenet.be";
            port = 993;
            tls.enable = true;
          };
          smtp = {
            host = "smtp.telenet.be";
            port = 587;
            tls = {
              enable = true;
              useStartTls = true;
            };
          };

          realName = config.users.users.tdpeuter.description;
          signature = {
            showSignature = "append";
            text = signatures.default;
          };

          primary = true;
          thunderbird = {
            enable = true;
            settings = id: {
              "mail.identity.id_${id}.htmlSigText" = signatures.default;
            };
          };
        };
        UGent = {
          flavor = "outlook.office365.com";
          address = "tibo.depeuter@ugent.be";

          realName = config.users.users.tdpeuter.description;
          signature = {
            showSignature = "append";
            text = signatures.UGent;
          };

          thunderbird = {
            enable = true;
            settings = id: {
              "mail.server.server_${id}.authMethod" = 10;
              "mail.smtpserver.smtp_${id}.authMethod" = 10;
              "mail.identity.id_${id}.htmlSigText" = signatures.UGent;
            };
          };
        };
        Gmail = {
          flavor = "gmail.com";
          address = "tibo.depeuter@gmail.com";

          realName = config.users.users.tdpeuter.description;
          signature = {
            showSignature = "append";
            text = signatures.default;
          };
          thunderbird = {
            enable = true;
            settings = id: {
              "mail.identity.id_${id}.htmlSigText" = signatures.default;
            };
          };

        };
        MrFortem = {
          flavor = "gmail.com";
          address = "fortemfiducia@gmail.com";

          realName = "Fortem Fiducia";
          signature = {
            showSignature = "append";
            text = signatures.MrFortem;
          };

          thunderbird = {
            enable = true;
            settings = id: {
              "mail.server.server_${id}.directory" = ".thunderbird/tdpeuter/ImapMail/imap.gmail.com-mrfortem";
              "mail.server.server_${id}.directory-rel" = "[ProfD]ImapMail/imap.gmail.com-mrfortem";
              "mail.identity.id_${id}.htmlSigText" = signatures.MrFortem;
            };
          };
        };
      };

      programs = {
        thunderbird = {
          enable = true;
          profiles.tdpeuter = {
            isDefault = true;
            settings = {
              "mailnews.default_sort_order" = 2; # Sort descending
              "mailnews.mark_message_read.delay" = true;
              "mailnews.start_page.enabled" = false;
              "mail.pane_config.dynamic" = 2; # Vertical view
            };
          };
        };
      };
    };
  };
}
