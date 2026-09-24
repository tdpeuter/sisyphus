{
  boot = {
    kernelParams = [
      "mem_sleep_default=deep"
      "resume_offset=66637824"
    ];

    resumeDevice = "/dev/disk/by-uuid/e759b10f-7949-4094-9272-d91340dcc5b6";
  };

  powerManagement.enable = true;

  swapDevices = [{
    device = "/var/lib/swap";
    size = 37 * 1024;
    options = [ "discard" ];
  }];

  #systemd.sleep.extraConfig = ''
  #  HibernateDelaySec=30m
  #  SuspendState=mem
  #'';
}
