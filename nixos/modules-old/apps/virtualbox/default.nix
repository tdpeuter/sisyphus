{

    virtualisation.virtualbox = {
        host = {
            enable = true;
            enableExtensionPack = true;
        };
        guest = {
            enable = true;
            x11 = true;
        };
    };
    users.extraGroups.vboxusers.members = [
        "user-with-access-to-virtualbox"
    ];

}
