{ inputs, lib, config, pkgs, ... }:

let
  signatures = {
    default = ''
      Met vriendelijke groeten
      Tibo De Peuter
    '';
    UGent = ''
      Met vriendelijke groeten
      Tibo De Peuter
      
      Student 2Ba Informatica
    '';
    MrFortem = ''
      Kind regards
      MrFortem Fiducia
    '';
  };
in
{
  home-manager.users.tdpeuter = {
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

        realName = "Tibo De Peuter";
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

        realName = "Tibo De Peuter";
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

        realName = "Tibo De Peuter";
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
          showSignature = "attach";
          text = ''
            Kind regards
            MrFortem Fiducia
          '';
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

            "calendar.list.sortOrder" = "personal ugent tasks planning zeus";

            "calendar.registry.personal.cache.enabled" = true;
            "calendar.registry.personal.name" = "Personal";
            "calendar.registry.personal.type" = "caldav";
            "calendar.registry.personal.uri" = "https://cloud.depeuter.dev/remote.php/dav/calendars/tdpeuter/personal/";
            "calendar.registry.personal.username" = "tdpeuter";

            "calendar.registry.ugent.cache.enabled" = true;
            "calendar.registry.ugent.color" = "#1E64C8";
            "calendar.registry.ugent.name" = "UGent";
            "calendar.registry.ugent.type" = "caldav";
            "calendar.registry.ugent.uri" = "https://cloud.depeuter.dev/remote.php/dav/calendars/tdpeuter/ugent/";
            "calendar.registry.ugent.username" = "tdpeuter";

            "calendar.registry.planning.cache.enabled" = true;
            "calendar.registry.planning.name" = "Planning";
            "calendar.registry.planning.type" = "caldav";
            "calendar.registry.planning.uri" = "https://cloud.depeuter.dev/remote.php/dav/calendars/tdpeuter/planning/";
            "calendar.registry.planning.username" = "tdpeuter";

            "calendar.registry.zeus.cache.enabled" = true;
            "calendar.registry.zeus.color" = "#FF7F00";
            "calendar.registry.zeus.name" = "ZeusWPI";
            "calendar.registry.zeus.type" = "ics";
            "calendar.registry.zeus.uri" = "https://zeus.ugent.be/ical.ics";

            "calendar.registry.tasks.cache.enabled" = true;
            "calendar.registry.tasks.color" = "#813D9C";
            "calendar.registry.tasks.name" = "Tasks";
            "calendar.registry.tasks.type" = "caldav";
            "calendar.registry.tasks.uri" = "https://cloud.depeuter.dev/remote.php/dav/calendars/tdpeuter/tasks-2/";
            "calendar.registry.tasks.username" = "tdpeuter";
          };
        };
      };
    };
  };
}
